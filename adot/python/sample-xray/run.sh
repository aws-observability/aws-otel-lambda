stack=${OTEL_LAMBDA_STACK-"otel-stack"}
sam build -u
sam deploy --stack-name $stack --capabilities CAPABILITY_NAMED_IAM --resolve-s3