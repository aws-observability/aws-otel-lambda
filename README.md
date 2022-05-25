# AWS managed OpenTelemetry Lambda Layers

As a downstream Repo of [opentelemetry-lambda](https://github.com/open-telemetry/opentelemetry-lambda), ___aws-otel-lambda___ publishes AWS managed OpenTelemetry Lambda layers that are preconfigured for use with AWS services and bundle the reduced AWS Collector. Users can onboard to OpenTelemetry in their existing Lambda functions by adding these ready-made layers directly.
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-11-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.11.1` with the AWS Python Extension `v2.0.1`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-2-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.2.0` with AWS Lambda Instrumentation `v0.30.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-14-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.14.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-14-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains OpenTelemetry Java instrumentation `v1.14.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-51-0** contains ADOT Collector for Lambda `v0.18.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.

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

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.
