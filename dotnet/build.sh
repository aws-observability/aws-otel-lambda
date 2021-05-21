#!/bin/bash

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Build sample app

cd ../opentelemetry-lambda/dotnet/sample-apps/aws-sdk/wrapper/SampleApps || exit
./build.sh
