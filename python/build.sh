#!/bin/bash

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Build sdk layer

cd ../opentelemetry-lambda/python/src || exit
./build.sh

pushd ../sample-apps || exit
./build.sh
popd || exit

# Combine the layers
cd ./build || exit
unzip -qo layer.zip
rm layer.zip
unzip -qo ../../../collector/build/collector-extension.zip
zip -qr layer.zip *
