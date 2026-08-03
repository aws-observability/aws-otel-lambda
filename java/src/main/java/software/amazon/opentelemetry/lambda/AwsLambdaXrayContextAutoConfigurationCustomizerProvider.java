/*
 * Copyright Amazon.com, Inc. or its affiliates.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package software.amazon.opentelemetry.lambda;

import io.opentelemetry.api.trace.Span;
import io.opentelemetry.context.Context;
import io.opentelemetry.context.propagation.TextMapGetter;
import io.opentelemetry.context.propagation.TextMapPropagator;
import io.opentelemetry.context.propagation.TextMapSetter;
import io.opentelemetry.sdk.autoconfigure.spi.AutoConfigurationCustomizer;
import io.opentelemetry.sdk.autoconfigure.spi.AutoConfigurationCustomizerProvider;
import java.util.Collection;
import java.util.Collections;
import java.util.Locale;
import java.util.Map;

/**
 * Links spans created by the OTel Lambda SDK "wrapper" layer to the X-Ray trace of the enclosing
 * Lambda invocation.
 *
 * <p>On the managed Java 17+ Lambda runtimes the per-invocation X-Ray trace header is exposed via
 * the {@code com.amazonaws.xray.traceHeader} system property rather than the {@code
 * _X_AMZN_TRACE_ID} environment variable that older OTel Lambda instrumentation reads. Without this
 * customizer the wrapper root span gets a fresh (X-Ray-compatible) trace id from {@link
 * software.amazon.opentelemetry.lambda.AwsOtelTracerProviderConfigurer}, so downstream spans land
 * in a trace that is disconnected from the invocation's X-Ray trace.
 *
 * <p>This customizer wraps every configured propagator. During {@code extract} it first runs the
 * normal propagation from the event carrier (for example API Gateway headers). If that yields a
 * valid remote parent it is preserved. Otherwise it reads the X-Ray trace-header system property
 * and presents it to the same configured propagators as a synthetic {@code X-Amzn-Trace-Id} header,
 * delegating the actual parsing to the already-configured X-Ray propagator. This adds no new
 * runtime dependency: the wrapper layer supplies and (by default) configures the X-Ray propagator
 * via {@code OTEL_PROPAGATORS}.
 *
 * <p>This extension jar is only packaged into the wrapper layer, so the javaagent layer (which
 * wires X-Ray propagation through bytecode instrumentation) is unaffected.
 */
public final class AwsLambdaXrayContextAutoConfigurationCustomizerProvider
    implements AutoConfigurationCustomizerProvider {

  static final String TRACE_HEADER_PROPERTY = "com.amazonaws.xray.traceHeader";
  private static final String TRACE_HEADER_KEY = "x-amzn-trace-id";

  @Override
  public void customize(AutoConfigurationCustomizer autoConfiguration) {
    autoConfiguration.addPropagatorCustomizer(
        (propagator, config) -> new LambdaXraySystemPropertyPropagator(propagator));
  }

  static final class LambdaXraySystemPropertyPropagator implements TextMapPropagator {
    private static final TextMapGetter<Map<String, String>> MAP_GETTER =
        new TextMapGetter<Map<String, String>>() {
          @Override
          public Iterable<String> keys(Map<String, String> carrier) {
            return carrier.keySet();
          }

          @Override
          public String get(Map<String, String> carrier, String key) {
            if (carrier == null) {
              return null;
            }
            return carrier.get(key.toLowerCase(Locale.ROOT));
          }
        };

    private final TextMapPropagator delegate;

    LambdaXraySystemPropertyPropagator(TextMapPropagator delegate) {
      this.delegate = delegate;
    }

    @Override
    public Collection<String> fields() {
      return delegate.fields();
    }

    @Override
    public <C> void inject(Context context, C carrier, TextMapSetter<C> setter) {
      delegate.inject(context, carrier, setter);
    }

    @Override
    public <C> Context extract(Context context, C carrier, TextMapGetter<C> getter) {
      Context base = context == null ? Context.root() : context;
      Context extracted = delegate.extract(base, carrier, getter);

      // Preserve an already-valid parent extracted from the event carrier (e.g. API Gateway
      // headers) so explicit upstream propagation always wins.
      if (Span.fromContext(extracted).getSpanContext().isValid()) {
        return extracted;
      }

      // Java 17+ managed Lambda runtimes place the per-invocation X-Ray header here.
      String traceHeader = System.getProperty(TRACE_HEADER_PROPERTY);
      if (traceHeader == null || traceHeader.trim().isEmpty()) {
        return extracted;
      }

      return delegate.extract(
          extracted, Collections.singletonMap(TRACE_HEADER_KEY, traceHeader), MAP_GETTER);
    }
  }
}
