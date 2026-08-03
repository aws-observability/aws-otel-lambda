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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import io.opentelemetry.api.trace.Span;
import io.opentelemetry.api.trace.SpanContext;
import io.opentelemetry.api.trace.propagation.W3CTraceContextPropagator;
import io.opentelemetry.context.Context;
import io.opentelemetry.context.propagation.TextMapGetter;
import io.opentelemetry.context.propagation.TextMapPropagator;
import io.opentelemetry.contrib.awsxray.propagator.AwsXrayPropagator;
import java.util.Collections;
import java.util.Map;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import software.amazon.opentelemetry.lambda.AwsLambdaXrayContextAutoConfigurationCustomizerProvider.LambdaXraySystemPropertyPropagator;

class AwsLambdaXrayContextAutoConfigurationCustomizerProviderTest {

  private static final String XRAY_HEADER_KEY = "X-Amzn-Trace-Id";

  // Trace context that the Lambda runtime exposes via the system property.
  private static final String PROPERTY_HEADER =
      "Root=1-8a3c60f7-d188f8fa79d48a391a778fa6;Parent=53995c3f42cd8ad8;Sampled=1";
  private static final String PROPERTY_TRACE_ID = "8a3c60f7d188f8fa79d48a391a778fa6";
  private static final String PROPERTY_SPAN_ID = "53995c3f42cd8ad8";

  // A different, valid trace context that arrives on the event carrier (e.g. API Gateway headers).
  private static final String EVENT_HEADER =
      "Root=1-11111111-222222222222222222222222;Parent=3333333333333333;Sampled=1";
  private static final String EVENT_TRACE_ID = "11111111222222222222222222222222";

  // A second distinct system-property value, used to prove the property is re-read per extraction.
  private static final String SECOND_PROPERTY_HEADER =
      "Root=1-44444444-555555555555555555555555;Parent=6666666666666666;Sampled=1";
  private static final String SECOND_PROPERTY_TRACE_ID = "44444444555555555555555555555555";

  private static final TextMapGetter<Map<String, String>> EXACT_KEY_GETTER =
      new TextMapGetter<Map<String, String>>() {
        @Override
        public Iterable<String> keys(Map<String, String> carrier) {
          return carrier.keySet();
        }

        @Override
        public String get(Map<String, String> carrier, String key) {
          return carrier == null ? null : carrier.get(key);
        }
      };

  @AfterEach
  void clearTraceHeader() {
    System.clearProperty(
        AwsLambdaXrayContextAutoConfigurationCustomizerProvider.TRACE_HEADER_PROPERTY);
  }

  private static TextMapPropagator xrayFallbackPropagator() {
    return new LambdaXraySystemPropertyPropagator(AwsXrayPropagator.getInstance());
  }

  private static SpanContext extract(TextMapPropagator propagator, Map<String, String> carrier) {
    Context result = propagator.extract(Context.root(), carrier, EXACT_KEY_GETTER);
    return Span.fromContext(result).getSpanContext();
  }

  @Test
  void emptyHeadersWithValidProperty_extractsPropertyContext() {
    System.setProperty(
        AwsLambdaXrayContextAutoConfigurationCustomizerProvider.TRACE_HEADER_PROPERTY,
        PROPERTY_HEADER);

    SpanContext spanContext = extract(xrayFallbackPropagator(), Collections.emptyMap());

    assertTrue(spanContext.isValid(), "expected a valid parent from the system property");
    assertEquals(PROPERTY_TRACE_ID, spanContext.getTraceId());
    assertEquals(PROPERTY_SPAN_ID, spanContext.getSpanId());
    assertTrue(spanContext.isSampled());
    assertTrue(spanContext.isRemote());
  }

  @Test
  void validEventHeaderWithDifferentProperty_eventHeaderWins() {
    System.setProperty(
        AwsLambdaXrayContextAutoConfigurationCustomizerProvider.TRACE_HEADER_PROPERTY,
        PROPERTY_HEADER);

    Map<String, String> carrier = Collections.singletonMap(XRAY_HEADER_KEY, EVENT_HEADER);
    SpanContext spanContext = extract(xrayFallbackPropagator(), carrier);

    assertTrue(spanContext.isValid());
    assertEquals(EVENT_TRACE_ID, spanContext.getTraceId(), "event header must take precedence");
  }

  @Test
  void missingProperty_behaviorUnchanged() {
    System.clearProperty(
        AwsLambdaXrayContextAutoConfigurationCustomizerProvider.TRACE_HEADER_PROPERTY);

    SpanContext spanContext = extract(xrayFallbackPropagator(), Collections.emptyMap());

    assertFalse(spanContext.isValid(), "no header and no property must yield no parent");
  }

  @Test
  void malformedProperty_noExceptionAndNoParent() {
    System.setProperty(
        AwsLambdaXrayContextAutoConfigurationCustomizerProvider.TRACE_HEADER_PROPERTY,
        "this-is-not-a-valid-xray-trace-header");

    SpanContext spanContext = extract(xrayFallbackPropagator(), Collections.emptyMap());

    assertFalse(spanContext.isValid(), "a malformed property must not produce a valid parent");
  }

  @Test
  void propertyChangesBetweenExtractions_eachExtractionReadsCurrentValue() {
    TextMapPropagator propagator = xrayFallbackPropagator();

    System.setProperty(
        AwsLambdaXrayContextAutoConfigurationCustomizerProvider.TRACE_HEADER_PROPERTY,
        PROPERTY_HEADER);
    SpanContext first = extract(propagator, Collections.emptyMap());

    System.setProperty(
        AwsLambdaXrayContextAutoConfigurationCustomizerProvider.TRACE_HEADER_PROPERTY,
        SECOND_PROPERTY_HEADER);
    SpanContext second = extract(propagator, Collections.emptyMap());

    assertEquals(PROPERTY_TRACE_ID, first.getTraceId());
    assertEquals(SECOND_PROPERTY_TRACE_ID, second.getTraceId());
  }

  @Test
  void blankProperty_treatedAsAbsent() {
    System.setProperty(
        AwsLambdaXrayContextAutoConfigurationCustomizerProvider.TRACE_HEADER_PROPERTY, "   ");

    SpanContext spanContext = extract(xrayFallbackPropagator(), Collections.emptyMap());

    assertFalse(spanContext.isValid(), "a whitespace-only property must be treated as absent");
  }

  @Test
  void delegateWithoutXrayPropagator_propertyIgnored() {
    System.setProperty(
        AwsLambdaXrayContextAutoConfigurationCustomizerProvider.TRACE_HEADER_PROPERTY,
        PROPERTY_HEADER);

    // A delegate that does not understand X-Amzn-Trace-Id must leave the property unused, honoring
    // an explicit OTEL_PROPAGATORS configuration that excludes xray.
    TextMapPropagator propagator =
        new LambdaXraySystemPropertyPropagator(W3CTraceContextPropagator.getInstance());

    SpanContext spanContext = extract(propagator, Collections.emptyMap());

    assertFalse(spanContext.isValid(), "non-xray delegate must ignore the X-Ray property");
  }
}
