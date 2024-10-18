plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
}

kotlin {
    androidTarget {
        compilations.all {
            kotlinOptions {
                jvmTarget = "1.8"
            }
        }
    }
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach {
        it.binaries.framework {
            baseName = "shared"
            isStatic = true
        }
    }

    sourceSets {
        val ktor_version: String by project

        iosMain.dependencies {
            implementation("io.ktor:ktor-client-ios:$ktor_version")
        }

        androidMain.dependencies {
            implementation("io.ktor:ktor-client-android:$ktor_version")
        }
        commonMain.dependencies {
            //put your multiplatform dependencies here
            implementation("io.ktor:ktor-client-core:$ktor_version")
            implementation(libs.kotlinx.datetime)
            implementation(libs.fleeksoft.ksoup.lite)
        }
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }
    }
}

android {
    namespace = "com.brendanperry.radioscannershared"
    compileSdk = 34
    defaultConfig {
        minSdk = 28
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }
}