#!/bin/bash

SOURCEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Build the sdk layer and sample apps

cd wrapper-adot || exit
npm install

cd ../../opentelemetry-lambda/nodejs || exit
npm install

mv ./packages/layer/build/workspace/otel-handler ./packages/layer/build/workspace/otel-handler-upstream
cp "$SOURCEDIR"/scripts/otel-handler ./packages/layer/build/workspace/otel-handler
# This assumes that generators and propagators does not have additional dependencies outside of normal OTel ones.
# It's inconceivable for this to ever be incorrect.
cp -r "$SOURCEDIR"/wrapper-adot/node_modules/@opentelemetry/id-generator-aws-xray ./packages/layer/build/workspace/nodejs/node_modules/@opentelemetry
cp -r "$SOURCEDIR"/wrapper-adot/node_modules/@opentelemetry/propagator-aws-xray ./packages/layer/build/workspace/nodejs/node_modules/@opentelemetry
cp -r "$SOURCEDIR"/wrapper-adot/node_modules/@opentelemetry/propagator-b3 ./packages/layer/build/workspace/nodejs/node_modules/@opentelemetry
cp "$SOURCEDIR"/wrapper-adot/build/src/adot-extension.* ./packages/layer/build/workspace/

cd ./packages/layer/build/workspace || exit
rm ../layer.zip
unzip -qo ../../../../../collector/build/collector-extension.zip
zip -qr ../layer.zip *
