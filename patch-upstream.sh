#!/bin/bash
set -e
: <<'END_DOCUMENTATION'
`patch-upstream.sh`

This script patches the git submodule folder `opentelemetry-lambda` with ADOT
recommended configuration. The upstream repo is vendor agnostic, but we modify
it slightly to create Lambda Layers that should help OpenTelemetry users trace
their Lambdas with Lambda Layers configured to export to the X-Ray backend.

END_DOCUMENTATION

# Run unit tests on ADOT lambdacomponents
make --directory=adot/collector/lambdacomponents

# Patch some upstream components with ADOT specific components
cp -rf adot/* opentelemetry-lambda/

# Get current repo path
CURRENT_DIR=$PWD

# Move to the upstream OTel Lambda Collector folder where we will build a
# collector used in each Lambda layer
cd opentelemetry-lambda/collector

# patch otel version on collector/go.mod
PATCH_OTEL_VERSION="../../OTEL_Version.patch"

if [ -f $PATCH_OTEL_VERSION ]; then
    patch -p2 < $PATCH_OTEL_VERSION;
fi

# patch collector startup to remove HTTP and S3 confmap providers
# and set ADOT-specific BuildInfo
patch -p2 < ../../collector.patch

# patch manager.go to remove lambdacomponents attribute
patch -p2 < ../../manager.patch

# Replace OTel Collector with ADOT Collector
go mod edit -replace github.com/open-telemetry/opentelemetry-lambda/collector/lambdacomponents=${CURRENT_DIR}/adot/collector/lambdacomponents

rm -fr go.sum
go mod tidy
