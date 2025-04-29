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
  meetingLocked,
  meetingRestricted,
  meetingJbhRestricted,
  webServiceFailed,
  registerWebinarFull,
  registerWebinarHostRegister,
  registerWebinarPanelistRegister,
  registerWebinarDeniedEmail,
  registerWebinarEnforceLogin,
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
  reconnectFailed,
  passwordError,
  meetingNotStart,
  emitWebRequestFailed,
  startTokenExpired,
  videoSessionError,
  audioAutoStartError,
  none,
  joinWebinarWithSameEmail,
  disallowHostMeeting,
  configFileWriteFailed,
  zcCertificateChanged,
  vanityNotExist,
  forbidToJoinInternalMeeting,
  invalidUserType,
  inAnotherMeeting,
  tooFrequenceCall,
  wrongUsage,
  failed,
  vbBase,
  vbSetError,
  vbMaximumNum,
  vbSaveImage,
  vbRemoveNone,
  vbNoSupport,
  vbGreenScreenNoSupport,
}

const Map<String, StatusMeetingError> statusMap = {
  // android, mac, ios
  'SUCCESS': StatusMeetingError.success,
  // android
  'INCORRECT_MEETING_NUMBER': StatusMeetingError.incorrectMeetingNumber,
  // android
  'TIMEOUT': StatusMeetingError.timeout,
  // android, mac, ios
  'NETWORK_UNAVAILABLE': StatusMeetingError.netowrkUnavailable,
  // android, mac, ios
  'CLIENT_INCOMPATIBLE': StatusMeetingError.clientIncompatible,
  // android
  'NETWORK_ERROR': StatusMeetingError.networkError,
  // android, mac, ios
  'MMR_ERROR': StatusMeetingError.mmrError,
  // android, mac, ios
  'SESSION_ERROR': StatusMeetingError.sessionError,
  // android, mac, ios
  'MEETING_OVER': StatusMeetingError.meetingOver,
  // android, mac, ios
  'MEETING_NOT_EXIST': StatusMeetingError.meetingNotExist,
  // android, mac, ios
  'USER_FULL': StatusMeetingError.userFull,
  // android, mac, ios
  'NO_MMR': StatusMeetingError.noMMR,
  // android, mac, ios
  'MEETING_LOCKED': StatusMeetingError.meetingLocked,
  // android, mac, ios
  'MEETING_RESTRICTED': StatusMeetingError.meetingRestricted,
  // android, mac, ios
  'MEETING_JBH_RESTRICTED': StatusMeetingError.meetingJbhRestricted,
  // android
  'WEB_SERVICE_FAILED': StatusMeetingError.webServiceFailed,
  // android, mac, ios
  'REGISTER_WEBINAR_FULL': StatusMeetingError.registerWebinarFull,
  // android, mac, ios
  'REGISTER_WEBINAR_HOST_REGISTER':
      StatusMeetingError.registerWebinarHostRegister,
  // android, mac, ios
  'REGISTER_WEBINAR_PANELIST_REGISTER':
      StatusMeetingError.registerWebinarPanelistRegister,
  // android, mac, ios
  'REGISTER_WEBINAR_DENIED_EMAIL':
      StatusMeetingError.registerWebinarDeniedEmail,
  // android, mac, ios
  'REGISTER_WEBINAR_ENFORCE_LOGIN':
      StatusMeetingError.registerWebinarEnforceLogin,
  // android
  'EXIT_WHEN_WAITING_HOST_START': StatusMeetingError.exitWhenWaitingHostStart,
  // android, mac, ios
  'REMOVED_BY_HOST': StatusMeetingError.removedByHost,
  // android, mac, ios
  'HOST_DISALLOW_OUTSIDE_USER_JOIN':
      StatusMeetingError.hostDisallowOutsideUserJoin,
  // android, mac, ios
  'UNABLE_TO_JOIN_EXTERNAL_MEETING':
      StatusMeetingError.unableToJoinExternalMeeting,
  // android, mac, ios
  'BLOCKED_BY_ACCOUNT_ADMIN': StatusMeetingError.blockedByAccountAdmin,
  // android, mac, ios
  'NEED_SIGN_IN_FOR_PRIVATE_MEETING':
      StatusMeetingError.needSignInForPrivateMeeting,
  // android, ios
  'INVALID_ARGUMENTS': StatusMeetingError.invalidArguments,
  // android, mac, ios
  'UNKNOWN': StatusMeetingError.unknown,
  // android
  'INVALID_STATUS': StatusMeetingError.invalidStatus,
  // android, mac
  'JMAK_USER_EMAIL_NOT_MATCH': StatusMeetingError.jmakUserEmailNotMatch,
  // android, mac, ios
  'APP_PRIVILEGE_TOKEN_ERROR': StatusMeetingError.appPrivilegeTokenError,
  // mac, ios
  'RECONNECT_FAILED': StatusMeetingError.reconnectFailed,
  // mac, ios
  'PASSWORD_ERROR': StatusMeetingError.passwordError,
  // mac, ios
  'MEETING_NOT_START': StatusMeetingError.meetingNotStart,
  // mac, ios
  'EMIT_WEB_REQUEST_FAILED': StatusMeetingError.emitWebRequestFailed,
  // mac, ios
  'START_TOKEN_EXPIRED': StatusMeetingError.startTokenExpired,
  // mac, ios
  'VIDEO_SESSION_ERROR': StatusMeetingError.videoSessionError,
  // mac, ios
  'AUDIO_AUTO_START_ERROR': StatusMeetingError.audioAutoStartError,
  // mac
  'NONE': StatusMeetingError.none,
  // mac, ios
  'JOIN_WEBINAR_WITH_SAME_EMAIL': StatusMeetingError.joinWebinarWithSameEmail,
  // mac
  'DISALLOW_HOST_MEETING': StatusMeetingError.disallowHostMeeting,
  // mac, ios
  'CONFIG_FILE_WRITE_FAILED': StatusMeetingError.configFileWriteFailed,
  // mac, ios
  'ZC_CERTIFICATE_CHANGED': StatusMeetingError.zcCertificateChanged,
  // mac, ios
  'VANITY_NOT_EXIST': StatusMeetingError.vanityNotExist,
  // mac
  'FORBID_TO_JOIN_INTERNAL_MEETING':
      StatusMeetingError.forbidToJoinInternalMeeting,
  // ios
  'INVALID_USER_TYPE': StatusMeetingError.invalidUserType,
  // ios
  'IN_ANOTHER_MEETING': StatusMeetingError.inAnotherMeeting,
  // ios
  'TOO_FREQUENCE_CALL': StatusMeetingError.tooFrequenceCall,
  // ios
  'WRONG_USAGE': StatusMeetingError.wrongUsage,
  // ios
  'FAILED': StatusMeetingError.failed,
  // ios
  'VB_BASE': StatusMeetingError.vbBase,
  // ios
  'VB_SET_ERROR': StatusMeetingError.vbSetError,
  // ios
  'VB_MAXIMUM_NUM': StatusMeetingError.vbMaximumNum,
  // ios
  'VB_SAVE_IMAGE': StatusMeetingError.vbSaveImage,
  // ios
  'VB_REMOVE_NONE': StatusMeetingError.vbRemoveNone,
  // ios
  'VB_NO_SUPPORT': StatusMeetingError.vbNoSupport,
  // ios
  'VB_GREEN_SCREEN_NO_SUPPORT': StatusMeetingError.vbGreenScreenNoSupport,
};

extension StatusMeetingErrorMapper on StatusMeetingError {
  static StatusMeetingError fromString(String status) {
    return statusMap[status.toUpperCase()] ?? StatusMeetingError.undefined;
  }
}
