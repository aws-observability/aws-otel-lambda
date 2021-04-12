module github.com/open-telemetry/opentelemetry-lambda/collector/lambdacomponents

go 1.16

replace (
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws => github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws v0.23.0
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/awsxray => github.com/open-telemetry/opentelemetry-collector-contrib/internal/awsxray v0.23.0
)

require (
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/awsemfexporter v0.23.0
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/awsxrayexporter v0.23.0
	go.opentelemetry.io/collector v0.23.0
)