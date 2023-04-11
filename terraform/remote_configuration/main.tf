// This module is used to generate remote uris based on the schema. This module is to test the s3, http and https
// config map providers.

data "aws_caller_identity" "caller" {}

data "aws_region" "region" {}

locals {
  // Name of the bucket, according to the convention
  // {prefix}-{region}-{account id}
  // This bucket is created in the cdk_infra package.
  bucket = "${var.configuration_bucket}-${data.aws_region.region.name}-${data.aws_caller_identity.caller.account_id}"
}

resource "aws_s3_object" "configuration_uri" {
  bucket  = local.bucket
  key     = var.testing_id
  content = var.content
}

resource "null_resource" "presigned_url" {
  depends_on = [
    aws_s3_object.configuration_uri
  ]
  provisioner "local-exec" {
    // https://docs.aws.amazon.com/AmazonS3/latest/userguide/ShareObjectPreSignedURL.html
    // Create uri to access object using http or https.
    command = "aws s3 presign s3://${local.bucket}/${var.testing_id} --expires-in 7200 > uri"
  }
}

data "local_file" "uri" {
  depends_on = [
    null_resource.presigned_url
  ]
  filename = "./uri"
}

locals {
  uri = {
    s3    = "s3://${local.bucket}.s3.${data.aws_region.region.name}.amazonaws.com/${var.testing_id}"
    https = trimspace(data.local_file.uri.content)
    http  = replace(trimspace(data.local_file.uri.content), "/^https:/", "http:")
  }
  configuration_uri = local.uri[var.scheme]
}
