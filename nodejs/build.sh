#!/bin/bash

set -x

SOURCEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Build the sdk layer and sample apps

cd wrapper-adot || exit
npm install || exit

cd ../../opentelemetry-lambda/nodejs || exit
npm install && npm run build|| exit

mv ./packages/layer/build/workspace/otel-handler ./packages/layer/build/workspace/otel-handler-upstream
cp "$SOURCEDIR"/scripts/otel-handler ./packages/layer/build/workspace/otel-handler
# This assumes that generators and propagators does not have additional dependencies outside of normal OTel ones.
# It's inconceivable for this to ever be incorrect.
cp -r "$SOURCEDIR"/wrapper-adot/node_modules/@opentelemetry ./packages/layer/build/workspace/node_modules/
cp "$SOURCEDIR"/wrapper-adot/build/src/adot-extension.* ./packages/layer/build/workspace/

cd ./packages/layer/build/workspace || exit
rm ../layer.zip
unzip -qo ../../../../../collector/build/opentelemetry-collector-layer-$1.zip
zip -qr ../layer.zip *
