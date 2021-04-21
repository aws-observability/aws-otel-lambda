import { NodeTracerConfig } from '@opentelemetry/node';
import { AWSXRayIdGenerator } from '@opentelemetry/id-generator-aws-xray';

declare global {
  function configureTracer(defaultConfig: NodeTracerConfig): NodeTracerConfig;
}

global.configureTracer = (config: NodeTracerConfig) => {
  return {
    ...config,
    idGenerator: new AWSXRayIdGenerator(),
  };
};
