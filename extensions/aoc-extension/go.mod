module aws-lambda-extensions/aoc-extension

go 1.14

require (
	github.com/aws-observability/aws-otel-collector/pkg/lambdacomponents v0.0.0-20201209210059-5646fb3cdf5c
	github.com/spf13/viper v1.7.1
	go.opentelemetry.io/collector v0.16.0
	go.uber.org/zap v1.16.0
)

replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/awsxray => github.com/open-telemetry/opentelemetry-collector-contrib/internal/awsxray v0.14.1-0.20201111210848-994cabe5d596

replace go.opentelemetry.io/collector => go.opentelemetry.io/collector v0.15.1-0.20201120151746-8ceddba7ea03