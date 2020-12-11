## Custom ADOT Collector config in Lambda
ADOT Lambda layer contains a default config file which exports data to AWS X-Ray. But users can use custom config file and related private ca/cert/key files in Lambda to export data to other services in secure mode. 

### Getting started

#### Option 1# Bring files into Lambda function by Lambda layer
This sample is demoing how to do that with a simple config [config-grpc-loop.yaml](custom/config-grpc-loop.yaml), you can re-use this sample as a tool for your custom OpenTelemetry Collector config file. Here suppose users have installed [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and configed [AWS credential](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

1. Publish your config files and ca/cert/key files to a Lambda layer:
    - download a local copy of this repo
    - cd extensions/sample-custom-config && make publish-config-layer
   
   Then, will get a Lambda layer `adot-config-layer` in default region. You can run below command to check its ARN.
   ```bash
   aws lambda list-layer-versions --layer-name adot-config-layer --query 'LayerVersions[0].LayerVersionArn'
   ```
    
2. Add OpenTelemetry Collector config layer to your Lambda function(alreay has ADOT layer)
    - Open the Lambda function you intend to instument in the in AWS console. 
    - In the “Layers in Designer” section, choose “Add a layer”.
    - Under “specify an ARN” paste the layer ARN you got in previous step and choose “Add”.
    
3. Set OpenTelemetry Collector config file to `config-grpc-loop.yaml`
    - Add the environment variable `ADOT_CONFIG = /opt/custom/config-grpc-loop.yaml` to your Lambda function.
    
#### Option 2# By adding environment variable `ADOT_CONFIG_CONTENT` in AWS Lambda console

This option is not recommanded but can be a shortcut if the OpenTelemetry Collector config is simple and no need additional ca/cert/key files. You can set environment variable  `ADOT_CONFIG_CONTENG` in AWS Lambda console and value is the content of OpenTelemetry Collector config file. For example, if the config is:
```yaml
receivers:
  otlp:
    protocols:
      grpc:
        endpoint: 0.0.0.0:55680
exporters:
  awsxray:
service:
  pipelines:
    traces:
      receivers: [otlp]
      exporters: [awsxray]
```

Add the environment variable `ADOT_CONFIG_CONTENT = "receivers:\n  otlp:\n    protocols:\n      grpc:\n        endpoint: 0.0.0.0:55680\nexporters:\n  awsxray:\nservice:\n  pipelines:\n    traces:\n      receivers: [otlp]\n      exporters: [awsxray]"`.
