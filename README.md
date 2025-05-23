# AWS managed OpenTelemetry Lambda Layers

As a downstream Repo of [opentelemetry-lambda](https://github.com/open-telemetry/opentelemetry-lambda), ___aws-otel-lambda___ publishes AWS managed OpenTelemetry Lambda layers that are preconfigured for use with AWS services and bundle the reduced ADOT Collector. Users can onboard to OpenTelemetry in their existing Lambda functions by adding these ready-made layers directly.
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-29-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.29.0` and ADOT Collector for Lambda `v0.42.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-30-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.30.0` with AWS Lambda Instrumentation `v0.50.0` and ADOT Collector for Lambda `v0.42.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-32-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.32.0` and ADOT Collector for Lambda `v0.42.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-32-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.32.0` and ADOT Collector for Lambda `v0.42.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-115-0** contains ADOT Collector for Lambda `v0.42.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.

## Notice: ADOT Collector v0.35.0 Breaking Change
Users of the `prometheusremotewrite` exporter please reference GitHub Issue [Warning: ADOT Collector v0.35.0 breaking change](https://github.com/aws-observability/aws-otel-collector/issues/2367)
for information on an upcoming breaking change.

## Sample Apps
We provide [SAM and Terraform sample applications](sample-apps/) for AWS managed OpenTelemetry Lambda layers. You can play with these samples by the following:
1. Install AWS Cli, AWS SAM, Terraform, and configure AWS credentials correctly.
2. Checkout the current Repo by
   
   ```
   git clone --recurse-submodules https://github.com/aws-observability/aws-otel-lambda.git
   ```
   
3. Go to the language folder, such as `python`, `java`, run

   ```
   ./build.sh
   ```
4. Go to a sample application folder, such as `sample-apps/aws-sdk/deploy/wrapper/`.
    
5. Deploy sample application by,
       
    For Terraform sample application
    ```
    terraform init
    terraform apply -auto-approve
    ```
 To Deploy SAM sample application, navigate to `sample-apps/python-aws-sdk-aiohttp-sam/` and run.
    ```
    ./run.sh
    ```
## ADOT Lambda Layer available components

This table represents the components that the ADOT Lambda Layer will support and can be used in the [custom configuration for ADOT collector on Lambda](https://aws-otel.github.io/docs/getting-started/lambda#custom-configuration-for-the-adot-collector-on-lambda). The highlighted components below are developed by AWS in-house.

| Receiver       | Exporter                      | Extensions                  |
|----------------|-------------------------------|-----------------------------|
|otlpreceiver    | `awsemfexporter`              |`sigv4authextension`         |
|                | `awsxrayexporter`             |                             |
|                | prometheusremotewriteexporter |                             |
|                | debugexporter                 |                             |
|                | otlpexporter                  |                             |
|                | otlphttpexporter              |                             |

## Building the Lambda Layer

The ADOT Lambda layer is not available in all AWS regions and partitions today. In order to use the layer in these cases, you can build and pulbish the layer from source. In order to build the layer from source, perform the following steps.

1. Clone the repository locally

   ```
   git clone --recurse-submodules https://github.com/aws-observability/aws-otel-lambda.git
   ```

2. Run the `patch-upstream.sh` script to patch upstream OpenTelemetry submodules with layer configurations:

   ```sh
   ./patch-upstream.sh
   ```

3. Go to the language folder, such as `python`, `java`:

   ```sh
   cd python/
   ```

4. Run the `build.sh` script with your desired architecture (`amd64` or `arm64`):

   ```sh
   GOARCH=amd64 ./build.sh amd64
   ```

5. Publish the output zipfile as a Lambda layer. The output zipfile name, runtime, and architecture will change depending on your language and use case.

   ```sh
   aws lambda publish-layer-version \
       --layer-name opentelemetry-javaagent-layer-amd64-java17 \
       --description "AWS Distro for Open Telemetry Lambda Layer for Java including auto-instrumentation agent" \
       --zip-file "fileb://opentelemetry-lambda/java/layer-javaagent/build/distributions/opentelemetry-javaagent-layer.zip" \
       --compatible-runtimes java17 \
       --compatible-architectures "x86_64"
   ```

   | Language         | Use Case                                     | File name                                                                                         |
   |------------------|----------------------------------------------|---------------------------------------------------------------------------------------------------|
   | `java`           | Auto instrumentation agent + SDK + collector | `opentelemetry-lambda/java/layer-javaagent/build/distributions/opentelemetry-javaagent-layer.zip` |
   | `java`           | SDK + collector                              | `opentelemetry-lambda/java/layer-wrapper/build/distributions/opentelemetry-javawrapper-layer.zip` |
   | `nodejs`         | SDK + collector                              | `opentelemetry-lambda/nodejs/packages/layer/build/layer.zip`                                      |
   | `python`         | SDK + collector                              | `opentelemetry-lambda/python/src/build/layer.zip`                                                 |
   | `collector`      | ADOT collector only                          | `opentelemetry-lambda/collector/build/opentelemetry-collector-layer-{architecture}.zip`           |




## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## Support 

Please note that as per policy, we're providing support via GitHub on a best effort basis. However, if you have AWS Enterprise Support you can create a ticket and we will provide direct support within the respective SLAs.

## License

This project is licensed under the Apache-2.0 License.
