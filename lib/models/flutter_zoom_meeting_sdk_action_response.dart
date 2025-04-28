import 'package:flutter_zoom_meeting_sdk/enums/action_type.dart';
import 'package:flutter_zoom_meeting_sdk/enums/platform_type.dart';
import 'package:flutter_zoom_meeting_sdk/helpers/message.dart';

class FlutterZoomMeetingSdkActionResponse<T> {
  final PlatformType platform;
  final ActionType action;
  final bool isSuccess;
  final String message;
  final T params;

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
      params: paramsParser(
        Map<String, dynamic>.from(map['params'] ?? {}),
      ), // Use parser
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'platform': platform.name,
      'action': action.name,
      'isSuccess': isSuccess,
      'message': message,
      'params':
          params is InitParamsResponse
              ? (params as InitParamsResponse).toMap()
              : params,
    };
  }
}

class InitParamsResponse {
  final int status;
  final String statusName;

  InitParamsResponse({required this.status, required this.statusName});

  factory InitParamsResponse.fromMap(Map<String, dynamic> map) {
    return InitParamsResponse(
      status: map['status'],
      statusName: map['statusName'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'status': status, 'statusName': statusName};
  }
}
