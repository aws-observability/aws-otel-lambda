module github.com/aws-observability/aws-otel-lambda/adot/collector/lambdacomponents

go 1.21.0

toolchain go1.22.1

require (
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/awsemfexporter v0.103.0
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/awsxrayexporter v0.103.0
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/prometheusremotewriteexporter v0.103.0
	github.com/open-telemetry/opentelemetry-collector-contrib/extension/sigv4authextension v0.103.0
	github.com/stretchr/testify v1.9.0
	go.opentelemetry.io/collector/component v0.103.0
	go.opentelemetry.io/collector/exporter v0.103.0
	go.opentelemetry.io/collector/exporter/loggingexporter v0.103.0
	go.opentelemetry.io/collector/exporter/otlpexporter v0.103.0
	go.opentelemetry.io/collector/exporter/otlphttpexporter v0.103.0
	go.opentelemetry.io/collector/extension v0.103.0
	go.opentelemetry.io/collector/otelcol v0.103.0
	go.opentelemetry.io/collector/receiver v0.103.0
	go.opentelemetry.io/collector/receiver/otlpreceiver v0.103.0
	go.uber.org/multierr v1.11.0
)

require (
	github.com/aws/aws-sdk-go v1.54.6 // indirect
	github.com/aws/aws-sdk-go-v2 v1.30.0 // indirect
	github.com/aws/aws-sdk-go-v2/config v1.27.21 // indirect
	github.com/aws/aws-sdk-go-v2/credentials v1.17.21 // indirect
	github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.16.8 // indirect
	github.com/aws/aws-sdk-go-v2/internal/configsources v1.3.12 // indirect
	github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.6.12 // indirect
	github.com/aws/aws-sdk-go-v2/internal/ini v1.8.0 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.11.2 // indirect
	github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.11.14 // indirect
	github.com/aws/aws-sdk-go-v2/service/sso v1.21.1 // indirect
	github.com/aws/aws-sdk-go-v2/service/ssooidc v1.25.1 // indirect
	github.com/aws/aws-sdk-go-v2/service/sts v1.29.1 // indirect
	github.com/aws/smithy-go v1.20.2 // indirect
	github.com/beorn7/perks v1.0.1 // indirect
	github.com/cenkalti/backoff/v4 v4.3.0 // indirect
	github.com/cespare/xxhash/v2 v2.3.0 // indirect
	github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc // indirect
	github.com/felixge/httpsnoop v1.0.4 // indirect
	github.com/fsnotify/fsnotify v1.7.0 // indirect
	github.com/go-logr/logr v1.4.2 // indirect
	github.com/go-logr/stdr v1.2.2 // indirect
	github.com/go-ole/go-ole v1.3.0 // indirect
	github.com/go-viper/mapstructure/v2 v2.0.0 // indirect
	github.com/gogo/protobuf v1.3.2 // indirect
	github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da // indirect
	github.com/golang/snappy v0.0.4 // indirect
	github.com/google/uuid v1.6.0 // indirect
	github.com/grpc-ecosystem/grpc-gateway/v2 v2.20.0 // indirect
	github.com/hashicorp/go-version v1.7.0 // indirect
	github.com/inconshreveable/mousetrap v1.1.0 // indirect
	github.com/jmespath/go-jmespath v0.4.0 // indirect
	github.com/json-iterator/go v1.1.12 // indirect
	github.com/klauspost/compress v1.17.9 // indirect
	github.com/knadh/koanf v1.5.0 // indirect
	github.com/knadh/koanf/v2 v2.1.1 // indirect
	github.com/lufia/plan9stats v0.0.0-20240513124658-fba389f38bae // indirect
	github.com/mitchellh/copystructure v1.2.0 // indirect
	github.com/mitchellh/reflectwalk v1.0.2 // indirect
	github.com/modern-go/concurrent v0.0.0-20180306012644-bacd9c7ef1dd // indirect
	github.com/modern-go/reflect2 v1.0.2 // indirect
	github.com/mostynb/go-grpc-compression v1.2.3 // indirect
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/awsutil v0.103.0 // indirect
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/cwlogs v0.103.0 // indirect
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/metrics v0.103.0 // indirect
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/aws/xray v0.103.0 // indirect
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/coreinternal v0.103.0 // indirect
	github.com/open-telemetry/opentelemetry-collector-contrib/pkg/resourcetotelemetry v0.103.0 // indirect
	github.com/open-telemetry/opentelemetry-collector-contrib/pkg/translator/prometheus v0.103.0 // indirect
	github.com/open-telemetry/opentelemetry-collector-contrib/pkg/translator/prometheusremotewrite v0.103.0 // indirect
	github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2 // indirect
	github.com/power-devops/perfstat v0.0.0-20240221224432-82ca36839d55 // indirect
	github.com/prometheus/client_golang v1.19.1 // indirect
	github.com/prometheus/client_model v0.6.1 // indirect
	github.com/prometheus/common v0.54.0 // indirect
	github.com/prometheus/procfs v0.15.1 // indirect
	github.com/prometheus/prometheus v0.53.0 // indirect
	github.com/rs/cors v1.11.0 // indirect
	github.com/shirou/gopsutil/v4 v4.24.5 // indirect
	github.com/shoenig/go-m1cpu v0.1.6 // indirect
	github.com/spf13/cobra v1.8.1 // indirect
	github.com/spf13/pflag v1.0.5 // indirect
	github.com/tidwall/gjson v1.17.1 // indirect
	github.com/tidwall/match v1.1.1 // indirect
	github.com/tidwall/pretty v1.2.1 // indirect
	github.com/tidwall/tinylru v1.2.1 // indirect
	github.com/tidwall/wal v1.1.7 // indirect
	github.com/tklauser/go-sysconf v0.3.14 // indirect
	github.com/tklauser/numcpus v0.8.0 // indirect
	github.com/yusufpapurcu/wmi v1.2.4 // indirect
	go.opencensus.io v0.24.0 // indirect
	go.opentelemetry.io/collector v0.103.0 // indirect
	go.opentelemetry.io/collector/config/configauth v0.103.0 // indirect
	go.opentelemetry.io/collector/config/configcompression v1.10.0 // indirect
	go.opentelemetry.io/collector/config/configgrpc v0.103.0 // indirect
	go.opentelemetry.io/collector/config/confighttp v0.103.0 // indirect
	go.opentelemetry.io/collector/config/confignet v0.103.0 // indirect
	go.opentelemetry.io/collector/config/configopaque v1.10.0 // indirect
	go.opentelemetry.io/collector/config/configretry v0.103.0 // indirect
	go.opentelemetry.io/collector/config/configtelemetry v0.103.0 // indirect
	go.opentelemetry.io/collector/config/configtls v0.103.0 // indirect
	go.opentelemetry.io/collector/config/internal v0.103.0 // indirect
	go.opentelemetry.io/collector/confmap v0.103.0 // indirect
	go.opentelemetry.io/collector/confmap/converter/expandconverter v0.103.0 // indirect
	go.opentelemetry.io/collector/confmap/provider/envprovider v0.103.0 // indirect
	go.opentelemetry.io/collector/confmap/provider/fileprovider v0.103.0 // indirect
	go.opentelemetry.io/collector/confmap/provider/httpprovider v0.103.0 // indirect
	go.opentelemetry.io/collector/confmap/provider/httpsprovider v0.103.0 // indirect
	go.opentelemetry.io/collector/confmap/provider/yamlprovider v0.103.0 // indirect
	go.opentelemetry.io/collector/connector v0.103.0 // indirect
	go.opentelemetry.io/collector/consumer v0.103.0 // indirect
	go.opentelemetry.io/collector/extension/auth v0.103.0 // indirect
	go.opentelemetry.io/collector/featuregate v1.10.0 // indirect
	go.opentelemetry.io/collector/pdata v1.10.0 // indirect
	go.opentelemetry.io/collector/processor v0.103.0 // indirect
	go.opentelemetry.io/collector/semconv v0.103.0 // indirect
	go.opentelemetry.io/collector/service v0.103.0 // indirect
	go.opentelemetry.io/contrib/config v0.7.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.52.0 // indirect
	go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.52.0 // indirect
	go.opentelemetry.io/contrib/propagators/b3 v1.27.0 // indirect
	go.opentelemetry.io/otel v1.27.0 // indirect
	go.opentelemetry.io/otel/bridge/opencensus v1.27.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlpmetric/otlpmetricgrpc v1.27.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlpmetric/otlpmetrichttp v1.27.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace v1.27.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracegrpc v1.27.0 // indirect
	go.opentelemetry.io/otel/exporters/otlp/otlptrace/otlptracehttp v1.27.0 // indirect
	go.opentelemetry.io/otel/exporters/prometheus v0.49.0 // indirect
	go.opentelemetry.io/otel/exporters/stdout/stdoutmetric v1.27.0 // indirect
	go.opentelemetry.io/otel/exporters/stdout/stdouttrace v1.27.0 // indirect
	go.opentelemetry.io/otel/metric v1.27.0 // indirect
	go.opentelemetry.io/otel/sdk v1.27.0 // indirect
	go.opentelemetry.io/otel/sdk/metric v1.27.0 // indirect
	go.opentelemetry.io/otel/trace v1.27.0 // indirect
	go.opentelemetry.io/proto/otlp v1.3.1 // indirect
	go.uber.org/zap v1.27.0 // indirect
	golang.org/x/exp v0.0.0-20240613232115-7f521ea00fb8 // indirect
	golang.org/x/net v0.26.0 // indirect
	golang.org/x/sys v0.21.0 // indirect
	golang.org/x/text v0.16.0 // indirect
	gonum.org/v1/gonum v0.15.0 // indirect
	google.golang.org/genproto/googleapis/api v0.0.0-20240624140628-dc46fd24d27d // indirect
	google.golang.org/genproto/googleapis/rpc v0.0.0-20240624140628-dc46fd24d27d // indirect
	google.golang.org/grpc v1.64.0 // indirect
	google.golang.org/protobuf v1.34.2 // indirect
	gopkg.in/yaml.v3 v3.0.1 // indirect
)
