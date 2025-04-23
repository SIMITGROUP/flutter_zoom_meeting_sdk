#### Download SDK
- Create a folder and place your sdk inside it
- folder structure:
```
- <YourApp>
-- ios
-- ZoomSDK
--- ios
---- MobileRTC.xcframework
---- MobileRTCResources.bundle
```

#### Open <YourApp>/ios folder with XCode
##### Runner > General > Frameworks, Libraries, and Embedded Content
- Add MobileRTC.xcframework

##### Runner > Build Phases > Link Binary With Libraries
- Add MobileRTC.xcframework

##### Runner > Build Phases > Copy Bundle Resources
- Add MobileRTCResources.bundle

##### Runner > Build Phases > Embed Frameworks
- Add MobileRTC.xcframework

##### Pods > flutter_zoom_meeting_sdk > General > Frameworks and Libraries
- Add MobileRTC.xcframework and Embed set to 'Do Not Embed'
- (To let plugin can read ZoomSDK)


#### Add Permision to <YourApp>/ios/Runner/Info.plist
```
<key>NSBluetoothPeripheralUsageDescription</key>
<string>We will use your Bluetooth to access your Bluetooth headphones.</string>
<key>NSCameraUsageDescription</key>
<string>For people to see you during meetings, we need access to your camera.</string>
<key>NSMicrophoneUsageDescription</key>
<string>For people to hear you during meetings, we need access to your microphone.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>For people to share, we need access to your photos</string>
```