# Change Log
All notable changes to this project will be documented in this file.


## 2023-10-11 Release

**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-20-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.20.0` and ADOT Collector for Lambda `v0.33.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-16-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.16.0` with AWS Lambda Instrumentation `v0.37.0` and ADOT Collector for Lambda `v0.33.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-30-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.30.0` and ADOT Collector for Lambda `v0.33.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-30-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.30.0` and ADOT Collector for Lambda `v0.33.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-84-0** contains ADOT Collector for Lambda `v0.33.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- Layers are built from Git commit `5e6f5c96b54fbddf0b753a244afbf18cab4fddee` at https://github.com/aws-observability/aws-otel-lambda/commit/5e6f5c96b54fbddf0b753a244afbf18cab4fddee

### Notice: ADOT Collector v0.35.0 Breaking Change
Users of the `prometheusremotewrite` exporter please reference GitHub Issue [Warning: ADOT Collector v0.35.0 breaking change](https://github.com/aws-observability/aws-otel-collector/issues/2367)
for information on an upcoming breaking change.

## 2023-08-17 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-19-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.19.0` and ADOT Collector for Lambda `v0.32.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-15-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.15.0` with AWS Lambda Instrumentation `v0.36.0` and ADOT Collector for Lambda `v0.32.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-28-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.28.0` and ADOT Collector for Lambda `v0.32.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-28-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.28.1` and ADOT Collector for Lambda `v0.32.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-82-0** contains ADOT Collector for Lambda `v0.32.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- Layers are built from Git commit `7c77828469b969e640607c43cd33201b546b1957` at https://github.com/aws-observability/aws-otel-lambda/commit/7c77828469b969e640607c43cd33201b546b1957

## 2023-07-25 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-19-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.19.0` and ADOT Collector for Lambda `v0.31.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-15-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.15.0` with AWS Lambda Instrumentation `v0.36.0` and ADOT Collector for Lambda `v0.31.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-28-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.28.0` and ADOT Collector for Lambda `v0.31.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-28-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.28.0` and ADOT Collector for Lambda `v0.31.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-80-0** contains ADOT Collector for Lambda `v0.31.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- Layers are built from Git commit `67e8ef575cd41a5460670d1e8a9e364c1ae17b02` at https://github.com/aws-observability/aws-otel-lambda/commit/67e8ef575cd41a5460670d1e8a9e364c1ae17b02

## 2023-06-08 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-18-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.18.0` and ADOT Collector for Lambda `v0.30.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-13-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.13.0` with AWS Lambda Instrumentation `v0.35.2` and ADOT Collector for Lambda `v0.30.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-26-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.26.0` and ADOT Collector for Lambda `v0.30.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-26-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.26.0` and ADOT Collector for Lambda `v0.30.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-78-2** contains ADOT Collector for Lambda `v0.30.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- Layers are built from Git commit `e4fba5f85455f9bbe51412a567e7bcbb6cf997bd` at https://github.com/aws-observability/aws-otel-lambda/commit/e4fba5f85455f9bbe51412a567e7bcbb6cf997bd

## 2023-04-23 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-17-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.17.0` and ADOT Collector for Lambda `v0.28.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-12-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.12.0` with AWS Lambda Instrumentation `v0.35.0` and ADOT Collector for Lambda `v0.28.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-24-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.24.0` and ADOT Collector for Lambda `v0.28.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-24-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.24.0` and ADOT Collector for Lambda `v0.28.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-74-0** contains ADOT Collector for Lambda `v0.28.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- Layers are built from Git commit `3404672c1de934cf3d1f9aa3df54ea35e3805c6d` at https://github.com/aws-observability/aws-otel-lambda/commit/404672c1de934cf3d1f9aa3df54ea35e3805c6d

## 2023-03-10 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-16-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.16.0` and ADOT Collector for Lambda `v0.27.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-9-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.9.1` with AWS Lambda Instrumentation `v0.35.0` and ADOT Collector for Lambda `v0.27.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-23-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.23.0` and ADOT Collector for Lambda `v0.27.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-23-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.23.0` and ADOT Collector for Lambda `v0.27.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-72-0** contains ADOT Collector for Lambda `v0.27.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- Layers are built from Git commit `9f7f2edeaed3f1b989766ad27c39bbfc6051da6c` at https://github.com/aws-observability/aws-otel-lambda/commit/9f7f2edeaed3f1b989766ad27c39bbfc6051da6c

Notice:

* In this release the component `prometheusexporter` was removed as previously announced in https://aws-otel.github.io/docs/adot-lambda-remove-prometheusexporter

## 2023-02-22 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-16-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.16.0` and ADOT Collector for Lambda `v0.26.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-9-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.9.1` with AWS Lambda Instrumentation `v0.35.0` and ADOT Collector for Lambda `v0.26.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-21-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.21.1` and ADOT Collector for Lambda `v0.26.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-21-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.21.1` and ADOT Collector for Lambda `v0.26.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-70-0** contains ADOT Collector for Lambda `v0.26.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- Layers are built from Git commit `a5b62b89cb31e46da799757c0dca694c6662e322` at https://github.com/aws-observability/aws-otel-lambda/commit/a5b62b89cb31e46da799757c0dca694c6662e322
  
## 2023-01-11 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-15-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.15.0` and ADOT Collector for Lambda `v0.25.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-8-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.8.0` with AWS Lambda Instrumentation `v0.34.0` and ADOT Collector for Lambda `v0.25.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-21-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.21.0` and ADOT Collector for Lambda `v0.25.0` 
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-21-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.21.0` and ADOT Collector for Lambda `v0.25.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-68-0** contains ADOT Collector for Lambda `v0.25.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- Layers are built from Git commit `3ced85e7516bab2573ce6de74d2d1233b5c89214` at https://github.com/aws-observability/aws-otel-lambda/commit/3ced85e7516bab2573ce6de74d2d1233b5c89214

## 2022-12-20 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-15-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.15.0`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-8-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.8.0` with AWS Lambda Instrumentation `v0.34.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-20-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.20.1`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-20-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.20.1`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-66-0** contains ADOT Collector for Lambda `v0.24.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- x86_64/ARM64 Layers are now available in 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1.
- Layers are built from Git commit `2646717dc36d41aa16ee5953ffb704a020f360b1` at https://github.com/aws-observability/aws-otel-lambda/commit/2646717dc36d41aa16ee5953ffb704a020f360b1

## 2022-11-09 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-14-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.14.0` with the AWS Python Extension `v2.0.1`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-7-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.7.0` with AWS Lambda Instrumentation `v0.33.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-19-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.19.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-19-2**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.19.2`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-62-1** contains ADOT Collector for Lambda `v0.23.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- x86_64/ARM64 Layers are now available in 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1.
- Layers are built from Git commit `63e002c8a84d4c0387c3a6410c7e946f4b0fc029` at https://github.com/aws-observability/aws-otel-lambda/commit/63e002c8a84d4c0387c3a6410c7e946f4b0fc029
- Nodejs Layer now removes support for `nodejs12.x`

## 2022-10-06 Release
**AWS Distro For OpenTelemetry Lambda now supports AMD64 and ARM64 Architectures**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-13-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.13.0` with the AWS Python Extension `v2.0.1`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-7-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.7.0` with AWS Lambda Instrumentation `v0.33.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-18-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.18.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-18-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro for OpenTelemetry Java Instrumentation `v1.18.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-61-0** contains ADOT Collector for Lambda `v0.22.0`. Compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) runtimes.
- x86_64 Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- ARM64 Layers cover 10 AWS Regions: us-east-1, us-east-2, us-west-2, ap-south-1, ap-southeast-1, ap-southeast-2, ap-northeast-1, eu-central-1, eu-west-1, eu-west-2.
- Layers are built from Git commit `9810438ff0d3c3585c3c6847335220f4ce2ec1c2` at https://github.com/aws-observability/aws-otel-lambda/commit/9810438ff0d3c3585c3c6847335220f4ce2ec1c2
- Nodejs Layer now supports `nodejs16.x` runtime and removes support for `nodejs10.x`

## .2022-09-12 Release
**AWS Distro For OpenTelemetry Lambda now supports ARM64 Architecture**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-12-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.12.0` with the AWS Python Extension `v2.0.1`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-6-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.6.0` with AWS Lambda Instrumentation `v0.33.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-17-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.17.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-17-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro For OpenTelemetry Java instrumentation `v1.17.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-58-0** (compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) Lambda functions) contains ADOT Collector for Lambda `v0.21.0`.
- x86_64 Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- ARM64 Layers cover 10 AWS Regions: us-east-1, us-east-2, us-west-2, ap-south-1, ap-southeast-1, ap-southeast-2, ap-northeast-1, eu-central-1, eu-west-1, eu-west-2.
- Layers are built from Git commit `91efcf0774a06943bbe3ab13f50ac192c78854c6` at https://github.com/aws-observability/aws-otel-lambda/commit/91efcf0774a06943bbe3ab13f50ac192c78854c6

## 2022-08-18 Release
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-5-0:2**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.5.0` with AWS Lambda Instrumentation `v0.32.0`
  - This includes [a fix](https://github.com/aws-observability/aws-otel-lambda/pull/280) for global propagator registration in the wrapper that was preventing use of the OTel API within functions.
  - Note that there is a [known issue](https://github.com/open-telemetry/opentelemetry-js/issues/3173) preventing the manual creations of spans when using the NodeJS v14 runtime.  The NodeJS v16 runtime can be used to create spans manually and autoinstrumentation functions as expected with NodeJS v14.

## 2022-07-29 Release
**AWS Distro For OpenTelemetry Lambda now supports ARM64 Architecture**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-11-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.11.1` with the AWS Python Extension `v2.0.1`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-5-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.5.0` with AWS Lambda Instrumentation `v0.32.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-16-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.16.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-16-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro For OpenTelemetry Java instrumentation `v1.16.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-56-0** (compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) Lambda functions) contains ADOT Collector for Lambda `v0.20.0`.
- x86_64 Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- ARM64 Layers cover 10 AWS Regions: us-east-1, us-east-2, us-west-2, ap-south-1, ap-southeast-1, ap-southeast-2, ap-northeast-1, eu-central-1, eu-west-1, eu-west-2.
- Layers are built from Git commit `4e87e1f14fcd9353d10af8d4dfcc392c27e564cc` at https://github.com/aws-observability/aws-otel-lambda/commit/4e87e1f14fcd9353d10af8d4dfcc392c27e564cc

## 2022-05-23 Release
**AWS Distro For OpenTelemetry Lambda now supports ARM64 Architecture**
- Python layer [**aws-otel-python-<amd64|arm64>-ver-1-11-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.11.1` with the AWS Python Extension `v2.0.1`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-2-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.2.0` with AWS Lambda Instrumentation `v0.30.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-14-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.14.0`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-14-0**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS Distro For OpenTelemetry Java instrumentation `v1.14.0`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-51-0** (compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) Lambda functions) contains ADOT Collector for Lambda `v0.18.0`.
- x86_64 Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- ARM64 Layers cover 10 AWS Regions: us-east-1, us-east-2, us-west-2, ap-south-1, ap-southeast-1, ap-southeast-2, ap-northeast-1, eu-central-1, eu-west-1, eu-west-2.
- Layers are built from Git commit `2123529f7ec9a7a0a178fff951e6acadf071231e` at https://github.com/aws-observability/aws-otel-lambda/commit/2123529f7ec9a7a0a178fff951e6acadf071231e

## 2022-03-07 Release
**AWS Distro For OpenTelemetry Lambda now supports ARM64 Architecture**
- Python3.8 layer [**aws-otel-python38-<amd64|arm64>-ver-1-9-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-python) contains OpenTelemetry Python `v1.9.1` with the AWS Python Extension `v2.0.1`
- Nodejs layer [**aws-otel-nodejs-<amd64|arm64>-ver-1-0-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.0.1` with AWS Lambda Instrumentation `v0.29.0`
- Java-Wrapper layer [**aws-otel-java-wrapper-<amd64|arm64>-ver-1-11-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java) contains OpenTelemetry Java `v1.11.1`
- Java-Agent layer [**aws-otel-java-agent-<amd64|arm64>-ver-1-11-1**](https://aws-otel.github.io/docs/getting-started/lambda/lambda-java-auto-instr) contains AWS OpenTelemetry Java instrumentation `v1.11.1`
- Collector layer **aws-otel-collector-<amd64|arm64>-ver-0-45-0** (compatible with [.NET](https://aws-otel.github.io/docs/getting-started/lambda/lambda-dotnet) and [Go](https://aws-otel.github.io/docs/getting-started/lambda/lambda-go) Lambda functions) contains ADOT Collector for Lambda `v0.17.0`.
- x86_64 Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- ARM64 Layers cover 10 AWS Regions: us-east-1, us-east-2, us-west-2, ap-south-1, ap-southeast-1, ap-southeast-2, ap-northeast-1, eu-central-1, eu-west-1, eu-west-2.
- Layers are built from Git commit `33c85b38836b7d2715d087ed5c1af0324c74e422` at https://github.com/aws-observability/aws-otel-lambda/commit/33c85b38836b7d2715d087ed5c1af0324c74e422

## 2022-02-02 Release
- Python3.8 layer **aws-otel-python38-ver-1-9-1** contains OpenTelemetry Python `v1.9.1` with the AWS Python Extension `v2.0.1`
- Nodejs layer [aws-otel-nodejs-ver-1-0-1](https://aws-otel.github.io/docs/getting-started/lambda/lambda-js) contains OpenTelemetry JavaScript Core `v1.0.1` with AWS Lambda Instrumentation `v0.28.1`
- Java-Wrapper layer **aws-otel-java-wrapper-ver-1-10-1** contains OpenTelemetry Java `v1.10.1`
- Java-Agent layer **aws-otel-java-agent-ver-1-10-1** contains AWS OpenTelemetry Java instrumentation `v1.10.1`
- Collector layer **aws-otel-collector-ver-0-43-1** contains ADOT Collector for Lambda `v0.16.0`.
- Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- Layers are built from Git commit `3325db48d102da28beaba86de5f947eef21be7c9` at https://github.com/aws-observability/aws-otel-lambda/commit/3325db48d102da28beaba86de5f947eef21be7c9

## 2021-11-23 Release
- Python3.8 layer **aws-otel-python38-ver-1-7-1** contains OpenTelemetry Python `v1.7.1` with Contrib `v0.26b1`
- Collector layer **aws-otel-collector-ver-0-39-0** contains ADOT Collector for Lambda `v0.15.0`
- Layers are bundled with OpenTelemetry Collector extension with [reduced AWS OpenTelemetry Collector v0.15.0](https://github.com/aws-observability/aws-otel-collector/releases/tag/pkg%2Flambdacomponents%2Fv0.14.0)
- Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- Layers are built from Git commit `6cf4e85e61eeabac9ced8d1df13b6ca4bf0411e9` at https://github.com/aws-observability/aws-otel-lambda/commit/6cf4e85e61eeabac9ced8d1df13b6ca4bf0411e9

## 2021-11-03 Release
- Nodejs layer **aws-otel-nodejs-ver-1-0-0** contains OpenTelemetry JavaScript `1.0.0` with Contrib `0.26.0`
- Java-Wrapper layer **aws-otel-java-wrapper-ver-1-7-0** contains OpenTelemetry Java `v1.7.0`
- Java-Agent layer **aws-otel-java-agent-ver-1-7-0** contains AWS OpenTelemetry Java instrumentation `v1.7.0`
- Collector layer **aws-otel-collector-ver-0-38-0** contains ADOT Collector for Lambda `v0.14.0`
- Layers are bundled with OpenTelemetry Collector extension with [reduced AWS OpenTelemetry Collector v0.14.0](https://github.com/aws-observability/aws-otel-collector/releases/tag/pkg%2Flambdacomponents%2Fv0.14.0)
- Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- Layers are built from Git commit `9f59051e2773d2234fd5b7d567e17fbe721b48cc` at https://github.com/aws-observability/aws-otel-lambda/commit/9f59051e2773d2234fd5b7d567e17fbe721b48cc

## 2021-08-31 Release
- Python3.8 layer **aws-otel-python38-ver-1-5-0** contains OpenTelemetry Python `v1.5.0` with Contrib `v0.24b0`
- Nodejs layer **aws-otel-nodejs-ver-0-24-0** contains OpenTelemetry JavaScript `v0.24.0` with Contrib `v0.24.0`
- Java-Wrapper layer **aws-otel-java-wrapper-ver-1-5-0** contains OpenTelemetry Java `v1.5.0`
- Java-Agent layer **aws-otel-java-agent-ver-1-5-0** contains AWS OpenTelemetry Java instrumentation `v1.5.0`
- Collector layer **aws-otel-collector-ver-0-33-0** contains ADOT Collector for Lambda `v0.12.0`
- Layers are bundled with OpenTelemetry Collector extension with [reduced AWS OpenTelemetry Collector v0.12.0](https://github.com/aws-observability/aws-otel-collector/releases/tag/pkg%2Flambdacomponents%2Fv0.12.0)
- Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- Layers are built from Git commit `bee75f308b3b1322c96520719703beb03ca0fc8c` at https://github.com/aws-observability/aws-otel-lambda/commit/bee75f308b3b1322c96520719703beb03ca0fc8c

## 2021-07-08 Release
- Python3.8 layer **aws-otel-python38-ver-1-3-0** contains OpenTelemetry Python `v1.3.0` with Contrib `v0.22b0`
- Nodejs layer **aws-otel-nodejs-ver-0-23-0** contains OpenTelemetry JavaScript `v0.23.0` with Contrib `v0.23.0`
- Java-Wrapper layer **aws-otel-java-wrapper-ver-1-2-0** contains OpenTelemetry Java `v1.2.0`
- Java-Agent layer **aws-otel-java-agent-ver-1-2-0** contains AWS OpenTelemetry Java instrumentation `v1.2.0`
- Collector layer **aws-otel-collector-ver-0-29-1** contains ADOT Collector for Lambda `v0.11.0`
- Layers are bundled with OpenTelemetry Collector extension with [reduced AWS OpenTelemetry Collector v0.11.0](https://github.com/aws-observability/aws-otel-collector/releases/tag/pkg%2Flambdacomponents%2Fv0.11.0)
- Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- Layers are built from Git commit `f5974978a38f4b67cf088d38f3047aadef6b61d0` at https://github.com/aws-observability/aws-otel-lambda/commit/f5974978a38f4b67cf088d38f3047aadef6b61d0

## 2021-05-26 Release
- Python3.8 layer **aws-otel-python38-ver-1-2-0** contains OpenTelemetry Python `v1.2.0` with Contrib `v0.21b0`
- Nodejs layer **aws-otel-nodejs-ver-0-19-0** contains OpenTelemetry JavaScript `v0.19.0` with Contrib `v0.16.0`
- Java-Wrapper layer **aws-otel-java-wrapper-ver-1-2-0** contains OpenTelemetry Java `v1.2.0`
- Java-Agent layer **aws-otel-java-agent-ver-1-2-0** contains AWS OpenTelemetry Java instrumentation `v1.2.0`
- Collector layer **aws-otel-collector-ver-0-27-0** contains ADOT Collector for Lambda `v0.10.0`
- Layers are bundled with OpenTelemetry Collector extension with [reduced AWS OpenTelemetry Collector v0.10.0](https://github.com/aws-observability/aws-otel-collector/releases/tag/pkg%2Flambdacomponents%2Fv0.10.0)
- Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- Layers are built from Git commit sha `1f45be7879a16611e30369841c1ffabb0af23b93`

## Initial Release AWS managed OpenTelemetry Lambda layers for Python3.8, Nodejs, Java-wrapper, Java-Agent (2021-04-29)
- Python3.8 layer [aws-otel-python38-ver-1-1-0](https://aws-otel.github.io/docs/getting-started/lambda/python) contains OpenTelemetry Python v1.1.0 with Contrib v0.20b0
- Nodejs layer [aws-otel-nodejs-ver-0-18-0](https://aws-otel.github.io/docs/getting-started/lambda/javascript) contains OpenTelemetry JavaScript v0.18.0 with Contrib v0.15.0
- Java-Wrapper layer [aws-otel-java-wrapper-ver-1-1-0](https://aws-otel.github.io/docs/getting-started/lambda/java-manual-instr) contains OpenTelemetry Java v1.1.0
- Java-Agent layer [aws-otel-java-agent-ver-1-1-0](https://aws-otel.github.io/docs/getting-started/lambda/java-auto-instr) contains AWS OpenTelemetry Java instrumentation v1.1.0
- Layers are bundled with OpenTelemetry Collector extension with [reduced AWS OpenTelemetry Collector v0.9.1](https://github.com/aws-observability/aws-otel-collector/releases/tag/pkg%2Flambdacomponents%2Fv0.9.1)
- Layers cover 16 AWS Regions: us-east-1, us-east-2, us-west-1, us-west-2, ap-south-1, ap-northeast-2, ap-southeast-1, ap-southeast-2, ap-northeast-1, ca-central-1, eu-central-1, eu-west-1, eu-west-2, eu-west-3, eu-north-1, sa-east-1
- Layers are built from Git commit sha `03fe7b9dec95821fe14f0c583b25080241cfed41`
