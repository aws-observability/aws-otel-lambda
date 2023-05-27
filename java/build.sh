#!/bin/bash

SOURCEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"


## revert https://github.com/open-telemetry/opentelemetry-java-instrumentation/pull/7970

git clone https://github.com/open-telemetry/opentelemetry-java-instrumentation.git
pushd opentelemetry-java-instrumentation
git checkout v1.26.0 -b tag-v1.26.0
patch -p1 < "$SOURCEDIR"/../patches/opentelemetry-java-instrumentation.patch
git add -A
git commit -m "Create patch version"
./gradlew publishToMavenLocal
popd

rm -rf opentelemetry-java-instrumentation


git clone https://github.com/aws-observability/aws-otel-java-instrumentation.git

pushd aws-otel-java-instrumentation

git checkout v1.26.0 -b tag-v1.26.0
patch -p1 < "${SOURCEDIR}"/../patches/aws-otel-java-instrumentation.patch
git add -A
git commit -a -m "Create patch version"
CI=false ./gradlew publishToMavenLocal -Prelease.version=1.26.0-adot-lambda1
popd

rm -rf aws-otel-java-instrumentation

# Build collector

pushd ../opentelemetry-lambda/collector || exit
make package
popd || exit

# Build ADOT Lambda Java SDK Layer Code

./gradlew build

# Move the ADOT Lambda Java SDK code into OTel Lambda Java folder
mkdir -p ../opentelemetry-lambda/java/layer-wrapper/build/extensions
cp ./build/libs/aws-otel-lambda-java-extensions.jar ../opentelemetry-lambda/java/layer-wrapper/build/extensions

# Go to OTel Lambda Java folder
cd ../opentelemetry-lambda/java || exit
patch -p2 < "${SOURCEDIR}/../patches/opentelemetry-lambda_java.patch"
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
unzip -qo ${SOURCEDIR}/../opentelemetry-lambda/collector/build/opentelemetry-collector-layer-$1.zip
zip -qr opentelemetry-java-wrapper.zip *
popd || exit
