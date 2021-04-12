stack=${OTEL_LAMBDA_STACK-"sample"}

functionName=$(aws cloudformation describe-stack-resource --stack-name $stack --logical-resource-id function --query 'StackResourceDetail.PhysicalResourceId' --output text)
echo $functionName