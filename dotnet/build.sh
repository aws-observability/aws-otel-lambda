#!/bin/bash

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Specify the path to the .NET version used 
cp global.json ../opentelemetry-lambda/dotnet/sample-apps/aws-sdk/wrapper/SampleApps

# Build sample app

cd ../opentelemetry-lambda/dotnet/sample-apps/aws-sdk/wrapper/SampleApps || exit
./build.sh
