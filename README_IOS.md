# Setup iOS (WIP)

## 1. Download SDK

- Download the Zoom iOS SDK from the [Zoom App Marketplace](https://marketplace.zoom.us/)
- Create a `ZoomSDK/ios/` folder and extract the SDK contents into it.
- We only need `MobileRTC.xcframework` and `MobileRTCResources.bundle`

**Example Directory Structure:**

```bash
<YourApp>/
├── ios/
├── ...
└── ZoomSDK/
    └── ios/
        ├── MobileRTC.xcframework
        └── MobileRTCResources.bundle
```

<img width="415" alt="Screenshot 2025-04-30 at 2 58 41 PM" src="https://github.com/user-attachments/assets/fb01c84f-47f7-4b1c-ab46-0ffd92ddfd09" />

*Figure: Download and extract the Zoom SDK into your project*

---

## 2. Configure In Xcode

Navigate to `<YourApp>/ios` and open it with Xcode.  

<img width="630" alt="Screenshot 2025-04-30 at 2 35 52 PM" src="https://github.com/user-attachments/assets/036dac34-a6b9-4c95-a1bc-acc7a060437c" />

*Figure: Open the iOS project with Xcode*

### 2.1 Runner Target Configuration

#### 2.1.1. Runner > General > Frameworks, Libraries, and Embedded Content
    - Add: `MobileRTC.xcframework`  
  
<img width="1512" alt="Screenshot 2025-04-30 at 2 31 53 PM" src="https://github.com/user-attachments/assets/4134a17f-bba6-4954-967a-d089767d4a47" />

*Figure: Add MobileRTC.xcframework in (Frameworks, Libraries, and Embedded Content)*

#### 2.1.2. Runner > Build Phases > Link Binary With Libraries
    - Add: `MobileRTC.xcframework`

#### 2.1.3. Runner > Build Phases > Copy Bundle Resources
    - Add: `MobileRTCResources.bundle`

#### 2.1.4. Runner > Build Phases > Embed Frameworks
    - Add: `MobileRTC.xcframework`
  
<img width="1512" alt="Screenshot 2025-04-30 at 2 32 24 PM" src="https://github.com/user-attachments/assets/3074841f-d73d-4eda-900d-254d1f1e996e" />

*Figure: Add MobileRTC.xcframework and MobileRTCResources.bundle in (Build Phases)*

### 2.2 Plugin Pod Configuration

Run the following command to generate the Podfile:

```bash
flutter build ios
```
> 💡 You will see the expected error `Swift Compiler Error (Xcode): No such module 'MobileRTC'`
> Don’t worry — we'll configure the Pod target next.

Now reopen the iOS project in Xcode and follow these steps:

#### 2.2.1. Pods > flutter_zoom_meeting_sdk > General > Frameworks and Libraries

    - Add: `MobileRTC.xcframework`
    - Set Embed to **Do Not Embed**

<img width="1512" alt="Screenshot 2025-04-30 at 2 32 35 PM" src="https://github.com/user-attachments/assets/7bf497a8-7af5-451d-a7d8-7562a286c5b7" />

*Figure: Set MobileRTC.xcframework in plugin target*

> ✅ This allows the plugin to correctly read and use the Zoom SDK.

---

## 3. Add Permissions to Info.plist

Edit `<YourApp>/ios/Runner/Info.plist` and add the following keys:

```bash
<key>NSBluetoothPeripheralUsageDescription</key>
<string>We will use your Bluetooth to access your Bluetooth headphones.</string>
<key>NSCameraUsageDescription</key>
<string>For people to see you during meetings, we need access to your camera.</string>
<key>NSMicrophoneUsageDescription</key>
<string>For people to hear you during meetings, we need access to your microphone.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>For people to share, we need access to your photos.</string>
```

---

Now run `flutter run`, you should be able to launch without errors.

---

# Next

- [Android Setup Instructions](./README_ANDROID.md)
- [macOS Setup Instructions](./README_MACOS.md)
- [Windows Setup Instructions](./README_WINDOWS.md)
- [Home](./README.md)
