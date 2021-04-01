FROM gradle as build

WORKDIR /app
COPY ./build.gradle ./build.gradle
COPY ./src ./src
COPY ./settings.gradle ./settings.gradle

RUN gradle build
RUN tar -xvf build/distributions/spark-sample-app-1.0.tar
RUN gradle copyDependencies

FROM amazoncorretto:11 

WORKDIR /app
COPY --from=build /app/dependencies/*.jar ./
COPY --from=build /app/spark-sample-app-1.0 .

ENV HOME=/root
ENV OTEL_RESOURCE_ATTRIBUTES 'service.namespace=AWSOTel,service.name=AWSOTelSampleApp'
ENV OTEL_EXPORTER_OTLP_ENDPOINT 'localhost:55680'

ADD aws_observability/build/extensions /opt/extensions
ADD aws_observability/build/aoc /opt/aoc

ENTRYPOINT [ "/usr/bin/java", "-cp", "./*", "com.amazonaws.services.lambda.runtime.api.client.AWSLambda" ]
CMD ["com.amazon.sampleapp.App::handleRequest"]
