class StandardZoomMeetingResponse {
  final bool success;
  final String message;
  final int code;

  StandardZoomMeetingResponse({
    required this.success,
    required this.message,
    required this.code,
  });

  // Factory method to create the object from a Map
  factory StandardZoomMeetingResponse.fromMap(Map<String, dynamic> map) {
    return StandardZoomMeetingResponse(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      code: map['code'] ?? 0,
    );
  }

  // Optional: toDictionary method if you want to send data back from Flutter to Swift
  Map<String, dynamic> toMap() {
    return {'success': success, 'message': message, 'code': code};
  }
}
