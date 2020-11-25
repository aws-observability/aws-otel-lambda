BASE_SPACE:=$(shell pwd)
BUILD_SPACE:=$(BASE_SPACE)/build
BUCKET_NAME:=lambda-artifacts-$(shell dd if=/dev/random bs=8 count=1 2>/dev/null | od -An -tx1 | tr -d ' \t\n')
AOC_LAYER_NAME:=aoc-layer-beta

clean:
	rm -rf build/

build: clean
	@echo Building AOC extension
	mkdir -p $(BUILD_SPACE)/extensions
	GOOS=linux GOARCH=amd64 go build -o $(BUILD_SPACE)/extensions *.go

package:
	@echo Package zip file for aoc extension layer
	mkdir -p $(BUILD_SPACE)/otelcol
	cp config.yaml $(BUILD_SPACE)/otelcol
	cd $(BUILD_SPACE) && zip -r aoc-extension.zip otelcol extensions

publish-layer: build package
	@echo Publish aoc extension layer
	@aws s3 mb s3://$(BUCKET_NAME) >/dev/null
	@aws s3 cp $(BUILD_SPACE)/aoc-extension.zip s3://$(BUCKET_NAME) >/dev/null
	@echo $(shell aws lambda publish-layer-version --layer-name my-aoc-layer --content S3Bucket=lambda-artifacts-113a2245a128f349,S3Key=aoc-extension.zip --compatible-runtimes java8.al2 java11 python3.8 python3.7 --query 'LayerVersionArn' --output text)
	@aws s3 rm s3://$(BUCKET_NAME)/aoc-extension.zip >/dev/null
	@aws s3 rb s3://$(BUCKET_NAME) >/dev/null

build-AwsObservabilityCollector:
	rpm --rebuilddb
	yum install -y go
	mkdir -p $(ARTIFACTS_DIR)/extensions
	go build -o $(ARTIFACTS_DIR)/extensions/aoc-extension *.go
	mkdir -p $(ARTIFACTS_DIR)/otelcol
	cp config* $(ARTIFACTS_DIR)/otelcol
