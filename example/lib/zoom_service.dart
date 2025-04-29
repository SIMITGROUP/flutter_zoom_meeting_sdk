import 'dart:async';
import 'dart:convert';
import 'package:flutter_zoom_meeting_sdk/enums/status_zoom_error.dart';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';
import 'package:flutter_zoom_meeting_sdk/models/flutter_zoom_meeting_sdk_action_response.dart';
import 'package:flutter_zoom_meeting_sdk/models/zoom_meeting_sdk_request.dart';
part 'zoom_service_config.dart';

class ZoomService {
  final FlutterZoomMeetingSdk _zoomSdk = FlutterZoomMeetingSdk();

  String _authEndpoint = "http://localhost:4000";
  // String _authEndpoint = "http://10.0.2.2:4000"; // android emulator

  String _meetingNumber = "";
  String _userName = "";
  String _passCode = "";
  String? _webinarToken;
  int _role = 0;

  StreamSubscription? _authSubscription;
  StreamSubscription? _meetingSubscription;
  StreamSubscription? _zoomEventSubscription;

  StreamSubscription? _meetingStatusSub;

  Future<FlutterZoomMeetingSdkActionResponse> initZoom() async {
    final result = await _zoomSdk.initZoom();
    // print('Init response: $result');
    print('Init response: ${jsonEncode(result.toMap())}');
    return result;
  }

  Future<FlutterZoomMeetingSdkActionResponse> authZoom() async {
    final jwtToken = await getJWTToken();
    final result = await _zoomSdk.authZoom(jwtToken: jwtToken);
    print('Auth response: ${jsonEncode(result.toMap())}');
    return result;
  }

  Future<FlutterZoomMeetingSdkActionResponse> joinMeeting() async {
    final request = ZoomMeetingSdkRequest(
      meetingNumber: _meetingNumber,
      password: _passCode,
      displayName: _userName,
      webinarToken: _webinarToken,
    );

    final result = await _zoomSdk.joinMeeting(request);
    print('Join response: ${jsonEncode(result.toMap())}');
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
    _zoomSdk.onAuthenticationReturn.listen((event) {
      print("Example App onAuthenticationReturn: ${jsonEncode(event.toMap())}");
      if (event.params?.statusEnum == StatusZoomError.success) {
        joinMeeting();
      }
    });

    _meetingStatusSub = _zoomSdk.onMeetingStatusChanged.listen((event) {
      print(
        "Example App onMeetingStatusChanged event JSON = ${jsonEncode(event.toMap())}",
      );
    });

    _meetingStatusSub = _zoomSdk.onMeetingParameterNotification.listen((event) {
      print("onMeetingParameterNotification");
      print("Example App onMeetingParameterNotification event $event");
      print(
        "Example App onMeetingParameterNotification event JSON = ${jsonEncode(event.toMap())}",
      );
    });
  }

  void dispose() {
    _authSubscription?.cancel();
    _meetingSubscription?.cancel();
    _zoomEventSubscription?.cancel();

    _meetingStatusSub?.cancel();
  }
}
