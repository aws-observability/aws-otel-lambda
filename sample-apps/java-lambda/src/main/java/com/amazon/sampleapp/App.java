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


import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.RequestHandler;

public class App implements RequestHandler<Void, String> {

  private static MetricEmitter buildMetricEmitter() {
    return new MetricEmitter();
  }

  @Override
  public String handleRequest(Void input, Context context) {
    System.out.println("[I!]Launching sample app from lambda handler...");
    long requestStartTime = System.currentTimeMillis();
    MetricEmitter metricEmitter = buildMetricEmitter();
    System.out.println("[I!]Emitting latency metric...");
    long latency = System.currentTimeMillis() - requestStartTime;
    metricEmitter.emitReturnTimeMetric(latency, "/lambda-sample-app", "200");
    String message = new String("200 OK");
    System.out.println("[I!]Returning from lambda handler...");
//    TODO: the below code needs to be called to replace 'sleep' once the graceful shutdown change has been released from upstream. https://github.com/open-telemetry/opentelemetry-java/pull/2936
//    metricEmitter.shutDown();
    try {
      System.out.println("[I!]Sleeping for 15s...");
      Thread.sleep(1000 * 15);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    return message;
  }
}
