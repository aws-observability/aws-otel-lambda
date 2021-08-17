cp -rf adot/* opentelemetry-lambda/
cd opentelemetry-lambda/collector
# replace collector with AOC
go mod edit -replace github.com/open-telemetry/opentelemetry-lambda/collector/lambdacomponents=github.com/aws-observability/aws-otel-collector/pkg/lambdacomponents@v0.0.0-20210708212027-05f20388cb49
go mod edit -replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/awsutil=github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/awsutil@v0.29.1-0.20210630203112-81d57601b1bc
go mod edit -replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/metrics=github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/metrics@v0.29.1-0.20210630203112-81d57601b1bc
go mod edit -replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/xray=github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/xray@v0.29.1-0.20210630203112-81d57601b1bc
go mod tidy
