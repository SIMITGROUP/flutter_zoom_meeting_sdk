import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';
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

  // Auth Events

  // windows
  Stream<Map<String, dynamic>> get onAuthenticationReturn;

  // windows
  Stream<Map<String, dynamic>> get onLoginReturnWithReason;

  // windows
  Stream<Map<String, dynamic>> get onLogout;

  // windows
  Stream<Map<String, dynamic>> get onZoomIdentityExpired;

  // windows, android
  Stream<Map<String, dynamic>> get onZoomAuthIdentityExpired;

  // windows
  Stream<Map<String, dynamic>> get onNotificationServiceStatus;

  // Meeting Events

  // windows, android
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

  /// Stream for authentication events from the Zoom SDK
  Stream<ZoomMeetingAuthEventResponse> get onAuthEvent {
    throw UnimplementedError('onAuthEvent has not been implemented.');
  }

  /// Stream for meeting events from the Zoom SDK
  Stream<ZoomMeetingMeetingEventResponse> get onMeetingEvent {
    throw UnimplementedError('onMeetingEvent has not been implemented.');
  }

  Stream get onZoomEvent {
    throw UnimplementedError('onZoomEvent has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<StandardZoomMeetingResponse> initZoom() {
    throw UnimplementedError('initZoom() has not been implemented.');
  }

  Future<StandardZoomMeetingResponse> authZoom({required String jwtToken}) {
    throw UnimplementedError('authZoom() has not been implemented.');
  }

  Future<StandardZoomMeetingResponse> joinMeeting(
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
