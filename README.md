# AWS Distro for OpenTelemetry support for AWS Lambda in Python

As an event-driven, serverless computing platform, AWS Lambda runs user's code —knowns as **Lambda function**— in sandbox environment. So, launching OpenTelemetry Collector in Lambda environment needs the help of [AWS Lambda Extensions](https://aws.amazon.com/blogs/compute/introducing-aws-lambda-extensions-in-preview/). This project provides ADOT Lambda layers user can use directly. The layers embed both ADOT Collector(as a Lambda extension) and SDK, Lambda user can onboard OpenTelemetry with this solution out-of-the-box.

[OpenTelemetry Python3.8 Lambda with sample](sample-apps/python-lambda/README.md) (Both SDK and Collector)

[OpenTelemetry Lambda layer](extensions/aoc-extension//README.md) (Collector only)


## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.
