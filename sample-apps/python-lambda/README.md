## AOT Python3.8 Lambda

### Follow this guide to build AOT Python3.8 Lambda layer from scratch. 

1. Install [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
2. Download this repo
3. cd sample-apps/python-lambda && ./run.sh

User will get a Lambda sample app and a AOT Python3.8 Lambda layer in aws account. The ___AOT layer ARN___ should be displayed at the end of output.

### Enable AOT in Lambda function by [CloudFormation template](https://docs.amazonaws.cn/en_us/lambda/latest/dg/configuration-layers.html#configuration-layers-cloudformation)
* Require build Lambda layer from sratch first.

```yaml
      Environment:
        Variables:
          AWS_LAMBDA_EXEC_WRAPPER: /opt/python/aot-instrument
      Tracing: Active
      Layers:
        - <AOT layer ARN>
```


## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.

