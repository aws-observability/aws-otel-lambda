## Customize AOC config in Lambda
AOT Lambda layer contains a default config file which exports data to AWS X-Ray. But users can use customized config file and related private ca/cert/key files in Lambda to export data to 3rd party backend service in secure mode. 

This sample is demoing how to do that with a simple config [config-test.yaml](aoc-config/config-test.yaml), you can re-use this sample as a tool for your customized AOC config file. Here suppose users have installed AWS CLI and configed AWS credential.


### Getting started

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
    
