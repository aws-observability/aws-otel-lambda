#!/bin/bash

set -e
set -u

echo_usage () {
    echo "usage: Deploy AOT Python Lambda layers from scratch"
    echo " -r <aws region>"
    echo " -t <cloudformation template>"
    echo " -b <sam build>"
    echo " -d <sam deploy>"
    echo " -n <invoke lambda 1 times>"
    echo " -l <show layer arn>"
    echo " -s <stack name>"
}

main () {
    echo "running..."
    saved_args="$@"
    template='template.yml'
    build=false
    deploy=false
    debug=false
    invoke=false
    layer=false
    stack=${STACK-"aot-py38-sample"}
    region=${AWS_REGION-$(aws configure get region)}

    while getopts "hbdxnlr:t:s:" opt; do
        case "${opt}" in
            h) echo_usage
                exit 0
                ;;
            b) build=true
                ;;
            x) debug=true
                ;;
            d) deploy=true
                ;;
            n) invoke=true
                ;;
            l) layer=true
                ;;
            r) region="${OPTARG}"
                ;;
            t) template="${OPTARG}"
                ;;
            s) stack="${OPTARG}"
                ;;
            \?) echo "Invalid option: -${OPTARG}" >&2
                exit 1
                ;;
            :)  echo "Option -${OPTARG} requires an argument" >&2
                exit 1
                ;;
        esac
    done

    echo "Invoked with: ${saved_args}"

    if [[ $build == false && $deploy == false && $invoke == false && $layer == false ]]; then
        build=true
        deploy=true
        invoke=true
        layer=true
    fi

    if [[ $build == true ]]; then
        echo "sam building..."
        rm -rf .aws-sam
        rm -rf aws_observability/aws_observability_collector
        mkdir -p aws_observability/aws_observability_collector
        cp -r ../../extensions/aoc-extension/* aws_observability/aws_observability_collector
        sam build -u -t $template
        # find . -name __pycache__ -exec rm -rf  {} \; &>/dev/null
    fi

    if [[ $debug == true ]]; then
        echo "debug mode, show code in lambda console"
        mkdir -p .aws-sam/build/function/opentelemetry/instrumentation/auto_instrumentation/
        mv .aws-sam/build/AwsObservability/python/opentelemetry/instrumentation/auto_instrumentation/__init__.py .aws-sam/build/function/opentelemetry/instrumentation/auto_instrumentation/
        mv .aws-sam/build/AwsObservability/python/opentelemetry/instrumentation/auto_instrumentation/sitecustomize.py .aws-sam/build/function/opentelemetry/instrumentation/auto_instrumentation/
        cp .aws-sam/build/AwsObservability/python/bin/opentelemetry-instrument .aws-sam/build/function
        mv .aws-sam/build/AwsObservability/python/aws_observability.py .aws-sam/build/function/
        mv .aws-sam/build/AwsObservability/python/opentelemetry/instrumentation/aws_lambda .aws-sam/build/function/opentelemetry/instrumentation/
    fi

    if [[ $deploy == true ]]; then
        echo "sam deploying..."
        sam deploy --stack-name $stack --region $region --capabilities CAPABILITY_NAMED_IAM --resolve-s3
        rm -rf aws_observability/aws_observability_collector
    fi

    if [[ $invoke == true ]]; then
        apiid=$(aws cloudformation describe-stack-resource --stack-name $stack --region $region --logical-resource-id api --query 'StackResourceDetail.PhysicalResourceId' --output text)
        curl https://$apiid.execute-api.$region.amazonaws.com/api/ -v
    fi

    if [[ $layer == true ]]; then
        function=$(aws cloudformation describe-stack-resource --stack-name $stack --region $region --logical-resource-id function --query 'StackResourceDetail.PhysicalResourceId' --output text)
        layer=$(aws lambda get-function --function-name $function --region $region --query 'Configuration.Layers[0].Arn' --output text)
        echo -e "\nAOT Python3.8 Lambda layer ARN:"
        echo $layer
    fi
}

main "$@"
