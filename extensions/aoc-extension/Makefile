BASE_SPACE:=$(shell pwd)
BUILD_SPACE:=$(BASE_SPACE)/build
BUCKET_NAME:=lambda-artifacts-$(shell dd if=/dev/random bs=8 count=1 2>/dev/null | od -An -tx1 | tr -d ' \t\n')
AOC_LAYER_NAME:=aoc-layer

clean:
	rm -rf build/

build: clean
	@echo Building AOC extension
	mkdir -p $(BUILD_SPACE)/extensions
	GOOS=linux GOARCH=amd64 go build -o $(BUILD_SPACE)/extensions ./cmd/aoc-lambda-extension

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
