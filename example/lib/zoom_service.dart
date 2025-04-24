import 'dart:async';
import 'dart:convert';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';
import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_request.dart';
part 'zoom_service_config.dart';

class ZoomService {
  final FlutterZoomMeetingSdk _zoomSdk = FlutterZoomMeetingSdk();

  String _authEndpoint = "http://localhost:4000";
  // String _authEndpoint = "http://10.0.2.2:4000"; // android emulator

  String _meetingNumber = "";
  String _userName = "";
  String _passCode = "";
  int _role = 0;

  StreamSubscription? _authSubscription;
  StreamSubscription? _meetingSubscription;
  StreamSubscription? _zoomEventSubscription;

  StreamSubscription? _meetingStatusSub;

  // Expose streams for listeners
  Stream<ZoomMeetingAuthEventResponse> get onAuthEvent => _zoomSdk.onAuthEvent;
  Stream<ZoomMeetingMeetingEventResponse> get onMeetingEvent =>
      _zoomSdk.onMeetingEvent;
  Stream get onZoomEvent => _zoomSdk.onZoomEvent;

  Future<StandardZoomMeetingResponse> initZoom() async {
    final result = await _zoomSdk.initZoom();
    print('Init response: ${jsonEncode(result.toMap())}');
    return result;
  }

  Future<StandardZoomMeetingResponse> authZoom() async {
    final jwtToken = await getJWTToken();

    final result = await _zoomSdk.authZoom(jwtToken: jwtToken);
    print('Init response: ${jsonEncode(result.toMap())}');
    return result;
  }

  Future<StandardZoomMeetingResponse> joinMeeting() async {
    final request = ZoomMeetingSdkRequest(
      meetingNumber: _meetingNumber,
      password: _passCode,
      displayName: _userName,
    );
    final result = await _zoomSdk.joinMeeting(request);
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
    // _authSubscription = _zoomSdk.onAuthEvent.listen((event) {
    //   print('Auth event: $event');
    //   print('Auth event: ${jsonEncode(event.toMap())}');
    //   // if (event.statusText == 'Success') {
    //   joinMeeting();
    //   // }
    // });

    // // Listen to meeting events
    // _meetingSubscription = _zoomSdk.onMeetingEvent.listen((event) {
    //   print('Meeting event: $event');
    //   print('Meeting event: ${jsonEncode(event.toMap())}');
    // });

    // _zoomEventSubscription = _zoomSdk.onZoomEvent.listen((event) {
    //   print('Example Zoom event: $event');
    // });

    _zoomSdk.onAuthenticationReturn.listen((event) {
      print("Example App onAuthenticationReturn: $event");
      joinMeeting();
    });

    _zoomSdk.onLoginReturnWithReason.listen((event) {
      print("Example App onLoginReturnWithReason: $event");
    });

    // _zoomSdk.onZoomSDKInitializeResult.listen((event) {
    //   print("Example App onZoomSDKInitializeResult: $event");
    //   joinMeeting();
    // });

    _meetingStatusSub = _zoomSdk.onMeetingStatusChanged.listen((event) {
      print("Example App onMeetingStatusChanged: $event");
    });
  }

  void dispose() {
    _authSubscription?.cancel();
    _meetingSubscription?.cancel();
    _zoomEventSubscription?.cancel();

    _meetingStatusSub?.cancel();
  }
}
