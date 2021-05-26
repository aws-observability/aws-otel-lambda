# Change Log
All notable changes to this project will be documented in this file.

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
