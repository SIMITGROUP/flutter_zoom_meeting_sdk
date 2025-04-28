import 'package:flutter_zoom_meeting_sdk/models/flutter_zoom_meeting_sdk_action_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/flutter_zoom_meeting_sdk_event_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/jwt_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_request.dart';
import 'flutter_zoom_meeting_sdk_platform_interface.dart';

export 'models/zoom_meeting_sdk_response.dart';

class FlutterZoomMeetingSdk {
  // ======== Events =========

  // ====== Auth Events ======

  // windows, macos, ios
  Stream<FlutterZoomMeetingSdkEventResponse> get onAuthenticationReturn =>
      FlutterZoomMeetingSdkPlatform.instance.onAuthenticationReturn;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse> get onLoginReturnWithReason =>
      FlutterZoomMeetingSdkPlatform.instance.onLoginReturnWithReason;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse> get onLogout =>
      FlutterZoomMeetingSdkPlatform.instance.onLogout;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse> get onZoomIdentityExpired =>
      FlutterZoomMeetingSdkPlatform.instance.onZoomIdentityExpired;

  // windows, android, macos, ios
  Stream<FlutterZoomMeetingSdkEventResponse> get onZoomAuthIdentityExpired =>
      FlutterZoomMeetingSdkPlatform.instance.onZoomAuthIdentityExpired;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse> get onNotificationServiceStatus =>
      FlutterZoomMeetingSdkPlatform.instance.onNotificationServiceStatus;

  // ====== Meeting Events ======

  // windows, android, macos, ios
  Stream<FlutterZoomMeetingSdkEventResponse> get onMeetingStatusChanged =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingStatusChanged;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse>
  get onMeetingStatisticsWarningNotification =>
      FlutterZoomMeetingSdkPlatform
          .instance
          .onMeetingStatisticsWarningNotification;

  // windows, android
  Stream<FlutterZoomMeetingSdkEventResponse>
  get onMeetingParameterNotification =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingParameterNotification;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse>
  get onSuspendParticipantsActivities =>
      FlutterZoomMeetingSdkPlatform.instance.onSuspendParticipantsActivities;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse>
  get onAICompanionActiveChangeNotice =>
      FlutterZoomMeetingSdkPlatform.instance.onAICompanionActiveChangeNotice;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse> get onMeetingTopicChanged =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingTopicChanged;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse>
  get onMeetingFullToWatchLiveStream =>
      FlutterZoomMeetingSdkPlatform.instance.onMeetingFullToWatchLiveStream;

  // ---

  Stream<Map<String, dynamic>> get onZoomSDKInitializeResult =>
      FlutterZoomMeetingSdkPlatform.instance.onZoomSDKInitializeResult;

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
