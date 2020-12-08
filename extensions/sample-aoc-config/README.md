## Customize AOC config in Lambda
AOT Lambda layer contains a default config file which exports data to AWS X-Ray. But users can use customized config file and related private ca/cert/key files in Lambda to export data to 3rd party backend service in secure mode. 


### Getting started

#### Option 1# Bring files into Lambda function by Lambda layer
This sample is demoing how to do that with a simple config [config-test.yaml](aoc-config/config-test.yaml), you can re-use it as a tool for your customized AOC config file. Here suppose users have installed [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) and configed [AWS credential](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

1. Publish your config files and ca/cert/key files to a Lambda layer:
    - download a local copy of this repo
    - cd extensions/sample-aoc-config && make publish-config-layer
   
   Then, will get a Lambda layer `aoc-config-layer` in default region. You can run below command to check its ARN.
   ```bash
   aws lambda list-layer-versions --layer-name aoc-config-layer --query 'LayerVersions[0].LayerVersionArn'
   ```
    
2. Add the AOC config layer to your Lambda function(alreay has AOT layer)
    - Open the Lambda function you intend to instument in the in AWS console. 
    - In the “Layers in Designer” section, choose “Add a layer”.
    - Under “specify an ARN” paste the layer ARN you got in previous step and choose “Add”.
    
3. Set AOC config file to `config-test.yaml`
    - Add the environment variable `AOT_CONFIG = /opt/aoc-config/config-test.yaml` to your Lambda function.
    
#### Option 2# By adding environment variable `AOT_CONFIG_CONTENT` in AWS Lambda console

This option is not recommanded but can be a shortcut if the AOC config is simple and no need additional ca/cert/key files. You can set environment variable  `AOT_CONFIG_CONTENG` in AWS Lambda console and value is the content of AOC config file. For example, if the AOC config is:
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

Add the environment variable `AOT_CONFIG_CONTENT = "receivers:\n  otlp:\n    protocols:\n      grpc:\n        endpoint: 0.0.0.0:55680\nexporters:\n  awsxray:\nservice:\n  pipelines:\n    traces:\n      receivers: [otlp]\n      exporters: [awsxray]"`.
