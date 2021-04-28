# AWS managed OpenTelemetry Lambda Layers

As a downstream Repo of [opentelemetry-lambda](), ___aws-otel-lambda___ preconfigure for use with AWS services, bundles reduced AWS Collector in Lambda Collector extension, and publishes AWS managed OpenTelemetry Lambda layers. Users can onboard OpenTelemetry in their existing Lambda functions by adding these ready-made layers directly. 
- Python3.8 layer [aws-otel-python38-ver-1-1-0](https://aws-otel.github.io/docs/getting-started/lambda/python) contains OpenTelemetry Python v1.1.0 with Contrib v0.20b0
- Nodejs layer [aws-otel-nodejs-ver-0-18-0](https://aws-otel.github.io/docs/getting-started/lambda/javascript) contains OpenTelemetry JavaScript v0.18.0 with Contrib v0.15.0
- Java-Wrapper layer [aws-otel-java-wrapper-ver-1-1-0](https://aws-otel.github.io/docs/getting-started/lambda/java-manual-instr) contains OpenTelemetry Java v1.1.0
- Java-Agent layer [aws-otel-java-agent-ver-1-1-0](https://aws-otel.github.io/docs/getting-started/lambda/java-auto-instr) contains AWS OpenTelemetry Java instrumentation v1.1.0



## Sample
We provide [SAM and Terraform sample applications](sample-apps/) for AWS managed OpenTelemetry Lambda layers. Play these sample by steps:
1. Install AWS Cli, AWS SAM, Terraform, and configure AWS credentials correctly.
2. Checkout the current Repo by
   
   ```git clone --recurse-submodules https://github.com/aws-observability/aws-otel-lambda.git```
3. Patch AWS logic in repo folder by

    ``` ./patch-upstream.sh```
    
4. Deploy sample application
    1. For SAM sample
        ```
        ./run.sh
       ```
       
    2. For Terraform sample
        ```
       terraform init
       terraform apply
        ```
    

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.
