pluginManagement {
    plugins {
        id("com.diffplug.spotless") version "6.12.1"
        id("com.github.ben-manes.versions") version "0.45.0"
        id("com.github.johnrengelman.shadow") version "8.0.0"
    }
}

dependencyResolutionManagement {
    repositories {
        mavenCentral()
        mavenLocal()
    }
}

rootProject.name = "aws-otel-lambda-java"
