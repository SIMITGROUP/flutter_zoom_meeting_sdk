# Setup iOS

## Download SDK

- Download the Zoom iOS SDK from the [Zoom App Marketplace](https://marketplace.zoom.us/)
- Create a folder and place the SDK contents inside it

Example:

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

*Figure 1: Download and extract Zoom SDK*

---

## Configure In Xcode

Navigate to `<YourApp>/ios` and open it with Xcode.  

<img width="630" alt="Screenshot 2025-04-30 at 2 35 52 PM" src="https://github.com/user-attachments/assets/036dac34-a6b9-4c95-a1bc-acc7a060437c" />

*Figure 2: Open the iOS project with Xcode*

### Runner Target Configuration

1. #### Runner > General > Frameworks, Libraries, and Embedded Content
    - Add: `MobileRTC.xcframework`  
  
<img width="1512" alt="Screenshot 2025-04-30 at 2 31 53 PM" src="https://github.com/user-attachments/assets/4134a17f-bba6-4954-967a-d089767d4a47" />

*Figure 3: Add MobileRTC.xcframework in (Frameworks, Libraries, and Embedded Content)*

1. #### Runner > Build Phases > Link Binary With Libraries
    - Add: `MobileRTC.xcframework`

2. #### Runner > Build Phases > Copy Bundle Resources
    - Add: `MobileRTCResources.bundle`

3. #### Runner > Build Phases > Embed Frameworks
    - Add: `MobileRTC.xcframework`
  
<img width="1512" alt="Screenshot 2025-04-30 at 2 32 24 PM" src="https://github.com/user-attachments/assets/3074841f-d73d-4eda-900d-254d1f1e996e" />

*Figure 4: Add MobileRTC.xcframework and MobileRTCResources.bundle in (Build Phases)*

### Plugin Pod Configuration

1. #### Pods > flutter_zoom_meeting_sdk > General > Frameworks and Libraries

    - Add: `MobileRTC.xcframework`
    - Set Embed to **Do Not Embed**

<img width="1512" alt="Screenshot 2025-04-30 at 2 32 35 PM" src="https://github.com/user-attachments/assets/7bf497a8-7af5-451d-a7d8-7562a286c5b7" />

*Figure 5: Set MobileRTC.xcframework in plugin target*

> ✅ This allows the plugin to correctly read and use the Zoom SDK.

> 💡 You may need to run `flutter run` or `pod install` to make Pods appear.


---

## Add Permissions to Info.plist

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
