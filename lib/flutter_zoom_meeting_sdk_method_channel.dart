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

  /// Event channels for auth and meeting events
  @visibleForTesting
  final EventChannel authEventChannel = const EventChannel(
    'flutter_zoom_meeting_sdk/auth_events',
  );

  @visibleForTesting
  final EventChannel meetingEventChannel = const EventChannel(
    'flutter_zoom_meeting_sdk/meeting_events',
  );

  @visibleForTesting
  final eventChannel = const EventChannel('flutter_zoom_meeting_sdk/events');

  late final Stream<Map<String, dynamic>> _eventStream = eventChannel
      .receiveBroadcastStream()
      .map((event) => Map<String, dynamic>.from(event));

  @override
  Stream<Map<String, dynamic>> get onAuthenticationReturn =>
      _eventStream.where((e) => e['event'] == 'onAuthenticationReturn');

  @override
  Stream<Map<String, dynamic>> get onLoginReturnWithReason =>
      _eventStream.where((e) => e['event'] == 'onLoginReturnWithReason');

  @override
  Stream<Map<String, dynamic>> get onZoomSDKInitializeResult =>
      _eventStream.where((e) => e['event'] == 'onZoomSDKInitializeResult');

  @override
  Stream<Map<String, dynamic>> get onZoomAuthIdentityExpired =>
      _eventStream.where((e) => e['event'] == 'onZoomAuthIdentityExpired');

  @override
  Stream<Map<String, dynamic>> get onMeetingStatusChanged =>
      _eventStream.where((e) => e['event'] == 'onMeetingStatusChanged');

  @override
  Stream<Map<String, dynamic>> get onMeetingParameterNotification =>
      _eventStream.where((e) => e['event'] == 'onMeetingParameterNotification');

  /// Streams for auth and meeting events
  @override
  Stream<ZoomMeetingAuthEventResponse> get onAuthEvent =>
      authEventChannel.receiveBroadcastStream().map((event) {
        final Map<String, dynamic> resultMap = Map<String, dynamic>.from(event);
        return ZoomMeetingAuthEventResponse.fromMap(resultMap);
      });

  @override
  Stream<ZoomMeetingMeetingEventResponse> get onMeetingEvent =>
      meetingEventChannel.receiveBroadcastStream().map((event) {
        final Map<String, dynamic> resultMap = Map<String, dynamic>.from(event);
        return ZoomMeetingMeetingEventResponse.fromMap(resultMap);
      });

  @override
  Stream get onZoomEvent => eventChannel.receiveBroadcastStream().map((event) {
    print("Plugin Zoom Event: $event");
    return event;
  });

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<StandardZoomMeetingResponse> initZoom() async {
    final result = await methodChannel.invokeMethod('initZoom');
    final Map<String, dynamic> resultMap = Map<String, dynamic>.from(result);
    return StandardZoomMeetingResponse.fromMap(resultMap);
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
