# Introduction

This integration test will test confmap providers: s3, http and https.

It works by storing the AMP workspace that is unique to the test case in the remote location
, and after that this remote configuration is referenced in the main configuration using configuration expansion.

The validation will only work if the remote endpoint is really accessible by the lambda layer.
