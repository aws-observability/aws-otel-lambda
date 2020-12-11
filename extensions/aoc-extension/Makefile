BASE_SPACE:=$(shell pwd)
BUILD_SPACE:=$(BASE_SPACE)/build
BUCKET_NAME:=lambda-artifacts-$(shell dd if=/dev/random bs=8 count=1 2>/dev/null | od -An -tx1 | tr -d ' \t\n')
AOC_LAYER_NAME:=aws-otel-collector

VERSION=$(shell cat VERSION)
GIT_SHA=$(shell git rev-parse HEAD)
GOBUILD=GO111MODULE=on CGO_ENABLED=0 installsuffix=cgo go build -trimpath
BUILD_INFO_IMPORT_PATH=main

LDFLAGS=-ldflags "-s -w -X $(BUILD_INFO_IMPORT_PATH).GitHash=$(GIT_SHA) -X $(BUILD_INFO_IMPORT_PATH).Version=$(VERSION) \
-X github.com/open-telemetry/opentelemetry-collector-contrib/exporter/awsxrayexporter.collectorDistribution=aws-otel-collector-lambda"

clean:
	rm -rf build/

build: clean
	@echo Building aws otel collector extension
	mkdir -p $(BUILD_SPACE)/extensions
	GOOS=linux GOARCH=amd64 $(GOBUILD) $(LDFLAGS) -o $(BUILD_SPACE)/extensions ./cmd/aoc-lambda-extension

package:
	@echo Package zip file for aoc extension layer
	mkdir -p $(BUILD_SPACE)/aoc
	cp config* $(BUILD_SPACE)/aoc
	cd $(BUILD_SPACE) && zip -r aoc-extension.zip aoc extensions

publish-layer: build package
	@echo Publish aoc extension layer
	aws s3 mb s3://$(BUCKET_NAME)
	aws s3 cp $(BUILD_SPACE)/aoc-extension.zip s3://$(BUCKET_NAME)
	aws lambda publish-layer-version --layer-name $(AOC_LAYER_NAME) --content S3Bucket=$(BUCKET_NAME),S3Key=aoc-extension.zip --compatible-runtimes nodejs12.x nodejs10.x java11 python3.8 python3.7 --query 'LayerVersionArn' --output text
	aws s3 rm s3://$(BUCKET_NAME)/aoc-extension.zip
	aws s3 rb s3://$(BUCKET_NAME)
