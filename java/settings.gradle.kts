pluginManagement {
    plugins {
        id("com.diffplug.spotless") version "5.14.3"
        id("com.github.ben-manes.versions") version "0.43.0"
        id("com.github.johnrengelman.shadow") version "7.0.0"
    }
}

dependencyResolutionManagement {
    repositories {
        mavenCentral()
        mavenLocal()
    }
}

rootProject.name = "aws-otel-lambda-java"
