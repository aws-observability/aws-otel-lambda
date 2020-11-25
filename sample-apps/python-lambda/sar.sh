#!/bin/bash

set -e
set -u

echo_usage () {
    echo "usage: SAR"
    echo " -p <sam package & publish>"
}

main () {
    echo "running..."
    saved_args="$@"
    package=false
    publish=false
    region='us-east-1'

    while getopts "pdr:" opt; do
        case "${opt}" in
            h) echo_usage
                exit 0
                ;;
            r) region="${OPTARG}"
                ;;
            p) package=true
                ;;
            d) publish=true
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

    if [[ $package == false && $publish == false ]]; then
        package=true
        publish=true
    fi

    if [[ $package == true ]]; then
        sam package --resolve-s3 --force-upload --output-template-file package.yml --region $region
    fi
    

    if [[ $publish == true ]]; then
        sam publish -t package.yml --region $region
    fi
}

main "$@"
