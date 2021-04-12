stack=${OTEL_LAMBDA_STACK-"otel-stack"}

aws cloudformation delete-stack --stack-name $stack || true
aws cloudformation wait stack-delete-complete --stack-name $stack || true