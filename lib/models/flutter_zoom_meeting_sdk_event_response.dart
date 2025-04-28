import 'package:flutter_zoom_meeting_sdk/enums/event_type.dart';
import 'package:flutter_zoom_meeting_sdk/enums/platform_type.dart';

class FlutterZoomMeetingSdkEventResponse<T> {
  final PlatformType platform;
  final EventType event;
  final String oriEvent;
  final Map<String, dynamic> params;

  FlutterZoomMeetingSdkEventResponse({
    required this.platform,
    required this.event,
    required this.oriEvent,
    required this.params,
  });

  factory FlutterZoomMeetingSdkEventResponse.fromMap(Map<String, dynamic> map) {
    return FlutterZoomMeetingSdkEventResponse(
      platform: PlatformType.values.byName(map['platform']),
      event: EventType.values.byName(map['event']),
      oriEvent: map['oriEvent'],
      params: Map<String, dynamic>.from(map['params'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'platform': platform.name,
      'event': event.name,
      'oriEvent': oriEvent,
      'params': params,
      // params is InitParamsResponse
      //     ? (params as InitParamsResponse).toMap()
      //     : params is AuthParamsResponse
      //     ? (params as AuthParamsResponse).toMap()
      //     : params is JoinParamsResponse
      //     ? (params as JoinParamsResponse).toMap()
      //     : params,
    };
  }
}
