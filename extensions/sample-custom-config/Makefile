BASE_SPACE:=$(shell pwd)
BUILD_SPACE:=$(BASE_SPACE)/build
BUCKET_NAME:=custom-config-$(shell dd if=/dev/random bs=8 count=1 2>/dev/null | od -An -tx1 | tr -d ' \t\n')
CONFIG_LAYER_NAME:=adot-config-layer

clean:
	rm -rf build/

package: clean
	@echo Package zip file for aoc config layer
	mkdir -p $(BUILD_SPACE)
	cp -r custom $(BUILD_SPACE)
	cd $(BUILD_SPACE) && zip -r custom.zip custom

publish-config-layer: package
	@echo Publish custom aoc config layer
	aws s3 mb s3://$(BUCKET_NAME)
	aws s3 cp $(BUILD_SPACE)/custom.zip s3://$(BUCKET_NAME)
	aws lambda publish-layer-version --layer-name $(CONFIG_LAYER_NAME) --content S3Bucket=$(BUCKET_NAME),S3Key=custom.zip --compatible-runtimes nodejs12.x nodejs10.x java11 python3.8 python3.7 --query 'LayerVersionArn' --output text
	aws s3 rm s3://$(BUCKET_NAME)/custom.zip
	aws s3 rb s3://$(BUCKET_NAME)
