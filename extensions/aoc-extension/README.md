## OpenTelemetry Collector Lambda layer

Run `make publish-layer` to publish OpenTelemetry Collector Lambda layer to your AWS account.

#### To public Lambda layer, run:
```shell script
aws lambda add-layer-version-permission --layer-name <your-lambda-layer-name> --version-number <version-number> \
    --principal "*" --statement-id publish --action lambda:GetLayerVersion
```

Be sure to:

* Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* Config [AWS credential](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)

## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This project is licensed under the Apache-2.0 License.

