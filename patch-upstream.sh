cp -rf adot/* opentelemetry-lambda/
cd opentelemetry-lambda/collector
# temporary unblock lambdaComponent patch, will update to aws-otel-lambda/lambdaComponent soon
# go mod edit -replace github.com/open-telemetry/opentelemetry-lambda/collector/lambdacomponents=github.com/aws-observability/aws-otel-collector/pkg/lambdacomponents@0.8.2
go mod edit -replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws=github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws@v0.23.0
go mod edit -replace github.com/open-telemetry/opentelemetry-collector-contrib/internal/awsxray=github.com/open-telemetry/opentelemetry-collector-contrib/internal/awsxray@v0.23.0
go mod tidy
