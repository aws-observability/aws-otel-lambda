plugins {
    java

    id("com.diffplug.spotless")
}

base.archivesBaseName = "aws-otel-lambda-java-extensions"
group = "software.amazon.opentelemetry.lambda"

repositories {
    mavenCentral()
    mavenLocal()
}

java {
    sourceCompatibility = JavaVersion.VERSION_1_8
    targetCompatibility = JavaVersion.VERSION_1_8
}

spotless {
    java {
        googleJavaFormat("1.9")
    }
}

dependencies {
    compileOnly(platform("io.opentelemetry:opentelemetry-bom:1.25.0"))
    compileOnly(platform("io.opentelemetry:opentelemetry-bom-alpha:1.25.0-alpha"))
    // Already included in wrapper so compileOnly
    compileOnly("io.opentelemetry:opentelemetry-sdk-extension-autoconfigure-spi")
    compileOnly("io.opentelemetry:opentelemetry-sdk-extension-aws")
}
