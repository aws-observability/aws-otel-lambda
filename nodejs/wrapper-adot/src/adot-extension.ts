import { propagation } from '@opentelemetry/api';
import { CompositePropagator, HttpTraceContext } from '@opentelemetry/core';
import { NodeTracerConfig } from '@opentelemetry/node';
import {
  B3SinglePropagator,
  B3MultiPropagator,
} from '@opentelemetry/propagator-b3';
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
        new HttpTraceContext(),
        new B3SinglePropagator(),
        new B3MultiPropagator(),
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
