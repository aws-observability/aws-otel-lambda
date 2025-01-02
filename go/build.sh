#!/bin/bash

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Build sample app

cd ../opentelemetry-lambda/go/sample-apps/function || exit
go mod tidy
CGO_ENABLED=0 ./build.sh
