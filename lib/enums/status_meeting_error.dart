enum StatusMeetingError {
  success,
  incorrectMeetingNumber,
  timeout,
  netowrkUnavailable,
  clientIncompatible,
  networkError,
  mmrError,
  sessionError,
  meetingOver,
  meetingNotExist,
  userFull,
  noMMR,
  locked,
  restricted,
  restrictedJBH,
  webServiceFailed,
  registerWebinarFull,
  disallowHostRegisterWebinar,
  disallowPanelistRegisterWebinar,
  hostDenyEmailRegisterWebinar,
  webinarEnforceLogin,
  exitWhenWaitingHostStart,
  removedByHost,
  hostDisallowOutsideUserJoin,
  unableToJoinExternalMeeting,
  blockedByAccountAdmin,
  needSignInForPrivateMeeting,
  invalidArguments,
  unknown,
  invalidStatus,
  jmakUserEmailNotMatch,
  appPrivilegeTokenError,
  undefined,
}

const Map<String, StatusMeetingError> statusMap = {
  'SUCCESS': StatusMeetingError.success,
  'INCORRECT_MEETING_NUMBER': StatusMeetingError.incorrectMeetingNumber,
  'TIMEOUT': StatusMeetingError.timeout,
  'NETWORK_UNAVAILABLE': StatusMeetingError.netowrkUnavailable,
  'CLIENT_INCOMPATIBLE': StatusMeetingError.clientIncompatible,
  'NETWORK_ERROR': StatusMeetingError.networkError,
  'MMR_ERROR': StatusMeetingError.mmrError,
  'SESSION_ERROR': StatusMeetingError.sessionError,
  'MEETING_OVER': StatusMeetingError.meetingOver,
  'MEETING_NOT_EXIST': StatusMeetingError.meetingNotExist,
  'USER_FULL': StatusMeetingError.userFull,
  'NO_MMR': StatusMeetingError.noMMR,
  'LOCKED': StatusMeetingError.locked,
  'RESTRICTED': StatusMeetingError.restricted,
  'RESTRICTED_JBH': StatusMeetingError.restrictedJBH,
  'WEB_SERVICE_FAILED': StatusMeetingError.webServiceFailed,
  'REGISTER_WEBINAR_FULL': StatusMeetingError.registerWebinarFull,
  'DISALLOW_HOST_REGISTER_WEBINAR':
      StatusMeetingError.disallowHostRegisterWebinar,
  'DISALLOW_PANELIST_REGISTER_WEBINAR':
      StatusMeetingError.disallowPanelistRegisterWebinar,
  'HOST_DENY_EMAIL_REGISTER_WEBINAR':
      StatusMeetingError.hostDenyEmailRegisterWebinar,
  'WEBINAR_ENFORCE_LOGIN': StatusMeetingError.webinarEnforceLogin,
  'EXIT_WHEN_WAITING_HOST_START': StatusMeetingError.exitWhenWaitingHostStart,
  'REMOVED_BY_HOST': StatusMeetingError.removedByHost,
  'HOST_DISALLOW_OUTSIDE_USER_JOIN':
      StatusMeetingError.hostDisallowOutsideUserJoin,
  'UNABLE_TO_JOIN_EXTERNAL_MEETING':
      StatusMeetingError.unableToJoinExternalMeeting,
  'BLOCKED_BY_ACCOUNT_ADMIN': StatusMeetingError.blockedByAccountAdmin,
  'NEED_SIGN_IN_FOR_PRIVATE_MEETING':
      StatusMeetingError.needSignInForPrivateMeeting,
  'INVALID_ARGUMENTS': StatusMeetingError.invalidArguments,
  'UNKNOWN': StatusMeetingError.unknown,
  'INVALID_STATUS': StatusMeetingError.invalidStatus,
  'JMAK_USER_EMAIL_NOT_MATCH': StatusMeetingError.jmakUserEmailNotMatch,
  'APP_PRIVILEGE_TOKEN_ERROR': StatusMeetingError.appPrivilegeTokenError,
};

extension StatusMeetingErrorMapper on StatusMeetingError {
  static StatusMeetingError fromString(String status) {
    return statusMap[status.toUpperCase()] ?? StatusMeetingError.undefined;
  }
}
