cp -rf adot/* opentelemetry-lambda/
cd opentelemetry-lambda/collector
# replace collector with AOC
go mod edit -replace github.com/open-telemetry/opentelemetry-lambda/collector/lambdacomponents=github.com/open-o11y/aws-otel-collector/pkg/lambdacomponents@v0.10.0
go mod edit -replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/awsutil=github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/awsutil@v0.27.0
go mod edit -replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/metrics=github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/metrics@v0.27.0
go mod edit -replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/xray=github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/xray@v0.27.0
go mod tidy
