pluginManagement {
    plugins {
        id("com.diffplug.spotless") version "5.8.2"
        id("com.github.ben-manes.versions") version "0.36.0"
        id("com.github.johnrengelman.shadow") version "6.1.0"
    }
}

dependencyResolutionManagement {
    repositories {
        mavenCentral()
        mavenLocal()
    }
}

rootProject.name = "aws-otel-lambda-java"
