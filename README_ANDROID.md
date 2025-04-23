#### Download SDK
- SDK must place in `Plugin > android > libs` folder
- libs folder:
```
- libs
-- buld.gradle
-- mobilertc.arr
```

#### Adjust SDK build.gradle
- We change build.gradle into below format, to let plugin include the dependencies required by Zoom SDK
```
ext.sdkDependenciesList = [
    "androidx.security:security-crypto:1.1.0-alpha05",
    "com.google.crypto.tink:tink-android:1.7.0",
    // ...
]
```

#### Adjust app build.gradle.kts
- Might need to adjust follow below:
```
android {
    // ...
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17

        isCoreLibraryDesugaringEnabled = true 
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        minSdk = 26
    }

    // ...
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
```