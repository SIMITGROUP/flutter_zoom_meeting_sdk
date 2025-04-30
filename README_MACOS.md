# Setup macOS

## Download SDK

- Download the Zoom macOS SDK from the [Zoom App Marketplace](https://marketplace.zoom.us/)
- Create a folder and place the SDK contents inside it

Example:
```bash
<YourApp>/
├── macos/
├── ...
└── ZoomSDK/
    └── macOS/
        ├── Plugins/
        │   └── ...
        └── ZoomSDK/
            └── ...
```

## Configure In Xcode

Navigate to `<YourApp>/macos` and open it with Xcode.  

### Runner Target Configuration

#### Runner General Configuration

1. **Runner > General > Minumum Deployments**
    - Must above version 10.9
    
    > **Note**: [From Zoom SDK documentation](https://developers.zoom.us/docs/meeting-sdk/macos/get-started/)

#### Runner Signing & Capabilities Configuration
1. **Runner > Signing & Capabilities > Signing**
    - Select your **Team**
    - Select your **Signing Certificate**

    > **Note**: Later will need to resign the SDK. If not match with selected Team and Signing Certificate will get error.

#### Runner Build Settings Configuration

1. **Runner > Build Settings > Search Paths > Framework Search Paths**
    - Add **$(PROJECT_DIR)/../ZoomSDK/macOS/ZoomSDK**

2. **Runner > Build Settings > Search Paths > Library Search Paths**
    - Add **$(PROJECT_DIR)/../ZoomSDK/macOS/ZoomSDK**

#### Runner Build Phases Configuration

1. **Runner > Build Phases > Copy Files**
    - Add **New Copy Files Phase**
    - Set **Destination** to **Plugins and Foundation Extensions**
    - Click `+` button and next click `Add Other...`
    - Select and add `ZoomAudioDevice.driver`

2. **Runner > Build Phases > Copy Files**
    - Add **New Copy Files Phase**
    - Set **Destination** to **Frameworks**
    - Click `+` button and next click `Add Other...`
    - Select all file inside `ZoomSDK/macOS/ZoomSDK`

3. **Runner > Build Phases > Run Script**
    - Add **New Run Script Phase**
    - Add cmd:
    ```bash
    FRAMEWORKS_PATH="${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
    find "$FRAMEWORKS_PATH" -name "*.framework" -exec codesign --force --deep --sign "${CODE_SIGN_IDENTITY}" {} \;
    find "$FRAMEWORKS_PATH" -name "*.dylib" -exec codesign --force --sign "${CODE_SIGN_IDENTITY}" {} \;
    find "$FRAMEWORKS_PATH" -name "*.bundle" -exec codesign --force --sign "${CODE_SIGN_IDENTITY}" {} \;
    find "$FRAMEWORKS_PATH" -name "*.app" -exec codesign --force --sign "${CODE_SIGN_IDENTITY}" {} \;
    ```


## Add Permissions to Info.plist

Edit your app’s `macos/Runner/Info.plist` and add the following keys to request necessary permissions:
```xml
```


> ✅ These permissions are required by the Zoom SDK for full functionality.

## Add Permissions to Entitlements

Edit `macos/Runner/DebugProfile.entitlements` and ensure the following permissions are added:
Edit `macos/Runner/Release.entitlements` and ensure the following permissions are added:
```xml
```

---

Now run `flutter run`, you should be able to launch without errors.

If you encounter any code-signing issues, double-check that:
- Your **Team** and **Certificate** are set correctly in **Signing & Capabilities**
- All Zoom SDK frameworks, dylibs, and bundles are **code signed** properly (via the **Run Script Phase**)

---


# Next

- [Android Setup Instructions](./README_ANDROID.md)
- [iOS Setup Instructions](./README_IOS.md)
- [WindowsSetup Instructions](./README_WINDOWS.md)
- [Home](./README.md)