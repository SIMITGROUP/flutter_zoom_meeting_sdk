import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

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

  /// Streams for auth and meeting events
  @override
  Stream<Map<String, dynamic>> get onAuthEvent => authEventChannel
      .receiveBroadcastStream()
      .map((event) => Map<String, dynamic>.from(event));

  @override
  Stream<Map<String, dynamic>> get onMeetingEvent => meetingEventChannel
      .receiveBroadcastStream()
      .map((event) => Map<String, dynamic>.from(event));

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<String?> initZoom() async {
    final log = await methodChannel.invokeMethod<String>('initZoom');
    return log;
  }

  @override
  Future<String?> authZoom({required String jwtToken}) async {
    final log = await methodChannel.invokeMethod<String>('authZoom', {
      'jwtToken': jwtToken,
    });
    return log;
  }

  @override
  Future<String?> joinMeeting() async {
    final log = await methodChannel.invokeMethod<String>('joinMeeting');
    return log;
  }
}
