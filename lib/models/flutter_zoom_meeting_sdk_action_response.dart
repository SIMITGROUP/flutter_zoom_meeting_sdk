import 'package:flutter_zoom_meeting_sdk/enums/action_type.dart';
import 'package:flutter_zoom_meeting_sdk/enums/platform_type.dart';
import 'package:flutter_zoom_meeting_sdk/helpers/common.dart';
import 'package:flutter_zoom_meeting_sdk/helpers/message.dart';

class FlutterZoomMeetingSdkActionResponse<T> {
  final PlatformType platform;
  final ActionType action;
  final bool isSuccess;
  final String message;
  final T? params;

  FlutterZoomMeetingSdkActionResponse({
    required this.platform,
    required this.action,
    required this.isSuccess,
    required this.message,
    required this.params,
  });

  factory FlutterZoomMeetingSdkActionResponse.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) paramsParser,
  ) {
    return FlutterZoomMeetingSdkActionResponse(
      platform: PlatformType.values.byName(map['platform']),
      action: ActionType.values.byName(map['action']),
      isSuccess: map['isSuccess'],
      message: getActionMessage(map['message'] ?? ''),
      params:
          map['params'] != null && map['params'].isNotEmpty
              ? paramsParser(Map<String, dynamic>.from(map['params']))
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'platform': platform.name,
      'action': action.name,
      'isSuccess': isSuccess,
      'message': message,
      'params':
          params is MappableParams
              ? (params as MappableParams).toMap()
              : params,
    };
  }
}

class InitParamsResponse implements MappableParams {
  final int? statusCode;
  final String? statusLabel;

  InitParamsResponse({this.statusCode, this.statusLabel});

  factory InitParamsResponse.fromMap(Map<String, dynamic> map) {
    return InitParamsResponse(
      statusCode:
          map['statusCode'] != null ? (map['status'] as num).toInt() : null,
      statusLabel: map['statusLabel'] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'statusCode': statusCode, 'statusLabel': statusLabel};
  }
}

class AuthParamsResponse implements MappableParams {
  final int statusCode;
  final String statusLabel;

  AuthParamsResponse({required this.statusCode, required this.statusLabel});

  factory AuthParamsResponse.fromMap(Map<String, dynamic> map) {
    return AuthParamsResponse(
      statusCode: map['statusCode'],
      statusLabel: map['statusLabel'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'statusCode': statusCode, 'statusLabel': statusLabel};
  }
}

class JoinParamsResponse implements MappableParams {
  final int statusCode;
  final String statusLabel;

  JoinParamsResponse({required this.statusCode, required this.statusLabel});

  factory JoinParamsResponse.fromMap(Map<String, dynamic> map) {
    return JoinParamsResponse(
      statusCode: map['statusCode'],
      statusLabel: map['statusLabel'] as String,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {'statusCode': statusCode, 'statusLabel': statusLabel};
  }
}
