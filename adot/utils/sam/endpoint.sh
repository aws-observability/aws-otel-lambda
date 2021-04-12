stack=${OTEL_LAMBDA_STACK-"otel-stack"}
region=${AWS_REGION-$(aws configure get region)}

apiid=$(aws cloudformation describe-stack-resource --stack-name $stack --logical-resource-id api --query 'StackResourceDetail.PhysicalResourceId' --output text)
echo https://$apiid.execute-api.$region.amazonaws.com/api/