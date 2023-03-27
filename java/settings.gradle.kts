pluginManagement {
    plugins {
        id("com.diffplug.spotless") version "6.17.0"
        id("com.github.ben-manes.versions") version "0.46.0"
        id("com.github.johnrengelman.shadow") version "7.1.2"
    }
}

dependencyResolutionManagement {
    repositories {
        mavenCentral()
        mavenLocal()
    }
}

rootProject.name = "aws-otel-lambda-java"
