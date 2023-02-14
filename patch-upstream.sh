#!/bin/bash

: <<'END_DOCUMENTATION'
`patch-upstream.sh`

This script patches the git submodule folder `opentelemetry-lambda` with ADOT
recommended configuration. The upstream repo is vendor agnostic, but we modify
it slightly to create Lambda Layers that should help OpenTelemetry users trace
their Lambdas with Lambda Layers configured to export to the X-Ray backend.

END_DOCUMENTATION

# Patch some upstream components with ADOT specific components
cp -rf adot/* opentelemetry-lambda/

# Move to the upstream OTel Lambda Collector folder where we will build a
# collector used in each Lambda layer
cd opentelemetry-lambda/collector

pwd

ls

# patch collector startup to remove HTTP and S3 confmap providers
# and set ADOT-specific BuildInfo
patch < ../../collector.patch

# patch manager.go to remove lambdacomponents attribute
patch < ../../manager.patch

# Replace OTel Collector with ADOT Collector
go mod edit -replace github.com/open-telemetry/opentelemetry-lambda/collector/lambdacomponents=github.com/aws-observability/aws-otel-collector/pkg/lambdacomponents@v0.26.0

rm -fr go.sum
go mod tidy
