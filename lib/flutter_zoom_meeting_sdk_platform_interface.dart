import 'package:flutter_zoom_meeting_sdk/models/flutter_zoom_meeting_sdk_action_response.dart';
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
  Stream<Map<String, dynamic>> get onAuthenticationReturn;

  // windows, macos, ios
  Stream<Map<String, dynamic>> get onLoginReturnWithReason;

  // windows, macos, ios
  Stream<Map<String, dynamic>> get onLogout;

  // windows, macos
  Stream<Map<String, dynamic>> get onZoomIdentityExpired;

  // windows, android, macos, ios
  Stream<Map<String, dynamic>> get onZoomAuthIdentityExpired;

  // windows, macos,ios
  Stream<Map<String, dynamic>> get onNotificationServiceStatus;

  // Meeting Events

  // windows, android, macos, ios
  Stream<Map<String, dynamic>> get onMeetingStatusChanged;

  // windows
  Stream<Map<String, dynamic>> get onMeetingStatisticsWarningNotification;

  // windows, android
  Stream<Map<String, dynamic>> get onMeetingParameterNotification;

  // windows
  Stream<Map<String, dynamic>> get onSuspendParticipantsActivities;

  // windows
  Stream<Map<String, dynamic>> get onAICompanionActiveChangeNotice;

  // windows
  Stream<Map<String, dynamic>> get onMeetingTopicChanged;

  // windows
  Stream<Map<String, dynamic>> get onMeetingFullToWatchLiveStream;

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
