# MAC OS Configuration

## Config Runner

### Add Zoom SDK
- Create `Zoom` folder inside `Runner`
- Copy `ZoomSDK` and `Plugins` folder from downloaded `zoom_sdk` folder to newly created `Zoom` folder

### General
- Change Minimum Deployments

### Signing & Capabilities
- Change Team
- Signing Certificate Change To `Development`

### Build Settings
- Framework Search Paths:
  - Add `$(PROJECT_DIR)/Runner/Zoom/ZoomSDK`
- Library Search Paths:
  - Add `$(PROJECT_DIR)/Runner/Zoom/ZoomSDK`

### Build Phases
#### Add Copy Files
- Destination set to `Frameworks`
- Press "+" button and add all file from `Zoom` > `ZoomSDK`

#### Add Copy Files
- Destination set to `Plugins ad Foundation Extensions`
- Press "+" button
- Press "Add Other..."
- Select `Zoom` > `Plugins` > `ZoomAudioDevice.driver`
- Press "Open"
- Select `Create folder references`
- Press "Finish"

#### Add Run Script
- Add below cmd
```
FRAMEWORKS_PATH="${TARGET_BUILD_DIR}/${FRAMEWORKS_FOLDER_PATH}"
find "$FRAMEWORKS_PATH" -name "*.framework" -exec codesign --force --deep --sign "${CODE_SIGN_IDENTITY}" {} \;
find "$FRAMEWORKS_PATH" -name "*.dylib" -exec codesign --force --sign "${CODE_SIGN_IDENTITY}" {} \;
find "$FRAMEWORKS_PATH" -name "*.bundle" -exec codesign --force --sign "${CODE_SIGN_IDENTITY}" {} \;
find "$FRAMEWORKS_PATH" -name "*.app" -exec codesign --force --sign "${CODE_SIGN_IDENTITY}" {} \;
```

## Permission

### Info.plist
Privacy - Camera Usage Description cameraDesciption
Privacy - Microphone Usage Description microphoneDesciption
Privacy - AppleEvents Sending Usage Description eventsDescription

### DebugProfile.entitlements & Release.entitlements
Add Audio and Camera


## Podfile
- Adjust Podfile to let plugin can import ZoomSDK
- Add below code after `flutter_additional_macos_build_settings(target)`
```
    # TODO: is this proper way to do this?
    if target.name == 'flutter_zoom_meeting_sdk'
      target.build_configurations.each do |config|
        config.build_settings['FRAMEWORK_SEARCH_PATHS'] ||= ['$(inherited)']
        config.build_settings['FRAMEWORK_SEARCH_PATHS'] << '${PODS_ROOT}/../../macos/Runner/Zoom/ZoomSDK'
      end
    end
```
