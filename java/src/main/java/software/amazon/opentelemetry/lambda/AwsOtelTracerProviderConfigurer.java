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

import io.opentelemetry.sdk.autoconfigure.spi.SdkTracerProviderConfigurer;
import io.opentelemetry.sdk.extension.aws.trace.AwsXrayIdGenerator;
import io.opentelemetry.sdk.trace.SdkTracerProviderBuilder;

public class AwsOtelTracerProviderConfigurer implements SdkTracerProviderConfigurer {
  @Override
  public void configure(SdkTracerProviderBuilder tracerProviderBuilder) {
    tracerProviderBuilder.setIdGenerator(AwsXrayIdGenerator.getInstance());
  }
}
