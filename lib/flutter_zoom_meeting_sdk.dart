import 'package:flutter_zoom_meeting_sdk/models/flutter_zoom_meeting_sdk_action_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/flutter_zoom_meeting_sdk_event_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/jwt_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_request.dart';
import 'flutter_zoom_meeting_sdk_platform_interface.dart';

export 'models/zoom_meeting_sdk_response.dart';

class FlutterZoomMeetingSdk {
  // ======== Events =========

  // ====== Auth Events ======

  /// mac | ios | android | windows
  Stream<FlutterZoomMeetingSdkEventResponse<EventAuthenticateReturnParams>>
  get onAuthenticationReturn =>
      FlutterZoomMeetingSdkPlatform.instance.onAuthenticationReturn;

  /// mac | ios | android | windows
  Stream<FlutterZoomMeetingSdkEventResponse> get onZoomAuthIdentityExpired =>
      FlutterZoomMeetingSdkPlatform.instance.onZoomAuthIdentityExpired;

  // ====== Meeting Events ======

  /// mac | ios | android | windows
  Stream<FlutterZoomMeetingSdkEventResponse<EventMeetingStatusChangedParams>>
  get onMeetingStatusChanged =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingStatusChanged;

  /// mac | ios | android | windows
  Stream<
    FlutterZoomMeetingSdkEventResponse<EventMeetingParameterNotificationParams>
  >
  get onMeetingParameterNotification =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingParameterNotification;

  // ---

  // ======= Functions =======

  Future<FlutterZoomMeetingSdkActionResponse<InitParamsResponse>> initZoom() {
    return FlutterZoomMeetingSdkPlatform.instance.initZoom();
  }

  Future<FlutterZoomMeetingSdkActionResponse<AuthParamsResponse>> authZoom({
    required String jwtToken,
  }) {
    return FlutterZoomMeetingSdkPlatform.instance.authZoom(jwtToken: jwtToken);
  }

  Future<FlutterZoomMeetingSdkActionResponse<JoinParamsResponse>> joinMeeting(
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
