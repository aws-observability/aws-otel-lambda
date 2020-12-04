#!/bin/bash

set -e
set -u

echo_usage () {
    echo "usage: distribution"
}

invoke() {
    apiid=$(aws cloudformation describe-stack-resource --stack-name $stack --region $region --logical-resource-id api --query 'StackResourceDetail.PhysicalResourceId' --output text)
    for ((i=1; i<=$invokes; i ++))
        do
            echo $i
            curl https://$apiid.execute-api.$region.amazonaws.com/api/
            sleep $interval
        done
    echo "invoke complete"
}

main () {
    saved_args="$@"
    invokes=0
    interval=5
    template='template.yml'
    publishSar=false
    deployApp=false
    layer=false
    deleteResources=false
    stack=${STACK-"aot-py38-sample"}
    accountid=$ACCOUNT_ID
    accountid2=$ACCOUNT_ID_2
    sarApp=${SAR-"AWS-Distro-for-OpenTelemetry-Python-38-Sample"}
    region=${AWS_REGION-$(aws configure get region)}

    while getopts "epdlr:s:n:i:a:t:" opt; do
        case "${opt}" in
            h) echo_usage
                exit 0
                ;;
            r) region="${OPTARG}"
                ;;
            s) stack="${OPTARG}"
                ;;
            n) invokes=${OPTARG}
                ;;
            i) interval=${OPTARG}
                ;;
            a) accountid=${OPTARG}
                ;;
            t) template=${OPTARG}
                ;;
            p) publishSar=true
                ;;
            d) deployApp=true
                ;;
            l) layer=true
                ;;
            e) deleteResources=true
                ;;
            \?) echo "Invalid option: -${OPTARG}" >&2
                exit 1
                ;;
            :)  echo "Option -${OPTARG} requires an argument" >&2
                exit 1
                ;;
        esac
    done

    if [[ $template == "layer.yml" ]]; then
        sarApp=${SAR-"AWS-Distro-for-OpenTelemetry-Python-38"}
    fi

    if [[ $publishSar == true ]]; then
        aws serverlessrepo delete-application --region $region --application-id arn:aws:serverlessrepo:$region:$accountid:applications/$sarApp || true
        sleep 30

        sam package --region $region --resolve-s3 --force-upload --output-template-file package.yml
        sam publish --region $region -t package.yml
        sleep 120

        aws serverlessrepo put-application-policy --application-id arn:aws:serverlessrepo:$region:$accountid:applications/$sarApp \
		    --region $region --statements Principals='*',Actions=Deploy
        sleep 60
    fi

    if [[ $deployApp == true ]]; then
        echo "deleting old stack..."
        $(aws cloudformation delete-stack --stack-name $stack --region $region) || true
        aws cloudformation wait stack-delete-complete --stack-name $stack --region $region || true
        echo "delete stack done"

        echo "creating cloudformation template..."
        templateUrl=$(aws --region $region serverlessrepo create-cloud-formation-template --application-id arn:aws:serverlessrepo:us-east-1:$accountid:applications/$sarApp --output text --query 'TemplateUrl')
        echo $templateUrl

        sleep 60
        
        echo "creating new stack..."
        rlt=$(aws cloudformation create-stack --template-url $templateUrl --stack-name $stack --region $region --capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND)
        echo $rlt
        aws cloudformation wait stack-create-complete --stack-name $stack --region $region
        echo "create stack done"
    fi

    if [[ $invokes != 0 ]]; then
        invoke
    fi

    if [[ $layer == true ]]; then
        if [[ $template == "layer.yml" ]]; then
            layerArn=$(aws cloudformation describe-stack-resources --stack-name $stack --region $region --query 'StackResources[0].PhysicalResourceId' --output text)
        else
            function=$(aws cloudformation describe-stack-resource --stack-name $stack --region $region --logical-resource-id function --query 'StackResourceDetail.PhysicalResourceId' --output text)
            layerArn=$(aws lambda get-function --function-name $function --region $region --query 'Configuration.Layers[0].Arn' --output text)
        fi
        echo $layerArn
    fi

    if [[ $deleteResources == true ]]; then
        aws cloudformation delete-stack --stack-name $stack --region $region
        aws cloudformation wait stack-delete-complete --stack-name $stack --region $region
        aws serverlessrepo delete-application --region $region --application-id arn:aws:serverlessrepo:$region:$accountid:applications/$sarApp || true
    fi
}

main "$@"
