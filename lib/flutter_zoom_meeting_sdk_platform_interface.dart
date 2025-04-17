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

  /// Stream for authentication events from the Zoom SDK
  Stream<Map<String, dynamic>> get onAuthEvent {
    throw UnimplementedError('onAuthEvent has not been implemented.');
  }

  /// Stream for meeting events from the Zoom SDK
  Stream<Map<String, dynamic>> get onMeetingEvent {
    throw UnimplementedError('onMeetingEvent has not been implemented.');
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> initZoom() {
    throw UnimplementedError('initZoom() has not been implemented.');
  }

  Future<String?> authZoom({required String jwtToken}) {
    throw UnimplementedError('authZoom() has not been implemented.');
  }

  Future<String?> joinMeeting() {
    throw UnimplementedError('joinMeeting() has not been implemented.');
  }
}
