# Setup macOS

## 1. Download Zoom SDK

- Download the **Zoom macOS SDK** from the [Zoom App Marketplace](https://marketplace.zoom.us/).
- Create a folder and place the SDK contents inside.

**Example structure:**

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

---

## 2. Resign Zoom SDK

macOS requires all SDK binaries (frameworks, dylibs, etc.) to be code-signed.

### 2.1 List Code Signing Identities

Run this to list your valid signing identities:

```bash
security find-identity -v -p codesigning
```

Example output:

```bash
1) aaa "Apple Development: aaa (aaa)"  
2) bbb "Apple Development: bbb (bbb)"  
2 valid identities found
```

### 2.2 Resign SDK Binaries

Replace with your identity and run this from the project root:

```bash
CODE_SIGN_IDENTITY="Apple Development: bbb (bbb)"

FRAMEWORKS_PATH="./ZoomSDK/macOS/ZoomSDK"
find "$FRAMEWORKS_PATH" -name "*.framework" -exec codesign --force --deep --sign "${CODE_SIGN_IDENTITY}" {} \;
find "$FRAMEWORKS_PATH" -name "*.dylib" -exec codesign --force --sign "${CODE_SIGN_IDENTITY}" {} \;
find "$FRAMEWORKS_PATH" -name "*.bundle" -exec codesign --force --sign "${CODE_SIGN_IDENTITY}" {} \;
find "$FRAMEWORKS_PATH" -name "*.app" -exec codesign --force --sign "${CODE_SIGN_IDENTITY}" {} \;
```

---

## 3. Configure in Xcode

Open the macOS folder in Xcode:

```bash
<YourApp>/macos
```

### 3.1 Runner Target Configuration

#### General > Minimum Deployment

- Set **Minimum macOS Version** to **10.9** or higher  
> **Note:** Per [Zoom SDK requirements](https://developers.zoom.us/docs/meeting-sdk/macos/get-started/)

#### Signing & Capabilities

1. **Team & Signing Certificate**
   - Set your **Team** and **Signing Certificate**
   - Must match the certificate used when resigning the SDK

2. **App Sandbox (Debug & Profile)**
   - Network:
     - ✅ Incoming Connections (Server)
     - ✅ Outgoing Connections (Client)
   - Hardware:
     - ✅ Camera
     - ✅ Audio Input

3. **App Sandbox (Release)**
   - Network:
     - ✅ Outgoing Connections (Client)
   - Hardware:
     - ✅ Camera
     - ✅ Audio Input

#### Build Settings

- **Framework Search Paths:**  
  `$(PROJECT_DIR)/../ZoomSDK/macOS/ZoomSDK`

- **Library Search Paths:**  
  `$(PROJECT_DIR)/../ZoomSDK/macOS/ZoomSDK`

#### Build Phases

1. **Copy Files (ZoomAudioDevice)**
   - Add new **Copy Files Phase**
   - Set **Destination** to `Plugins and Foundation Extensions`
   - Add `ZoomAudioDevice.driver`

2. **Copy Files (Zoom Frameworks)**
   - Add another **Copy Files Phase**
   - Set **Destination** to `Frameworks`
   - Add all `.framework`, `.bundle`, `.dylib` files inside `ZoomSDK/macOS/ZoomSDK`

---

## 4. Add Permissions to Info.plist

Edit `macos/Runner/Info.plist` and add the following:

```bash
<key>NSCameraUsageDescription</key>
<string>In order for participants to see you, requires access to your camera.</string>
<key>NSMicrophoneUsageDescription</key>
<string>In order to speak to participants, requires access to your microphone.</string>
<key>NSAppleEventsUsageDescription</key>
<string>Required for screen sharing functionality.</string>
```

> ✅ These are required by Zoom SDK for video/audio/screen sharing.

---

## 4. Run the App

After setup, run your Flutter app, you should be able to launch without errors.:

```bash
flutter run
```

> If you hit code signing errors, double-check:
> - Your **Team** and **Signing Certificate** match the one used to sign the SDK
> - All SDK files are properly signed using the script

---

# Next

- [Android Setup Instructions](./README_ANDROID.md)
- [iOS Setup Instructions](./README_IOS.md)
- [Windows Setup Instructions](./README_WINDOWS.md)
- [Home](./README.md)
