import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_zoom_meeting_sdk_platform_interface.dart';

/// An implementation of [FlutterZoomMeetingSdkPlatform] that uses method channels.
class MethodChannelFlutterZoomMeetingSdk extends FlutterZoomMeetingSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_zoom_meeting_sdk');

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
}
