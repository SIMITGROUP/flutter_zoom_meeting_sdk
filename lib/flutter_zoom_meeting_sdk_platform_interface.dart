import 'package:flutter_zoom_meeting_sdk/models/flutter_zoom_meeting_sdk_action_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/flutter_zoom_meeting_sdk_event_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/jwt_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_request.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_zoom_meeting_sdk_method_channel.dart';

abstract class FlutterZoomMeetingSdkPlatform extends PlatformInterface {
  /// Constructs a FlutterZoomMeetingSdkPlatform.
  FlutterZoomMeetingSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterZoomMeetingSdkPlatform _instance =
      MethodChannelFlutterZoomMeetingSdk();

  /// The default instance of [FlutterZoomMeetingSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterZoomMeetingSdk].
  static FlutterZoomMeetingSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterZoomMeetingSdkPlatform] when
  /// they register themselves.
  static set instance(FlutterZoomMeetingSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  // ======== Events =========

  // ====== Auth Events ======

  // windows, macos, ios
  Stream<FlutterZoomMeetingSdkEventResponse> get onAuthenticationReturn;

  // windows, macos, ios
  Stream<FlutterZoomMeetingSdkEventResponse> get onLoginReturnWithReason;

  // windows, macos, ios
  Stream<FlutterZoomMeetingSdkEventResponse> get onLogout;

  // windows, macos
  Stream<FlutterZoomMeetingSdkEventResponse> get onZoomIdentityExpired;

  // windows, android, macos, ios
  Stream<FlutterZoomMeetingSdkEventResponse> get onZoomAuthIdentityExpired;

  // windows, macos,ios
  Stream<FlutterZoomMeetingSdkEventResponse> get onNotificationServiceStatus;

  // Meeting Events

  // windows, android, macos, ios
  Stream<FlutterZoomMeetingSdkEventResponse> get onMeetingStatusChanged;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse>
  get onMeetingStatisticsWarningNotification;

  // windows, android
  Stream<FlutterZoomMeetingSdkEventResponse> get onMeetingParameterNotification;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse>
  get onSuspendParticipantsActivities;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse>
  get onAICompanionActiveChangeNotice;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse> get onMeetingTopicChanged;

  // windows
  Stream<FlutterZoomMeetingSdkEventResponse> get onMeetingFullToWatchLiveStream;

  // ---

  // Initialization Events
  Stream<Map<String, dynamic>> get onZoomSDKInitializeResult;

  // ======= Functions =======

  Future<FlutterZoomMeetingSdkActionResponse<InitParamsResponse>> initZoom() {
    throw UnimplementedError('initZoom() has not been implemented.');
  }

  Future<FlutterZoomMeetingSdkActionResponse<AuthParamsResponse>> authZoom({
    required String jwtToken,
  }) {
    throw UnimplementedError('authZoom() has not been implemented.');
  }

  Future<FlutterZoomMeetingSdkActionResponse<JoinParamsResponse>> joinMeeting(
    ZoomMeetingSdkRequest request,
  ) {
    throw UnimplementedError('joinMeeting() has not been implemented.');
  }

  Future<JwtResponse?> getJWTToken({
    required String authEndpoint,
    required String meetingNumber,
    required int role,
  }) {
    throw UnimplementedError('getJWTToken() has not been implemented.');
  }
}
