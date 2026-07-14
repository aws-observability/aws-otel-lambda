/*
 * Copyright The OpenTelemetry Authors
 * SPDX-License-Identifier: Apache-2.0
 */

package io.opentelemetry.instrumentation.awssdk.v2_2.autoconfigure;

import io.opentelemetry.api.GlobalOpenTelemetry;
import io.opentelemetry.api.OpenTelemetry;
import io.opentelemetry.instrumentation.api.internal.ConfigPropertiesUtil;
import io.opentelemetry.instrumentation.awssdk.v2_2.AwsSdkTelemetry;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.util.Optional;
import org.reactivestreams.Publisher;
import software.amazon.awssdk.core.SdkRequest;
import software.amazon.awssdk.core.SdkResponse;
import software.amazon.awssdk.core.async.AsyncRequestBody;
import software.amazon.awssdk.core.interceptor.Context;
import software.amazon.awssdk.core.interceptor.ExecutionAttributes;
import software.amazon.awssdk.core.interceptor.ExecutionInterceptor;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.http.SdkHttpRequest;
import software.amazon.awssdk.http.SdkHttpResponse;

/**
 * A {@link ExecutionInterceptor} for use as an SPI by the AWS SDK to automatically trace all
 * requests.
 *
 * <p>NOTE: This copy carries temporary [ADOT-DEBUG] diagnostics to localize why AWS SDK calls are
 * not traced in wrapper mode under OTel Collector v0.151.0 (PROMET-11975). Remove before release.
 */
public class AutoconfiguredTracingExecutionInterceptor implements ExecutionInterceptor {

  static {
    // Prints iff the AWS SDK reads the global interceptors SPI file and loads this class at all.
    System.out.println(
        "[ADOT-DEBUG] AutoconfiguredTracingExecutionInterceptor class loaded (SPI registration hit)");
  }

  private static final boolean CAPTURE_EXPERIMENTAL_SPAN_ATTRIBUTES =
      ConfigPropertiesUtil.getBoolean(
          "otel.instrumentation.aws-sdk.experimental-span-attributes", false);

  private final ExecutionInterceptor delegate;

  public AutoconfiguredTracingExecutionInterceptor() {
    OpenTelemetry openTelemetry = GlobalOpenTelemetry.get();
    // Prints what OpenTelemetry the delegate captured at construction time. A Noop/Default
    // TracerProvider here means traces will be silently dropped even though metrics work.
    System.out.println(
        "[ADOT-DEBUG] interceptor constructed; GlobalOpenTelemetry="
            + openTelemetry.getClass().getName()
            + " tracerProvider="
            + openTelemetry.getTracerProvider().getClass().getName());
    this.delegate =
        AwsSdkTelemetry.builder(openTelemetry)
            .setCaptureExperimentalSpanAttributes(CAPTURE_EXPERIMENTAL_SPAN_ATTRIBUTES)
            .build()
            .createExecutionInterceptor();
  }

  @Override
  public void beforeExecution(
      Context.BeforeExecution context, ExecutionAttributes executionAttributes) {
    // Prints iff the interceptor is actually attached to the SDK client and invoked per call.
    System.out.println("[ADOT-DEBUG] beforeExecution fired for an AWS SDK request");
    delegate.beforeExecution(context, executionAttributes);
  }

  @Override
  public SdkRequest modifyRequest(
      Context.ModifyRequest context, ExecutionAttributes executionAttributes) {
    return delegate.modifyRequest(context, executionAttributes);
  }

  @Override
  public void beforeMarshalling(
      Context.BeforeMarshalling context, ExecutionAttributes executionAttributes) {
    delegate.beforeMarshalling(context, executionAttributes);
  }

  @Override
  public void afterMarshalling(
      Context.AfterMarshalling context, ExecutionAttributes executionAttributes) {
    delegate.afterMarshalling(context, executionAttributes);
  }

  @Override
  public SdkHttpRequest modifyHttpRequest(
      Context.ModifyHttpRequest context, ExecutionAttributes executionAttributes) {
    return delegate.modifyHttpRequest(context, executionAttributes);
  }

  @Override
  public Optional<RequestBody> modifyHttpContent(
      Context.ModifyHttpRequest context, ExecutionAttributes executionAttributes) {
    return delegate.modifyHttpContent(context, executionAttributes);
  }

  @Override
  public Optional<AsyncRequestBody> modifyAsyncHttpContent(
      Context.ModifyHttpRequest context, ExecutionAttributes executionAttributes) {
    return delegate.modifyAsyncHttpContent(context, executionAttributes);
  }

  @Override
  public void beforeTransmission(
      Context.BeforeTransmission context, ExecutionAttributes executionAttributes) {
    delegate.beforeTransmission(context, executionAttributes);
  }

  @Override
  public void afterTransmission(
      Context.AfterTransmission context, ExecutionAttributes executionAttributes) {
    delegate.afterTransmission(context, executionAttributes);
  }

  @Override
  public SdkHttpResponse modifyHttpResponse(
      Context.ModifyHttpResponse context, ExecutionAttributes executionAttributes) {
    return delegate.modifyHttpResponse(context, executionAttributes);
  }

  @Override
  public Optional<Publisher<ByteBuffer>> modifyAsyncHttpResponseContent(
      Context.ModifyHttpResponse context, ExecutionAttributes executionAttributes) {
    return delegate.modifyAsyncHttpResponseContent(context, executionAttributes);
  }

  @Override
  public Optional<InputStream> modifyHttpResponseContent(
      Context.ModifyHttpResponse context, ExecutionAttributes executionAttributes) {
    return delegate.modifyHttpResponseContent(context, executionAttributes);
  }

  @Override
  public void beforeUnmarshalling(
      Context.BeforeUnmarshalling context, ExecutionAttributes executionAttributes) {
    delegate.beforeUnmarshalling(context, executionAttributes);
  }

  @Override
  public void afterUnmarshalling(
      Context.AfterUnmarshalling context, ExecutionAttributes executionAttributes) {
    delegate.afterUnmarshalling(context, executionAttributes);
  }

  @Override
  public SdkResponse modifyResponse(
      Context.ModifyResponse context, ExecutionAttributes executionAttributes) {
    return delegate.modifyResponse(context, executionAttributes);
  }

  @Override
  public void afterExecution(
      Context.AfterExecution context, ExecutionAttributes executionAttributes) {
    delegate.afterExecution(context, executionAttributes);
  }

  @Override
  public Throwable modifyException(
      Context.FailedExecution context, ExecutionAttributes executionAttributes) {
    return delegate.modifyException(context, executionAttributes);
  }

  @Override
  public void onExecutionFailure(
      Context.FailedExecution context, ExecutionAttributes executionAttributes) {
    delegate.onExecutionFailure(context, executionAttributes);
  }
}
