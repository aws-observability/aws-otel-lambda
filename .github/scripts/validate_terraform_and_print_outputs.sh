#!/bin/bash

: <<'END_DOCUMENTATION'
`validate_terraform_and_print_outputs.sh`

Runs terraform commands and prints its outputs variables to stdout. The script
also checks that terraform was successful by validating the response of a cURL
request to the created API Gateway instance.

END_DOCUMENTATION


TERRAFORM_DIRECTORY=$1
TEST_CASE_UNIQUE_SUFFIX=$2
terraform init
terraform apply \
    -var="sdk_layer_name=adot-sdk-$TEST_CASE_UNIQUE_SUFFIX"
    -var="collector_layer_name=adot-collector-$TEST_CASE_UNIQUE_SUFFIX"
    -var="function_name=adot-test-lambda-$TEST_CASE_UNIQUE_SUFFIX"

$API_GATEWARY_URL=$(terraform output -raw api-gateway-url)

if [ $(curl -sS $API_GATEWARY_URL | grep -Eq 'Root=1-[a-z0-9]{8}-[a-z0-9]{24};Parent=[a-z0-9]{16};Sampled=[a-z0-9]') -neq 0 ]
then
    echo "validate_terraform_and_print_outputs.sh: ERROR - API Gateway response was invalid."
    exit 1
fi

echo "API_GATEWARY_URL=$API_GATEWARY_URL"
# NOTE: Only Java, Python, and NodeJS have sdk layer ARNs
echo "SDK_LAYER_ARN=$(terraform output -raw sdk-layer-arn)"
# NOTE: Only .NET and Go have collector layer ARNs
echo "COLLECTOR_LAYER_ARN=$(terraform output -raw collector-layer-arn)"
# NOTE: Only Java has AMP Metrics for now. In any other case, this env var will
# be empty.
echo "AMP_ENDPOINT=$(terraform output -raw amp_endpoint >/dev/null 2>&1)"
