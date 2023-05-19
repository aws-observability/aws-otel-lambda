#!/bin/bash

SOURCEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Build ADOT Lambda Java SDK Layer Code

./gradlew build

# Move the ADOT Lambda Java SDK code into OTel Lambda Java folder
mkdir -p ../opentelemetry-lambda/java/build/extensions
cp ./build/libs/aws-otel-lambda-java-extensions.jar ../opentelemetry-lambda/java/build/extensions

# Go to OTel Lambda Java folder
cd ../opentelemetry-lambda/java || exit

./gradlew build

# Combine Java Agent build and ADOT Collector
pushd ./layer-javaagent/build/distributions || exit
unzip -qo opentelemetry-javaagent-layer.zip
rm opentelemetry-javaagent-layer.zip
mv otel-handler otel-handler-upstream
cp "$SOURCEDIR"/scripts/otel-handler .
# Copy ADOT Java Agent downloaded using Gradle task
cp "$SOURCEDIR"/build/javaagent/aws-opentelemetry-agent*.jar ./opentelemetry-javaagent.jar
unzip -qo ../../../../collector/build/collector-extension-$1.zip
zip -qr opentelemetry-javaagent-layer.zip *
popd || exit

# Combine Java Wrapper build and ADOT Collector
pushd ./layer-wrapper/build/distributions || exit
unzip -qo opentelemetry-java-wrapper.zip
rm opentelemetry-java-wrapper.zip
mv otel-handler otel-handler-upstream
mv otel-stream-handler otel-stream-handler-upstream
mv otel-proxy-handler otel-proxy-handler-upstream
cp "$SOURCEDIR"/scripts/* .
unzip -qo ../../../../collector/build/collector-extension-$1.zip
zip -qr opentelemetry-java-wrapper.zip *
popd || exit
