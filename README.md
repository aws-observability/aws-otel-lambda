# AWS managed OpenTelemetry Lambda Layers

As a downstream Repo of [opentelemetry-lambda](https://github.com/open-telemetry/opentelemetry-lambda), ___aws-otel-lambda___ publishes AWS managed OpenTelemetry Lambda layers that are preconfigured for use with AWS services and bundle the reduced AWS Collector. Users can onboard to OpenTelemetry in their existing Lambda functions by adding these ready-made layers directly.
- Python3.8 layer [aws-otel-python38-ver-1-3-0](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.3.0` with Contrib `v0.22b0`
- Nodejs layer [aws-otel-nodejs-ver-0-23-0](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript `v0.23.0` with Contrib `v0.23.0`
- Java-Wrapper layer [aws-otel-java-wrapper-ver-1-2-0](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.2.0`
- Java-Agent layer [aws-otel-java-agent-ver-1-2-0](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS OpenTelemetry Java instrumentation `v1.2.0`
- Collector layer [aws-otel-collector-ver-0-29-1](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) contains ADOT Collector for Lambda `v0.11.0`



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
4. Go to a sample application folder, such as `sample-apps/sam/python`, `sample-apps/terraform/nodejs/aws-sdk`, etc
    
5. Deploy sample application by, 
    1. For SAM sample application
        ```
        ./run.sh
       ```
       
    2. For Terraform sample application
        ```
       terraform init
       terraform apply -auto-approve
        ```
    

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.
