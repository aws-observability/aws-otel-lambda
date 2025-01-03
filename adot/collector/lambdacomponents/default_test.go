/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

package lambdacomponents

//github.com/aws-observability/aws-otel-lambda/adot/collector/lambdacomponents

import (
	"go.opentelemetry.io/collector/component"
	"testing"

	"github.com/stretchr/testify/assert"
)

const (
	exportersCount  = 6
	receiversCount  = 1
	extensionsCount = 1
)

func TestComponents(t *testing.T) {
	factories, err := Components()
	assert.NoError(t, err)
	exporters := factories.Exporters
	assert.Len(t, exporters, exportersCount)
	// aws exporters
	assert.NotNil(t, exporters[component.MustNewType("awsxray")])
	assert.NotNil(t, exporters[component.MustNewType("awsemf")])
	// core exporters
	assert.NotNil(t, exporters[component.MustNewType("debug")])
	assert.NotNil(t, exporters[component.MustNewType("otlp")])
	assert.NotNil(t, exporters[component.MustNewType("otlphttp")])
	// other exporters
	assert.NotNil(t, exporters[component.MustNewType("prometheusremotewrite")])

	receivers := factories.Receivers
	assert.Len(t, receivers, receiversCount)
	// core receivers
	assert.NotNil(t, receivers[component.MustNewType("otlp")])

	extensions := factories.Extensions
	assert.Len(t, extensions, extensionsCount)
	// aws extensions
	assert.NotNil(t, extensions[component.MustNewType("sigv4auth")])
}
