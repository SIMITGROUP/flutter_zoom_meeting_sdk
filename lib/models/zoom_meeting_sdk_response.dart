class StandardZoomMeetingResponse {
  final bool success;
  final String message;
  final int statusCode;
  final String statusText;

  StandardZoomMeetingResponse({
    required this.success,
    required this.message,
    required this.statusCode,
    required this.statusText,
  });

  // Factory method to create the object from a Map
  factory StandardZoomMeetingResponse.fromMap(Map<String, dynamic> map) {
    return StandardZoomMeetingResponse(
      success: map['success'] ?? false,
      message: map['message'] ?? '',
      statusCode: map['statusCode'] ?? 0,
      statusText: map['statusText'] ?? '',
    );
  }

  // Optional: toDictionary method if you want to send data back from Flutter to Swift
  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'statusCode': statusCode,
      'statusText': statusText,
    };
  }
}
