import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/jwt_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_request.dart';
import 'flutter_zoom_meeting_sdk_platform_interface.dart';

export 'models/zoom_meeting_sdk_response.dart';

class FlutterZoomMeetingSdk {
  /// Stream of Zoom SDK authentication events
  ///
  /// Events include:
  /// - onZoomSDKAuthReturn: Authentication result
  /// - onZoomAuthIdentityExpired: Auth token expired
  Stream<ZoomMeetingAuthEventResponse> get onAuthEvent =>
      FlutterZoomMeetingSdkPlatform.instance.onAuthEvent;

  /// Stream of Zoom SDK meeting events
  ///
  /// Events include:
  /// - onMeetingStatusChange: Meeting status changes
  Stream<ZoomMeetingMeetingEventResponse> get onMeetingEvent =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingEvent;

  Stream get onZoomEvent => FlutterZoomMeetingSdkPlatform.instance.onZoomEvent;

  Future<String?> getPlatformVersion() {
    return FlutterZoomMeetingSdkPlatform.instance.getPlatformVersion();
  }

  Future<StandardZoomMeetingResponse> initZoom() {
    return FlutterZoomMeetingSdkPlatform.instance.initZoom();
  }

  Future<StandardZoomMeetingResponse> authZoom({required String jwtToken}) {
    return FlutterZoomMeetingSdkPlatform.instance.authZoom(jwtToken: jwtToken);
  }

  Future<StandardZoomMeetingResponse> joinMeeting(
    ZoomMeetingSdkRequest request,
  ) {
    return FlutterZoomMeetingSdkPlatform.instance.joinMeeting(request);
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
