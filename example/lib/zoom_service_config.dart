part of 'zoom_service.dart';

extension ZoomServiceConfig on ZoomService {
  String get authEndpoint => _authEndpoint;
  String get meetingNumber => _meetingNumber;
  String get userName => _userName;
  String get passCode => _passCode;
  int get role => _role;

  void setAuthEndpoint(String endpoint) => _authEndpoint = endpoint;
  void setMeetingNumber(String meetingNumber) => _meetingNumber = meetingNumber;
  void setUserName(String userName) => _userName = userName;
  void setPassCode(String passCode) => _passCode = passCode;
  void setRole(int role) => _role = role;
}
