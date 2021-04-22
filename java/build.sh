#!/bin/bash

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Build the sdk layer and sample apps

./gradlew build

mkdir -p ../opentelemetry-lambda/java/build/extensions
cp ./build/libs/aws-otel-lambda-java-extensions.jar ../opentelemetry-lambda/java/build/extensions

cd ../opentelemetry-lambda/java || exit

./gradlew build -Potel.lambda.javaagent.dependency=software.amazon.opentelemetry:aws-opentelemetry-agent:1.0.0-aws.1

# Combine the layers

pushd ./layer-javaagent/build/distributions || exit
unzip -qo opentelemetry-javaagent-layer.zip
rm opentelemetry-javaagent-layer.zip
unzip -qo ../../../../collector/build/collector-extension.zip
zip -qr opentelemetry-javaagent-layer.zip *
popd || exit

pushd ./layer-wrapper/build/distributions || exit
unzip -qo opentelemetry-java-wrapper.zip
rm opentelemetry-java-wrapper.zip
unzip -qo ../../../../collector/build/collector-extension.zip
zip -qr opentelemetry-java-wrapper.zip *
popd || exit
