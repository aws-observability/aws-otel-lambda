#!/bin/bash

./gradlew build

mkdir -p ../opentelemetry-lambda/java/build/extensions
cp ./build/libs/aws-otel-lambda-java-extensions.jar ../opentelemetry-lambda/java/build/extensions

cd ../opentelemetry-lambda/java || exit

./gradlew build -Potel.lambda.javaagent.dependency=software.amazon.opentelemetry:aws-opentelemetry-agent:1.0.0-aws.1
