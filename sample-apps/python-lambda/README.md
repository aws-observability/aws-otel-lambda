![CI](https://github.com/wangzlei/bonjour/workflows/CI/badge.svg?branch=master)
# AOT Python3.8 Lambda
AOT Python Lambda layer provides a plug and play user experience of automatically instrument Lambda function, users can onload and offload AOT from their Lambda function without changing code. 

## Sample
- Install [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
- Download this repo
- Run command: `cd sample-apps/python-lambda && ./run.sh -r us-west-2`
- Open Lambda console in us-west-2, find the new Lambda function `aot-py38-sample-function-...`
the source code of Lambda function contains an aio http request and an AWS SDK request(S3)
    <details><summary>source code</summary>

    ```python
    def lambda_handler(event, context):

        loop = asyncio.get_event_loop()
        loop.run_until_complete(callAioHttp())

        for bucket in s3.buckets.all():
            print(bucket.name)

        return {"statusCode": 200}
    ```
    </details>

- Invoke Lambda function by clicking the API endpoint in API Gateway -> Details
    <details>

    ![](./docs/images/sample1.png)

    </details>

- Open X-Ray console, retrieve the latest Traces, will see the http request and AWS SDK request are instrumented.

    <details>

    ![](./docs/images/sample2.png)

    </details>

- Back to Lambda console, remove the environment variable `AWS_LAMBDA_EXEC_WRAPPER` from Lambda function.
- Click the API endpoint in API Gateway -> Details again.
- In X-Ray console, retrieve the latest Traces, will see AOT is offloaded.

    <details>

    ![](./docs/images/sample3.png)

    </details>

- Open CloudFormation console, clean the sample resources by **Delete** stack `aot-py38-sample`.

***

## Getting started
To play AOT auto-instrumentation in Python3.8 Lambda Runtime, user needs 2 steps: 1. get the AOT layer; 2. enable AOT in Lambda function.

### Step 1. Get AOT layer
Lambda layer is regionalized resource, make sure the AOT layer is at the same region with your Lambda function.

~~**Option #1 Public Lambda layer(Not ready in Dec preview)**~~

~~Find public layer ARN in [release note](docs/release-notes/py38.md)~~

#### Option #2 Build AOT Lambda layer from scratch. 

As a contributor you may want to build everything from scratch
1. Install [SAM CLI](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html)
2. Download this repo
3. cd sample-apps/python-lambda && ./run.sh 

Tips:
- `run.sh` will compile AOT layer in local and publish both AOT layer and Sample app to personal account. If no need Sample app, use `./run.sh -t layer.yml`
- To publish AOT layer to other regions use `-r`, for example `./run.sh -r us-west-2`
- Query the layer ARN by `./run.sh -l`. If want to query the layer ARN in region us-east-1, use `./run.sh -l -r us-east-1`(suppose you have built and published AOT layer in this region)


### Step 2. Enable AOT auto-instrumentation for your lambda function

Now you have the AOT layer ARN in previous step. To enable AOT in Lambda function needs: 1. Add AOT layer; 2. Add environment variable `AWS_LAMBDA_EXEC_WRAPPER = /opt/python/aot-instrument`; 3. Enable tracing. 

#### Option #1 Enable AOT by Console

1. Open Lambda function in aws console -> **Layers** in Designer-> **Add a layer** -> **Specify an ARN** -> paste the AOT layer ARN and click **Add**

    <details>

    ![](./docs/images/sample4.png)

    </details>

2. Add environment variable `AWS_LAMBDA_EXEC_WRAPPER = /opt/python/aot-instrument` in Lambda function.

    <details>

    ![](./docs/images/sample5.png)

    </details>

3. Enable tracing

    <details>

    ![](./docs/images/sample6.png)

    </details>


#### Option #2 Enable AOT by [CloudFormation template](https://docs.amazonaws.cn/en_us/lambda/latest/dg/configuration-layers.html#configuration-layers-cloudformation)

```yaml
      Environment:
        Variables:
          AWS_LAMBDA_EXEC_WRAPPER: /opt/python/aot-instrument
      Tracing: Active
      Layers:
        - <AOT layer ARN>
```

#### Option #3 Enable AOT by [AWS CLI](https://docs.aws.amazon.com/cli/latest/reference/lambda/update-function-configuration.html)

```shell
aws lambda update-function-configuration --function-name <your lambda function name> --layers <AOT layer ARN> --environment Variables="{AWS_LAMBDA_EXEC_WRAPPER=/opt/python/aot-instrument}" --tracing-config "Mode=Active"
```
Tips:
- Lambda layer is reginalized artifact, make sure pick up the correct layer ARN.
- Command `aws lambda update-function-configuration` would override Lambda layer and environment variables in existing function. If your function already has other layers and environment variables, need to add them in upper command. For example, if your function already has an environment variable `A=a`, the command should become `--environment Variables="{AWS_LAMBDA_EXEC_WRAPPER=/opt/python/aot-instrument,A=a}"`. Ref [AWS Doc](https://docs.aws.amazon.com/cli/latest/reference/lambda/update-function-configuration.html)



### Offload AOT from your lambda function
Similar with Enable AOT in Lambda function. To offload AOT just need to remove AOT layer and remove the environment variable `AWS_LAMBDA_EXEC_WRAPPER`.

***

## Configuration
AOT Python Lambda layer combines both SDK and [Collector](https://github.com/aws-observability/aws-otel-collector#overview). The configuration of Collecor follows OpenTelemetry standard.

- By default AOT in Lambda uses [config.yaml](../../extensions/aoc-extension/config.yaml), exports telemetry data to AWS X-Ray and CloudWatch.

    Turn on logging exporter in Collector for debug by adding environment variable `AOT_DEBUG=true` in Lambda function.

- Customize Collector config
    
    There are 2 ways to set customized Collector configuration:
    1. Bring customized config file(and ca/cert/key files) into Lambda sandbox by Lambda layer, then set the Collector config by environment variable `AOT_CONFIG=<your config file path>` 
    2. Add environment variable `AOT_CONFIG_CONTENT=<Full content of your config file>`.
    
    For some cases need ca/cert/key files like OTLP gRPC/HTTP exporter secure mode, user has to bring files into Lambda by his layer. Ref [blog](https://dev.to/leading-edje/aws-lambda-layer-for-private-certificates-465j).
    
***

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.

