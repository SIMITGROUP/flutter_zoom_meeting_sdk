# Flutter Zoom Meeting SDK

A Flutter plugin for integrating with the [Zoom Meeting SDK](https://developers.zoom.us/docs/meeting-sdk/) across multiple platforms.  
Developed and tested with SDK version `v6.4.3.28970`.

**Supported Platforms**

- Android
- iOS
- macOS
- Windows

> **Note**: This plugin does **NOT** bundle the SDK binaries. You must [download the Zoom Meeting SDK manually](#getting-started) and configure it for each platform.

---

## Getting Started

### 1. Download the SDK

1. Go to the [Zoom App Marketplace](https://marketplace.zoom.us/)
2. Sign in to your Zoom account.
3. Select **Develop** and choose **Build App**.
4. Create a **General App**.
5. Under **Build your app** > **Features** > **Embed**, enable the **Meeting SDK** feature.
6. Download the SDK files for each platform (Android, iOS, macOS, Windows).

> **Note**: For more information: Read [Get Credentials](https://developers.zoom.us/docs/meeting-sdk/get-credentials/)

### 2. Platform Setup

Follow the platform-specific setup guides:

- [Android Setup Instructions](./README_ANDROID.md)
- [iOS Setup Instructions](./README_IOS.md)
- [macOS Setup Instructions](./README_MACOS.md)
- [Windows Setup Instructions](./README_WINDOWS.md)

---

## Usage

### SDK Authorization (JWT Token)

Zoom Meeting SDK requires a JSON Web Token (JWT) for authorization. You can generate one using Zoom's [sample JWT auth endpoint](https://github.com/zoom/meetingsdk-auth-endpoint-sample/).

After cloning and running the sample auth server, you can call the `getJWTToken` method like this:

```dart
final result = await FlutterZoomMeetingSdk().getJWTToken(
  authEndpoint: _authEndpoint,
  meetingNumber: _meetingNumber,
  role: _role, // 0: Participant, 1: Host / Co-Host
);

final signature = result?.token;

if (signature != null) {
  print('Signature: $signature');
  return signature;
} else {
  throw Exception("Failed to get signature.");
}
```
> **Note**: For more information: read [Meeting SDK authorization](https://developers.zoom.us/docs/meeting-sdk/auth/)

### Functions

#### Init Zoom SDK

- Initialize the SDK.
- Example:
  
  ```dart
  await FlutterZoomMeetingSdk().initZoom();
  ```

#### Authenticate Zoom SDK

- Authenticate using your JWT token.
- Example:

  ```dart
  await FlutterZoomMeetingSdk().authZoom(jwtToken: jwtToken);
  ```

#### Join Zoom Meeting

- Join a meeting using a Meeting ID and password.
- For webinars or meetings with registration, you must also pass a `webinarToken`.
- Example:
  
  ```dart
  await FlutterZoomMeetingSdk().joinMeeting(ZoomMeetingSdkRequest(
    meetingNumber: _meetingNumber,
    password: _passCode,
    displayName: _userName,
    webinarToken: _webinarToken, // Optional
  ));
  ```

#### Uninitialize SDK

- Uninitialize and clean up the SDK.
- Example:

  ```dart
  await FlutterZoomMeetingSdk().unInitZoom();
  ```

### Event Streams

#### onAuthenticationReturn

```dart
FlutterZoomMeetingSdk().onAuthenticationReturn.listen((event) {
  print(
    "EXAMPLE_APP::EVENT::onAuthenticationReturn - ${jsonEncode(event.toMap())}",
  );

  if (event.params?.statusEnum == StatusZoomError.success) {
    joinMeeting();
  }
});
```

#### onZoomAuthIdentityExpired

#### onMeetingStatusChanged

#### onMeetingParameterNotification

#### onMeetingError

#### onMeetingEndedReaso

---

## Example

For a complete example of how to use the plugin, check out the full code at [here](./README_EXAMPLE.md).

---

## Contributing

Contributions are welcome! Please open an issue or pull request with improvements, bug fixes, or suggestions.

---

## License

MIT License. See [LICENSE](./LICENSE) for details.


