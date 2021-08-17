#!/bin/bash

SOURCEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Build the sdk layer and sample apps

./gradlew build

mkdir -p ../opentelemetry-lambda/java/build/extensions
cp ./build/libs/aws-otel-lambda-java-extensions.jar ../opentelemetry-lambda/java/build/extensions

cd ../opentelemetry-lambda/java || exit

./gradlew build -Potel.lambda.javaagent.dependency=software.amazon.opentelemetry:aws-opentelemetry-agent:1.4.0

# Combine the layers

pushd ./layer-javaagent/build/distributions || exit
unzip -qo opentelemetry-javaagent-layer.zip
rm opentelemetry-javaagent-layer.zip
mv otel-handler otel-handler-upstream
cp "$SOURCEDIR"/scripts/otel-handler .
unzip -qo ../../../../collector/build/collector-extension.zip
zip -qr opentelemetry-javaagent-layer.zip *
popd || exit

pushd ./layer-wrapper/build/distributions || exit
unzip -qo opentelemetry-java-wrapper.zip
rm opentelemetry-java-wrapper.zip
mv otel-handler otel-handler-upstream
mv otel-stream-handler otel-stream-handler-upstream
mv otel-proxy-handler otel-proxy-handler-upstream
cp "$SOURCEDIR"/scripts/* .
unzip -qo ../../../../collector/build/collector-extension.zip
zip -qr opentelemetry-java-wrapper.zip *
popd || exit
