import 'dart:async';
import 'dart:convert';
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

  Future<StandardZoomMeetingResponse> initZoom() async {
    final result = await _zoomSdk.initZoom();
    print('Init response: $result');
    print('Init response: ${jsonEncode(result.toMap())}');
    return result;
  }

  Future<StandardZoomMeetingResponse> authZoom() async {
    final jwtToken = await getJWTToken();

    final result = await _zoomSdk.authZoom(jwtToken: jwtToken);
    print('Init response: $result');
    print('Init response: ${jsonEncode(result.toMap())}');
    return result;
  }

  Future<StandardZoomMeetingResponse> joinMeeting() async {
    final result = await _zoomSdk.joinMeeting();
    print('Init response: $result');
    print('Init response: ${jsonEncode(result.toMap())}');
    return result;
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
