import 'dart:async';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';
part 'zoom_service_config.dart';

class ZoomService {
  final FlutterZoomMeetingSdk _zoomSdk = FlutterZoomMeetingSdk();

  String _authEndpoint = "http://localhost:4000";

  String _meetingNumber = "3273588613";
  String _userName = "John Doe";
  String _passCode = "123456";
  int _role = 0;

  StreamSubscription? _authSubscription;
  StreamSubscription? _meetingSubscription;

  // Expose streams for listeners
  Stream<Map<String, dynamic>> get onAuthEvent => _zoomSdk.onAuthEvent;
  Stream<Map<String, dynamic>> get onMeetingEvent => _zoomSdk.onMeetingEvent;

  Future<void> initZoom() async {
    await _zoomSdk.initZoom();
  }

  Future<void> authZoom() async {
    final jwtToken = await getJWTToken();

    await _zoomSdk.authZoom(jwtToken: jwtToken);
  }

  Future<void> joinMeeting() async {
    await _zoomSdk.joinMeeting();
  }

  Future<String> getJWTToken() async {
    final result = await _zoomSdk.getJWTToken(
      authEndpoint: _authEndpoint,
      meetingNumber: _meetingNumber,
      role: _role,
    );

    final signature = result?.token;

    if (signature != null) {
      print('Signature: $signature');
      return signature;
    } else {
      throw Exception("Failed to get signature.");
    }
  }

  void initEventListeners() {
    // Listen to auth events
    _authSubscription = _zoomSdk.onAuthEvent.listen((event) {
      print('Auth event: $event');

      // _joinMeeting();
    });

    // Listen to meeting events
    _meetingSubscription = _zoomSdk.onMeetingEvent.listen((event) {
      print('Meeting event: $event');
    });
  }

  void dispose() {
    _authSubscription?.cancel();
    _meetingSubscription?.cancel();
  }
}
