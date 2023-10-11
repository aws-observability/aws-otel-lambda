# AWS managed OpenTelemetry Lambda Layers

As a downstream Repo of [opentelemetry-lambda](https://github.com/open-telemetry/opentelemetry-lambda), ___aws-otel-lambda___ publishes AWS managed OpenTelemetry Lambda layers that are preconfigured for use with AWS services and bundle the reduced ADOT Collector. Users can onboard to OpenTelemetry in their existing Lambda functions by adding these ready-made layers directly.
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-20-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.20.0` and ADOT Collector for Lambda `v0.33.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-16-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.16.0` with AWS Lambda Instrumentation `v0.37.0` and ADOT Collector for Lambda `v0.33.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-30-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.30.0` and ADOT Collector for Lambda `v0.33.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-30-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.30.0` and ADOT Collector for Lambda `v0.33.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-84-0** contains ADOT Collector for Lambda `v0.33.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.

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

| Receiver       | Exporter                          | Extensions                  |
|----------------|-----------------------------------|-----------------------------|
|otlpreceiver    |`awsemfexporter`                   |`sigv4authextension`         |
|                |`awsxrayexporter`                  |                             |
|                |prometheusremotewriteexporter      |                             |
|                |loggingexporter                    |                             |
|                |otlpexporter                       |                             |
|                |otlphttpexporter                   |                             |

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## Support 

Please note that as per policy, we're providing support via GitHub on a best effort basis. However, if you have AWS Enterprise Support you can create a ticket and we will provide direct support within the respective SLAs.

## License

This project is licensed under the Apache-2.0 License.
