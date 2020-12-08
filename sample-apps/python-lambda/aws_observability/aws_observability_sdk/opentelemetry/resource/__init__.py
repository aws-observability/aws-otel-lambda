from os import environ
from opentelemetry.sdk.resources import (
    Resource,
    ResourceDetector,
)


class AwsLambdaResourceDetector(ResourceDetector):
    def detect(self) -> "Resource":
        lambda_handler = environ.get("ORIG_HANDLER", environ.get("_HANDLER"))
        aws_region = environ.get("AWS_REGION")
        function_version = environ.get("AWS_LAMBDA_FUNCTION_VERSION")
        env_resource_map = {
            "cloud.region": aws_region,
            "cloud.provider": "aws",
            "faas.name": lambda_handler,
            "faas.version": function_version
        }
        return Resource(env_resource_map)
