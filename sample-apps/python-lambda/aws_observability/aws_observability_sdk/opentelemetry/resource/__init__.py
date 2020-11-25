from os import environ
from opentelemetry.sdk.resources import (
    Resource,
    ResourceDetector,
)


class AwsLambdaResourceDetector(ResourceDetector):
    def detect(self) -> "Resource":
        lambda_handler = environ.get("ORIG_HANDLER", environ.get("_HANDLER"))
        aws_region = environ["AWS_REGION"]
        env_resource_map = {
            "cloud.region": aws_region,
            "cloud.provider": "aws",
            "faas.name": lambda_handler,
        }
        return Resource(env_resource_map)
