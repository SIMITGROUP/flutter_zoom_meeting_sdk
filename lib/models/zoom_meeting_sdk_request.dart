class ZoomMeetingSdkRequest {
  final String meetingNumber;
  final String password;
  final String displayName;

  ZoomMeetingSdkRequest({
    required this.meetingNumber,
    required this.password,
    required this.displayName,
  });

  // Factory method to create the object from a Map
  factory ZoomMeetingSdkRequest.fromMap(Map<String, dynamic> map) {
    return ZoomMeetingSdkRequest(
      meetingNumber: map['meetingNumber'] ?? '',
      password: map['password'] ?? '',
      displayName: map['displayName'] ?? '',
    );
  }

  // Optional: toDictionary method if you want to send data back from Flutter to Swift
  Map<String, dynamic> toMap() {
    return {
      'meetingNumber': meetingNumber,
      'password': password,
      'displayName': displayName,
    };
  }
}
