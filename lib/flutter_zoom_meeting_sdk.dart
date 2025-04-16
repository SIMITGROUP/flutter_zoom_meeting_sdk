import 'flutter_zoom_meeting_sdk_platform_interface.dart';

class FlutterZoomMeetingSdk {
  Future<String?> getPlatformVersion() {
    return FlutterZoomMeetingSdkPlatform.instance.getPlatformVersion();
  }

  Future<String?> initZoom() {
    return FlutterZoomMeetingSdkPlatform.instance.initZoom();
  }

  Future<String?> authZoom({required String jwtToken}) {
    return FlutterZoomMeetingSdkPlatform.instance.authZoom(jwtToken: jwtToken);
  }
}
