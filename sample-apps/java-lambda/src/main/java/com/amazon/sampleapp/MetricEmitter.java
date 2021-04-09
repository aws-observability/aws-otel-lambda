/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: MIT-0
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this
 * software and associated documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights to use, copy, modify,
 * merge, publish, distribute, sublicense, and/or sell copies of the Software, and to
 * permit persons to whom the Software is furnished to do so.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 * OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package com.amazon.sampleapp;

import io.grpc.ManagedChannelBuilder;
import io.opentelemetry.api.metrics.GlobalMetricsProvider;
import io.opentelemetry.api.metrics.common.Labels;
import io.opentelemetry.api.metrics.LongValueRecorder;
import io.opentelemetry.api.metrics.Meter;
import io.opentelemetry.exporter.otlp.metrics.OtlpGrpcMetricExporter;
import io.opentelemetry.sdk.metrics.SdkMeterProvider;
import io.opentelemetry.sdk.metrics.export.IntervalMetricReader;
import io.opentelemetry.sdk.metrics.export.MetricExporter;
import io.opentelemetry.sdk.autoconfigure.OpenTelemetrySdkAutoConfiguration;

import java.util.Collections;

public class MetricEmitter {

  static final String DIMENSION_API_NAME = "apiName";
  static final String DIMENSION_STATUS_CODE = "statusCode";

  static String API_LATENCY_METRIC = "latency";

  LongValueRecorder apiLatencyRecorder;

  String latencyMetricName;
  IntervalMetricReader reader;

  public MetricEmitter() {
    String otelExporterOtlpEndpoint = System.getenv("OTEL_EXPORTER_OTLP_ENDPOINT") != null ? System.getenv("OTEL_EXPORTER_OTLP_ENDPOINT") : "127.0.0.1:55680";
    MetricExporter metricExporter =
            OtlpGrpcMetricExporter.builder()
                    .setChannel(
                            ManagedChannelBuilder.forTarget(otelExporterOtlpEndpoint).usePlaintext().build())
                    .build();

    reader = IntervalMetricReader.builder()
            .setMetricProducers(
                    Collections.singleton(SdkMeterProvider.builder().setResource(OpenTelemetrySdkAutoConfiguration.getResource()).buildAndRegisterGlobal()))
            .setExportIntervalMillis(5000)
            .setMetricExporter(metricExporter)
            .build();
    Meter meter = GlobalMetricsProvider.getMeter("aws-otel", "1.0");

    latencyMetricName = API_LATENCY_METRIC;

    apiLatencyRecorder =
        meter
            .longValueRecorderBuilder(latencyMetricName)
            .setDescription("API latency time")
            .setUnit("ms")
            .build();

  }

  /**
   * emit http request latency metrics with summary metric type
   *
   * @param returnTime
   * @param apiName
   * @param statusCode
   */
  public void emitReturnTimeMetric(Long returnTime, String apiName, String statusCode) {
    apiLatencyRecorder.record(
        returnTime, Labels.of(DIMENSION_API_NAME, apiName, DIMENSION_STATUS_CODE, statusCode));
    System.out.println(
            "emit metric (name:latency) " + returnTime + "," + apiName + "," + statusCode + "," + latencyMetricName);
  }

  public void shutDown() {
    reader.shutdown();
  }
}
