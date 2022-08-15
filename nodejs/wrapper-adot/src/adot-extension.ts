import { CompositePropagator, W3CTraceContextPropagator } from '@opentelemetry/core';
import { SDKRegistrationConfig } from '@opentelemetry/sdk-trace-base';
import { NodeTracerConfig } from '@opentelemetry/sdk-trace-node';
import { B3InjectEncoding, B3Propagator } from '@opentelemetry/propagator-b3';
import { AWSXRayIdGenerator } from '@opentelemetry/id-generator-aws-xray';
import { AWSXRayPropagator } from '@opentelemetry/propagator-aws-xray';

declare global {
  function configureSdkRegistration(defaultSdkRegistration: SDKRegistrationConfig): SDKRegistrationConfig;
  function configureTracer(defaultConfig: NodeTracerConfig): NodeTracerConfig;
}

if (!process.env.OTEL_PROPAGATORS) {
  global.configureSdkRegistration = (config: SDKRegistrationConfig) => {
      return{
        ...config,
        propagator: new CompositePropagator({
          propagators: [
            new AWSXRayPropagator(),
            new W3CTraceContextPropagator(),
            new B3Propagator(),
            new B3Propagator({ injectEncoding: B3InjectEncoding.MULTI_HEADER }),
          ],
        }),
      };
  }
}

global.configureTracer = (config: NodeTracerConfig) => {
  return {
    ...config,
    idGenerator: new AWSXRayIdGenerator(),
  };
};
