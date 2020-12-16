module aws-lambda-extensions/aoc-extension

go 1.14

require (
	github.com/aws-observability/aws-otel-collector/pkg/lambdacomponents v0.6.0
	github.com/spf13/cobra v1.1.1
	github.com/spf13/viper v1.7.1
	go.opentelemetry.io/collector v0.16.1-0.20201207152538-326931de8c32
	go.uber.org/zap v1.16.0
)

replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/awsxray => github.com/open-telemetry/opentelemetry-collector-contrib/internal/awsxray v0.16.0
