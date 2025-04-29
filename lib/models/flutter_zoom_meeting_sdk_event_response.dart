import 'package:flutter_zoom_meeting_sdk/enums/event_type.dart';
import 'package:flutter_zoom_meeting_sdk/enums/platform_type.dart';
import 'package:flutter_zoom_meeting_sdk/enums/status_zoom_error.dart';

class FlutterZoomMeetingSdkEventResponse<T> {
  final PlatformType platform;
  final EventType event;
  final String oriEvent;
  final T? params;

  FlutterZoomMeetingSdkEventResponse({
    required this.platform,
    required this.event,
    required this.oriEvent,
    required this.params,
  });

  factory FlutterZoomMeetingSdkEventResponse.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) paramsParser,
  ) {
    return FlutterZoomMeetingSdkEventResponse(
      platform: PlatformType.values.byName(map['platform']),
      event: EventType.values.byName(map['event']),
      oriEvent: map['oriEvent'],
      params:
          map['params'] != null && map['params'].isNotEmpty
              ? paramsParser(Map<String, dynamic>.from(map['params']))
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'platform': platform.name,
      'event': event.name,
      'oriEvent': oriEvent,
      'params':
          params is EventAuthenticateReturnParams
              ? (params as EventAuthenticateReturnParams).toMap()
              : params,
    };
  }
}

class EventAuthenticateReturnParams {
  final int statusCode;
  final String statusLabel;
  final StatusZoomError statusEnum;

  /// Only **ANDROID** will have this field. ZOOM internal error code
  final int? internalErrorCode;

  EventAuthenticateReturnParams({
    required this.statusCode,
    required this.statusLabel,
    required this.statusEnum,
    this.internalErrorCode,
  });

  factory EventAuthenticateReturnParams.fromMap(Map<String, dynamic> map) {
    return EventAuthenticateReturnParams(
      statusCode: map['status'],
      statusLabel: map['statusName'],
      statusEnum: StatusZoomErrorMapper.fromString(map['statusName']),
      internalErrorCode: map['internalErrorCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'statusLabel': statusLabel,
      'statusEnum': statusEnum.name,
      'internalErrorCode': internalErrorCode,
    };
  }
}
