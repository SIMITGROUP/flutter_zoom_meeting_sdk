import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';
import 'package:flutter_zoom_meeting_sdk/models/jwt_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'flutter_zoom_meeting_sdk_platform_interface.dart';

/// An implementation of [FlutterZoomMeetingSdkPlatform] that uses method channels.
class MethodChannelFlutterZoomMeetingSdk extends FlutterZoomMeetingSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_zoom_meeting_sdk');

  @visibleForTesting
  final eventChannel = const EventChannel('flutter_zoom_meeting_sdk/events');

  late final Stream<Map<String, dynamic>> _eventStream = eventChannel
      .receiveBroadcastStream()
      .map((event) => Map<String, dynamic>.from(event));

  // ======== Events =========

  // ====== Auth Events ======

  // windows, macos, ios
  @override
  Stream<Map<String, dynamic>> get onAuthenticationReturn =>
      _eventStream.where((e) => e['event'] == 'onAuthenticationReturn');

  // windows
  @override
  Stream<Map<String, dynamic>> get onLoginReturnWithReason =>
      _eventStream.where((e) => e['event'] == 'onLoginReturnWithReason');

  // windows
  @override
  Stream<Map<String, dynamic>> get onLogout =>
      _eventStream.where((e) => e['event'] == 'onLogout');

  // windows
  @override
  Stream<Map<String, dynamic>> get onZoomIdentityExpired =>
      _eventStream.where((e) => e['event'] == 'onZoomIdentityExpired');

  // windows, android, macos, ios
  @override
  Stream<Map<String, dynamic>> get onZoomAuthIdentityExpired =>
      _eventStream.where((e) => e['event'] == 'onZoomAuthIdentityExpired');

  // windows
  @override
  Stream<Map<String, dynamic>> get onNotificationServiceStatus =>
      _eventStream.where((e) => e['event'] == 'onNotificationServiceStatus');

  // Meeting Events

  // windows, android, macos, ios
  @override
  Stream<Map<String, dynamic>> get onMeetingStatusChanged =>
      _eventStream.where((e) => e['event'] == 'onMeetingStatusChanged');

  // windows
  @override
  Stream<Map<String, dynamic>> get onMeetingStatisticsWarningNotification =>
      _eventStream.where(
        (e) => e['event'] == 'onMeetingStatisticsWarningNotification',
      );

  // windows, android
  @override
  Stream<Map<String, dynamic>> get onMeetingParameterNotification =>
      _eventStream.where((e) => e['event'] == 'onMeetingParameterNotification');

  // windows
  @override
  Stream<Map<String, dynamic>> get onSuspendParticipantsActivities =>
      _eventStream.where(
        (e) => e['event'] == 'onSuspendParticipantsActivities',
      );

  // windows
  @override
  Stream<Map<String, dynamic>> get onAICompanionActiveChangeNotice =>
      _eventStream.where(
        (e) => e['event'] == 'onAICompanionActiveChangeNotice',
      );

  // windows
  @override
  Stream<Map<String, dynamic>> get onMeetingTopicChanged =>
      _eventStream.where((e) => e['event'] == 'onMeetingTopicChanged');

  // windows
  @override
  Stream<Map<String, dynamic>> get onMeetingFullToWatchLiveStream =>
      _eventStream.where((e) => e['event'] == 'onMeetingFullToWatchLiveStream');

  // --

  // android
  @override
  Stream<Map<String, dynamic>> get onZoomSDKInitializeResult =>
      _eventStream.where((e) => e['event'] == 'onZoomSDKInitializeResult');

  // ======= Functions =======

  @override
  Future<Map<dynamic, dynamic>> initZoom() async {
    final result = await methodChannel.invokeMethod('initZoom');
    return result;
    // final Map<String, dynamic> resultMap = Map<String, dynamic>.from(result);
    // return StandardZoomMeetingResponse.fromMap(resultMap);
  }

  @override
  Future<StandardZoomMeetingResponse> authZoom({
    required String jwtToken,
  }) async {
    final result = await methodChannel.invokeMethod('authZoom', {
      'jwtToken': jwtToken,
    });
    final Map<String, dynamic> resultMap = Map<String, dynamic>.from(result);
    return StandardZoomMeetingResponse.fromMap(resultMap);
  }

  @override
  Future<StandardZoomMeetingResponse> joinMeeting(
    ZoomMeetingSdkRequest request,
  ) async {
    final result = await methodChannel.invokeMethod('joinMeeting', {
      'meetingNumber': request.meetingNumber,
      'password': request.password,
      'displayName': request.displayName,
    });
    final Map<String, dynamic> resultMap = Map<String, dynamic>.from(result);
    return StandardZoomMeetingResponse.fromMap(resultMap);
  }

  @override
  Future<JwtResponse?> getJWTToken({
    required String authEndpoint,
    required String meetingNumber,
    required int role,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(authEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'meetingNumber': meetingNumber, 'role': role}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final signature = data['signature'] as String?;

        return JwtResponse(token: signature);
      } else {
        return JwtResponse(error: "Failed to retrieve JWT signature.");
      }
    } catch (e) {
      return JwtResponse(error: "Failed to retrieve JWT signature.");
    }
  }
}
