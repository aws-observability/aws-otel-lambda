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
        googleJavaFormat("1.15.0")
    }
}

val javaagentDependency by configurations.creating {
    extendsFrom()
}

dependencies {
    compileOnly(platform("io.opentelemetry:opentelemetry-bom:1.32.0"))
    compileOnly(platform("io.opentelemetry:opentelemetry-bom-alpha:1.32.0-alpha"))
    // Already included in wrapper so compileOnly
    compileOnly("io.opentelemetry:opentelemetry-sdk-extension-autoconfigure-spi")
    compileOnly("io.opentelemetry:opentelemetry-sdk-extension-aws")
    javaagentDependency("software.amazon.opentelemetry:aws-opentelemetry-agent:1.32.2")
}

tasks.register<Copy>("download") {
    from(javaagentDependency)
    into("$buildDir/javaagent")
}

tasks.named("build") {
    dependsOn("download")
}
