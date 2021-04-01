export AOC=$(shell pwd)/aws_observability_collector
export ARTIFACTS_DIR=$(shell pwd)/build

VERSION=$(shell cat $(AOC)/VERSION)
GIT_SHA=$(shell git rev-parse HEAD)
GOBUILD=GO111MODULE=on CGO_ENABLED=0 installsuffix=cgo go build -trimpath
BUILD_INFO_IMPORT_PATH=main

LDFLAGS=-ldflags "-s -w -X $(BUILD_INFO_IMPORT_PATH).GitHash=$(GIT_SHA) -X $(BUILD_INFO_IMPORT_PATH).Version=$(VERSION) \
-X github.com/open-telemetry/opentelemetry-collector-contrib/exporter/awsxrayexporter.collectorDistribution=aws-otel-collector-lambda"

build-AOC:
	rpm --rebuilddb
	which go > /dev/null || yum install -y go
	mkdir -p $(ARTIFACTS_DIR)/extensions
	cd $(AOC) && GOOS=linux GOARCH=amd64 $(GOBUILD) $(LDFLAGS) -o $(ARTIFACTS_DIR)/extensions/ ./cmd/aoc-lambda-extension
	mkdir -p $(ARTIFACTS_DIR)/aoc
	cp $(AOC)/config* $(ARTIFACTS_DIR)/aoc
