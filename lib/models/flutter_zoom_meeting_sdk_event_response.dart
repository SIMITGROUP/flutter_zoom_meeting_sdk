import 'package:flutter_zoom_meeting_sdk/enums/event_type.dart';
import 'package:flutter_zoom_meeting_sdk/enums/platform_type.dart';
import 'package:flutter_zoom_meeting_sdk/enums/status_meeting_end_reason.dart';
import 'package:flutter_zoom_meeting_sdk/enums/status_meeting_error.dart';
import 'package:flutter_zoom_meeting_sdk/enums/status_meeting_status.dart';
import 'package:flutter_zoom_meeting_sdk/enums/status_meeting_type.dart';
import 'package:flutter_zoom_meeting_sdk/enums/status_zoom_error.dart';
import 'package:flutter_zoom_meeting_sdk/helpers/common.dart';

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
          params is MappableParams
              ? (params as MappableParams).toMap()
              : params,
    };
  }
}

class EventAuthenticateReturnParams implements MappableParams {
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
      statusCode: map['statusCode'],
      statusLabel: map['statusLabel'],
      statusEnum: StatusZoomErrorMapper.fromString(map['statusLabel']),
      internalErrorCode: map['internalErrorCode'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'statusLabel': statusLabel,
      'statusEnum': statusEnum.name,
      'internalErrorCode': internalErrorCode,
    };
  }
}

class EventMeetingStatusChangedParams implements MappableParams {
  final int statusCode;
  final String statusLabel;
  final StatusMeetingStatus statusEnum;
  final int errorCode;
  final String errorLabel;
  final StatusMeetingError errorEnum;
  final int endReasonCode;
  final String endReasonLabel;
  final StatusMeetingEndReason endReasonEnum;

  /// Only **ANDROID** will have this field. ZOOM internal error code
  final int? internalErrorCode;

  EventMeetingStatusChangedParams({
    required this.statusCode,
    required this.statusLabel,
    required this.statusEnum,
    required this.errorCode,
    required this.errorLabel,
    required this.errorEnum,
    required this.endReasonCode,
    required this.endReasonLabel,
    required this.endReasonEnum,
    this.internalErrorCode,
  });

  factory EventMeetingStatusChangedParams.fromMap(Map<String, dynamic> map) {
    return EventMeetingStatusChangedParams(
      statusCode: map['statusCode'],
      statusLabel: map['statusLabel'],
      statusEnum: StatusMeetingStatusMapper.fromString(map['statusLabel']),
      errorCode: map['errorCode'],
      errorLabel: map['errorLabel'],
      errorEnum: StatusMeetingErrorMapper.fromString(map['errorLabel']),
      endReasonCode: map['endReasonCode'],
      endReasonLabel: map['endReasonLabel'],
      endReasonEnum: StatusMeetingEndReasonMapper.fromString(
        map['endReasonLabel'],
      ),
      internalErrorCode: map['internalErrorCode'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'statusCode': statusCode,
      'statusLabel': statusLabel,
      'statusEnum': statusEnum.name,
      'errorCode': errorCode,
      'errorLabel': errorLabel,
      'errorEnum': errorEnum.name,
      'endReasonCode': endReasonCode,
      'endReasonLabel': endReasonLabel,
      'endReasonEnum': endReasonEnum.name,
      if (internalErrorCode != null) 'internalErrorCode': internalErrorCode,
    };
  }
}

class EventMeetingParameterNotificationParams implements MappableParams {
  final bool isAutoRecordingCloud;
  final bool isAutoRecordingLocal;
  final bool isViewOnly;
  final String meetingHost;
  final String meetingTopic;
  final int meetingNumber;
  final int meetingType;
  final String meetingTypeLabel;
  final StatusMeetingType meetingTypeEnum;

  EventMeetingParameterNotificationParams({
    required this.isAutoRecordingCloud,
    required this.isAutoRecordingLocal,
    required this.isViewOnly,
    required this.meetingHost,
    required this.meetingTopic,
    required this.meetingNumber,
    required this.meetingType,
    required this.meetingTypeLabel,
    required this.meetingTypeEnum,
  });

  factory EventMeetingParameterNotificationParams.fromMap(
    Map<String, dynamic> map,
  ) {
    return EventMeetingParameterNotificationParams(
      isAutoRecordingCloud: map['isAutoRecordingCloud'],
      isAutoRecordingLocal: map['isAutoRecordingLocal'],
      isViewOnly: map['isViewOnly'],
      meetingHost: map['meetingHost'],
      meetingTopic: map['meetingTopic'],
      meetingNumber: map['meetingNumber'],
      meetingType: map['meetingType'],
      meetingTypeLabel: map['meetingTypeLabel'],
      meetingTypeEnum: StatusMeetingTypeMapper.fromString(
        map['meetingTypeLabel'],
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'isAutoRecordingCloud': isAutoRecordingCloud,
      'isAutoRecordingLocal': isAutoRecordingLocal,
      'isViewOnly': isViewOnly,
      'meetingHost': meetingHost,
      'meetingTopic': meetingTopic,
      'meetingNumber': meetingNumber,
      'meetingType': meetingType,
      'meetingTypeLabel': meetingTypeLabel,
      'meetingTypeEnum': meetingTypeEnum.name,
    };
  }
}

class EventMeetingErrorParams implements MappableParams {
  final int errorCode;
  final String errorLabel;
  final StatusMeetingError errorEnum;
  final String message;

  EventMeetingErrorParams({
    required this.errorCode,
    required this.errorLabel,
    required this.errorEnum,
    required this.message,
  });

  factory EventMeetingErrorParams.fromMap(Map<String, dynamic> map) {
    return EventMeetingErrorParams(
      errorCode: map['errorCode'],
      errorLabel: map['errorLabel'],
      errorEnum: StatusMeetingErrorMapper.fromString(map['errorLabel']),
      message: map['message'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'errorCode': errorCode,
      'errorLabel': errorLabel,
      'errorEnum': errorEnum.name,
      'message': message,
    };
  }
}

class EventMeetingEndedReasonParams implements MappableParams {
  final int endReasonCode;
  final String endReasonLabel;
  final StatusMeetingEndReason endReasonEnum;

  EventMeetingEndedReasonParams({
    required this.endReasonCode,
    required this.endReasonLabel,
    required this.endReasonEnum,
  });

  factory EventMeetingEndedReasonParams.fromMap(Map<String, dynamic> map) {
    return EventMeetingEndedReasonParams(
      endReasonCode: map['endReasonCode'],
      endReasonLabel: map['endReasonLabel'],
      endReasonEnum: StatusMeetingEndReasonMapper.fromString(
        map['endReasonLabel'],
      ),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'endReasonCode': endReasonCode,
      'endReasonLabel': endReasonLabel,
      'endReasonEnum': endReasonEnum.name,
    };
  }
}
