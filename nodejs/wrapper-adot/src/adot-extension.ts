import { propagation } from '@opentelemetry/api';
import { CompositePropagator, HttpTraceContextPropagator } from '@opentelemetry/core';
import { NodeTracerConfig } from '@opentelemetry/sdk-trace-node';
import { B3InjectEncoding, B3Propagator } from '@opentelemetry/propagator-b3';
import { AWSXRayIdGenerator } from '@opentelemetry/id-generator-aws-xray';
import { AWSXRayPropagator } from '@opentelemetry/propagator-aws-xray';

declare global {
  function configureTracer(defaultConfig: NodeTracerConfig): NodeTracerConfig;
}

if (!process.env.OTEL_PROPAGATORS) {
  propagation.setGlobalPropagator(
    new CompositePropagator({
      propagators: [
        new AWSXRayPropagator(),
        new HttpTraceContextPropagator(),
        new B3Propagator(),
        new B3Propagator({ injectEncoding: B3InjectEncoding.MULTI_HEADER }),
      ],
    })
  );
}

global.configureTracer = (config: NodeTracerConfig) => {
  return {
    ...config,
    idGenerator: new AWSXRayIdGenerator(),
  };
};
