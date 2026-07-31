plugins {
    java

    id("com.diffplug.spotless")
}

base.archivesBaseName = "aws-otel-lambda-java-extensions"
group = "software.amazon.opentelemetry.lambda"

val openTelemetryVersion = "1.32.0"
val openTelemetryAlphaVersion = "1.32.0-alpha"
val junitVersion = "5.10.1"

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
    compileOnly(platform("io.opentelemetry:opentelemetry-bom:$openTelemetryVersion"))
    compileOnly(platform("io.opentelemetry:opentelemetry-bom-alpha:$openTelemetryAlphaVersion"))
    // opentelemetry-api and opentelemetry-context are already provided by the wrapper layer at
    // runtime, so they are compileOnly here.
    compileOnly("io.opentelemetry:opentelemetry-api")
    compileOnly("io.opentelemetry:opentelemetry-context")
    // Already included in wrapper so compileOnly
    compileOnly("io.opentelemetry:opentelemetry-sdk-extension-autoconfigure-spi")
    compileOnly("io.opentelemetry:opentelemetry-sdk-extension-aws")
    javaagentDependency("software.amazon.opentelemetry:aws-opentelemetry-agent:1.32.0-adot-lambda1")

    testImplementation(platform("io.opentelemetry:opentelemetry-bom:$openTelemetryVersion"))
    testImplementation("io.opentelemetry:opentelemetry-api")
    testImplementation("io.opentelemetry:opentelemetry-context")
    testImplementation("io.opentelemetry:opentelemetry-sdk-extension-autoconfigure-spi")
    // Supplies the X-Ray propagator the wrapper layer configures at runtime; needed here only to
    // exercise the fallback path in tests.
    testImplementation(
        "io.opentelemetry.contrib:opentelemetry-aws-xray-propagator:$openTelemetryAlphaVersion")
    testImplementation("org.junit.jupiter:junit-jupiter:$junitVersion")
}

tasks.register<Copy>("download") {
    from(javaagentDependency)
    into("$buildDir/javaagent")
}

tasks.named("build") {
    dependsOn("download")
}

tasks.test {
    useJUnitPlatform()
}
