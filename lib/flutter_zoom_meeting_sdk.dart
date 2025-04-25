import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/jwt_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_request.dart';
import 'flutter_zoom_meeting_sdk_platform_interface.dart';

export 'models/zoom_meeting_sdk_response.dart';

class FlutterZoomMeetingSdk {
  // ======== Events =========

  // ====== Auth Events ======

  // windows, macos, ios
  Stream<Map<String, dynamic>> get onAuthenticationReturn =>
      FlutterZoomMeetingSdkPlatform.instance.onAuthenticationReturn;

  // windows
  Stream<Map<String, dynamic>> get onLoginReturnWithReason =>
      FlutterZoomMeetingSdkPlatform.instance.onLoginReturnWithReason;

  // windows
  Stream<Map<String, dynamic>> get onLogout =>
      FlutterZoomMeetingSdkPlatform.instance.onLogout;

  // windows
  Stream<Map<String, dynamic>> get onZoomIdentityExpired =>
      FlutterZoomMeetingSdkPlatform.instance.onZoomIdentityExpired;

  // windows, android, macos, ios
  Stream<Map<String, dynamic>> get onZoomAuthIdentityExpired =>
      FlutterZoomMeetingSdkPlatform.instance.onZoomAuthIdentityExpired;

  // windows
  Stream<Map<String, dynamic>> get onNotificationServiceStatus =>
      FlutterZoomMeetingSdkPlatform.instance.onNotificationServiceStatus;

  // ====== Meeting Events ======

  // windows, android, macos, ios
  Stream<Map<String, dynamic>> get onMeetingStatusChanged =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingStatusChanged;

  // windows
  Stream<Map<String, dynamic>> get onMeetingStatisticsWarningNotification =>
      FlutterZoomMeetingSdkPlatform
          .instance
          .onMeetingStatisticsWarningNotification;

  // windows, android
  Stream<Map<String, dynamic>> get onMeetingParameterNotification =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingParameterNotification;

  // windows
  Stream<Map<String, dynamic>> get onSuspendParticipantsActivities =>
      FlutterZoomMeetingSdkPlatform.instance.onSuspendParticipantsActivities;

  // windows
  Stream<Map<String, dynamic>> get onAICompanionActiveChangeNotice =>
      FlutterZoomMeetingSdkPlatform.instance.onAICompanionActiveChangeNotice;

  // windows
  Stream<Map<String, dynamic>> get onMeetingTopicChanged =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingTopicChanged;

  // windows
  Stream<Map<String, dynamic>> get onMeetingFullToWatchLiveStream =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingFullToWatchLiveStream;

  // ---

  Stream<Map<String, dynamic>> get onZoomSDKInitializeResult =>
      FlutterZoomMeetingSdkPlatform.instance.onZoomSDKInitializeResult;

  // ======= Functions =======

  Future<Map<dynamic, dynamic>> initZoom() {
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
