import 'package:flutter_zoom_meeting_sdk/models/jwt_response.dart';

import 'flutter_zoom_meeting_sdk_platform_interface.dart';

class FlutterZoomMeetingSdk {
  /// Stream of Zoom SDK authentication events
  ///
  /// Events include:
  /// - onZoomSDKAuthReturn: Authentication result
  /// - onZoomAuthIdentityExpired: Auth token expired
  Stream<Map<String, dynamic>> get onAuthEvent =>
      FlutterZoomMeetingSdkPlatform.instance.onAuthEvent;

  /// Stream of Zoom SDK meeting events
  ///
  /// Events include:
  /// - onMeetingStatusChange: Meeting status changes
  Stream<Map<String, dynamic>> get onMeetingEvent =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingEvent;

  Future<String?> getPlatformVersion() {
    return FlutterZoomMeetingSdkPlatform.instance.getPlatformVersion();
  }

  Future<String?> initZoom() {
    return FlutterZoomMeetingSdkPlatform.instance.initZoom();
  }

  Future<String?> authZoom({required String jwtToken}) {
    return FlutterZoomMeetingSdkPlatform.instance.authZoom(jwtToken: jwtToken);
  }

  Future<String?> joinMeeting() {
    return FlutterZoomMeetingSdkPlatform.instance.joinMeeting();
  }

  Future<JwtResponse?> getJWTToken({
    required String authEndpoint,
    required String meetingNumber,
    required int role,
  }) {
    return FlutterZoomMeetingSdkPlatform.instance.getJWTToken(
      authEndpoint: authEndpoint,
      meetingNumber: meetingNumber,
      role: role,
    );
  }
}
