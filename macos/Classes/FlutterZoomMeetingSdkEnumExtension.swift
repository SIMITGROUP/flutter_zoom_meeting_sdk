import ZoomSDK

extension ZoomSDKMeetingStatus {
  var name: String {
    switch self {
    case ZoomSDKMeetingStatus_Idle: return "Idle"
    case ZoomSDKMeetingStatus_Connecting: return "Connecting"
    case ZoomSDKMeetingStatus_WaitingForHost: return "WaitingForHost"
    case ZoomSDKMeetingStatus_InMeeting: return "InMeeting"
    case ZoomSDKMeetingStatus_Disconnecting: return "Disconnecting"
    case ZoomSDKMeetingStatus_Reconnecting: return "Reconnecting"
    case ZoomSDKMeetingStatus_Failed: return "Failed"
    case ZoomSDKMeetingStatus_Ended: return "Ended"
    case ZoomSDKMeetingStatus_AudioReady: return "AudioReady"
    case ZoomSDKMeetingStatus_OtherMeetingInProgress: return "OtherMeetingInProgress"
    case ZoomSDKMeetingStatus_InWaitingRoom: return "InWaitingRoom"
    case ZoomSDKMeetingStatus_Webinar_Promote: return "WebinarPromote"
    case ZoomSDKMeetingStatus_Webinar_Depromote: return "WebinarDepromote"
    case ZoomSDKMeetingStatus_Join_Breakout_Room: return "JoinBreakoutRoom"
    case ZoomSDKMeetingStatus_Leave_Breakout_Room: return "LeaveBreakoutRoom"
    default: return "UNDEFINED"
    }
  }
}

extension ZoomSDKAuthError {
  var name: String {
    switch self {
    case ZoomSDKAuthError_Success: return "SUCCESS"
    case ZoomSDKAuthError_KeyOrSecretWrong: return "KEY_OR_SECRET_WRONG"
    case ZoomSDKAuthError_AccountNotSupport: return "ACCOUNT_NOT_SUPPORT"
    case ZoomSDKAuthError_AccountNotEnableSDK: return "ACCOUNT_NOT_ENABLE_SDK"
    case ZoomSDKAuthError_Timeout: return "TIMEOUT"
    case ZoomSDKAuthError_NetworkIssue: return "NETWORK_ISSUE"
    case ZoomSDKAuthError_Client_Incompatible: return "CLIENT_INCOMPATIBLE"
    case ZoomSDKAuthError_JwtTokenWrong: return "JWT_TOKEN_WRONG"
    case ZoomSDKAuthError_KeyOrSecretEmpty: return "KEY_OR_SECRET_EMPTY"
    case ZoomSDKAuthError_LimitExceededException: return "LIMIT_EXCEEDED_EXCEPTION"
    case ZoomSDKAuthError_Unknown: return "UNKNOWN"
    default: return "UNDEFINED"
    }
  }
}

extension ZoomSDKError {
  var name: String {
    switch self {
    case ZoomSDKError_Success: return "Success"
    case ZoomSDKError_Failed: return "Failed"
    case ZoomSDKError_Uninit: return "Uninit"
    case ZoomSDKError_ServiceFailed: return "ServiceFailed"
    case ZoomSDKError_WrongUsage: return "WrongUsage"
    case ZoomSDKError_InvalidParameter: return "InvalidParameter"
    case ZoomSDKError_NoPermission: return "NoPermission"
    case ZoomSDKError_NoRecordingInProgress: return "NoRecordingInProgress"
    case ZoomSDKError_TooFrequentCall: return "TooFrequentCall"
    case ZoomSDKError_UnSupportedFeature: return "UnSupportedFeature"
    case ZoomSDKError_EmailLoginIsDisabled: return "EmailLoginIsDisabled"
    case ZoomSDKError_ModuleLoadFail: return "ModuleLoadFail"
    case ZoomSDKError_NoVideoData: return "NoVideoData"
    case ZoomSDKError_NoAudioData: return "NoAudioData"
    case ZoomSDKError_NoShareData: return "NoShareData"
    case ZoomSDKError_NoVideoDeviceFound: return "NoVideoDeviceFound"
    case ZoomSDKError_DeviceError: return "DeviceError"
    case ZoomSDKError_NotInMeeting: return "NotInMeeting"
    case ZoomSDKError_initDevice: return "InitDevice"
    case ZoomSDKError_CanNotChangeVirtualDevice: return "CanNotChangeVirtualDevice"
    case ZoomSDKError_PreprocessRawdataError: return "PreprocessRawdataError"
    case ZoomSDKError_NoLicense: return "NoLicense"
    case ZoomSDKError_Malloc_Failed: return "MallocFailed"
    case ZoomSDKError_ShareCannotSubscribeMyself: return "ShareCannotSubscribeMyself"
    case ZoomSDKError_NeedUserConfirmRecordDisclaimer: return "NeedUserConfirmRecordDisclaimer"
    case ZoomSDKError_UnKnown: return "Unknown"
    case ZoomSDKError_NotJoinAudio: return "NotJoinAudio"
    case ZoomSDKError_HardwareDontSupport: return "HardwareDontSupport"
    case ZoomSDKError_DomainDontSupport: return "DomainDontSupport"
    case ZoomSDKError_FileTransferError: return "FileTransferError"
    default: return "UNDEFINED"
    }
  }
}

extension ZoomSDKMeetingError {
  var name: String {
    switch self {
    case ZoomSDKMeetingError_Success: return "Success"
    case ZoomSDKMeetingError_NetworkUnavailable: return "NetworkUnavailable"
    case ZoomSDKMeetingError_ReconnectFailed: return "ReconnectFailed"
    case ZoomSDKMeetingError_MMRError: return "MMRError"
    case ZoomSDKMeetingError_PasswordError: return "PasswordError"
    case ZoomSDKMeetingError_SessionError: return "SessionError"
    case ZoomSDKMeetingError_MeetingOver: return "MeetingOver"
    case ZoomSDKMeetingError_MeetingNotStart: return "MeetingNotStart"
    case ZoomSDKMeetingError_MeetingNotExist: return "MeetingNotExist"
    case ZoomSDKMeetingError_UserFull: return "UserFull"
    case ZoomSDKMeetingError_ClientIncompatible: return "ClientIncompatible"
    case ZoomSDKMeetingError_NoMMR: return "NoMMR"
    case ZoomSDKMeetingError_MeetingLocked: return "MeetingLocked"
    case ZoomSDKMeetingError_MeetingRestricted: return "MeetingRestricted"
    case ZoomSDKMeetingError_MeetingJBHRestricted: return "MeetingJBHRestricted"
    case ZoomSDKMeetingError_EmitWebRequestFailed: return "EmitWebRequestFailed"
    case ZoomSDKMeetingError_StartTokenExpired: return "StartTokenExpired"
    case ZoomSDKMeetingError_VideoSessionError: return "VideoSessionError"
    case ZoomSDKMeetingError_AudioAutoStartError: return "AudioAutoStartError"
    case ZoomSDKMeetingError_RegisterWebinarFull: return "RegisterWebinarFull"
    case ZoomSDKMeetingError_RegisterWebinarHostRegister: return "RegisterWebinarHostRegister"
    case ZoomSDKMeetingError_RegisterWebinarPanelistRegister:
      return "RegisterWebinarPanelistRegister"
    case ZoomSDKMeetingError_RegisterWebinarDeniedEmail: return "RegisterWebinarDeniedEmail"
    case ZoomSDKMeetingError_RegisterWebinarEnforceLogin: return "RegisterWebinarEnforceLogin"
    case ZoomSDKMeetingError_ZCCertificateChanged: return "ZCCertificateChanged"
    case ZoomSDKMeetingError_vanityNotExist: return "VanityNotExist"
    case ZoomSDKMeetingError_joinWebinarWithSameEmail: return "JoinWebinarWithSameEmail"
    case ZoomSDKMeetingError_disallowHostMeeting: return "DisallowHostMeeting"
    case ZoomSDKMeetingError_ConfigFileWriteFailed: return "ConfigFileWriteFailed"
    case ZoomSDKMeetingError_forbidToJoinInternalMeeting: return "ForbidToJoinInternalMeeting"
    case ZoomSDKMeetingError_RemovedByHost: return "RemovedByHost"
    case ZoomSDKMeetingError_HostDisallowOutsideUserJoin: return "HostDisallowOutsideUserJoin"
    case ZoomSDKMeetingError_UnableToJoinExternalMeeting: return "UnableToJoinExternalMeeting"
    case ZoomSDKMeetingError_BlockedByAccountAdmin: return "BlockedByAccountAdmin"
    case ZoomSDKMeetingError_NeedSigninForPrivateMeeting: return "NeedSigninForPrivateMeeting"
    case ZoomSDKMeetingError_AppPrivilegeTokenError: return "AppPrivilegeTokenError"
    case ZoomSDKMeetingError_JmakUserEmailNotMatch: return "JmakUserEmailNotMatch"
    case ZoomSDKMeetingError_None: return "None"
    case ZoomSDKMeetingError_Unknown: return "Unknown"
    default: return "UNDEFINED"
    }
  }
}

extension EndMeetingReason {
  var name: String {
    switch self {
    case EndMeetingReason_None: return "None"
    case EndMeetingReason_KickByHost: return "KickByHost"
    case EndMeetingReason_EndByHost: return "EndByHost"
    case EndMeetingReason_JBHTimeOut: return "JBHTimeOut"
    case EndMeetingReason_NoAttendee: return "NoAttendee"
    case EndMeetingReason_HostStartAnotherMeeting: return "HostStartAnotherMeeting"
    case EndMeetingReason_FreeMeetingTimeOut: return "FreeMeetingTimeOut"
    case EndMeetingReason_NetworkBroken: return "NetworkBroken"
    default: return "UNDEFINED"
    }
  }
}

extension ZoomSDKLoginStatus {
  var name: String {
    switch self {
    case ZoomSDKLoginStatus_Idle: return "Idle"
    case ZoomSDKLoginStatus_Success: return "Success"
    case ZoomSDKLoginStatus_Failed: return "Failed"
    case ZoomSDKLoginStatus_Processing: return "Processing"
    default: return "UNDEFINED"
    }
  }
}

extension ZoomSDKLoginFailReason {
  var name: String {
    switch self {
    case ZoomSDKLoginFailReason_None: return "None"
    case ZoomSDKLoginFailReason_EmailLoginDisabled: return "EmailLoginDisabled"
    case ZoomSDKLoginFailReason_UserNotExist: return "UserNotExist"
    case ZoomSDKLoginFailReason_WrongPassword: return "WrongPassword"
    case ZoomSDKLoginFailReason_AccountLocked: return "AccountLocked"
    case ZoomSDKLoginFailReason_SDKNeedUpdate: return "SDKNeedUpdate"
    case ZoomSDKLoginFailReason_TooManyFailedAttempts: return "TooManyFailedAttempts"
    case ZoomSDKLoginFailReason_SMSCodeError: return "SMSCodeError"
    case ZoomSDKLoginFailReason_SMSCodeExpired: return "SMSCodeExpired"
    case ZoomSDKLoginFailReason_PhoneNumberFormatInValid: return "PhoneNumberFormatInValid"
    case ZoomSDKLoginFailReason_LoginTokenInvalid: return "LoginTokenInvalid"
    case ZoomSDKLoginFailReason_UserDisagreeLoginDisclaimer: return "UserDisagreeLoginDisclaimer"
    case ZoomSDKLoginFailReason_MFARequired: return "MFARequired"
    case ZoomSDKLoginFailReason_NeedBirthdayAsk: return "NeedBirthdayAsk"
    case ZoomSDKLoginFailReason_Other_Issue: return "Other_Issue"
    default: return "UNDEFINED"
    }
  }
}

extension ZoomSDKNotificationServiceStatus {
  var name: String {
    switch self {
    case ZoomSDKNotificationServiceStatus_None: return "None"
    case ZoomSDKNotificationServiceStatus_Starting: return "Starting"
    case ZoomSDKNotificationServiceStatus_Started: return "Started"
    case ZoomSDKNotificationServiceStatus_StartFailed: return "StartFailed"
    case ZoomSDKNotificationServiceStatus_Closed: return "Closed"
    default: return "UNDEFINED"
    }
  }
}

extension ZoomSDKNotificationServiceError {
  var name: String {
    switch self {
    case ZoomSDKNotificationServiceError_Success: return "Success"
    case ZoomSDKNotificationServiceError_Unknown: return "Unknown"
    case ZoomSDKNotificationServiceError_Internal_Error: return "Internal_Error"
    case ZoomSDKNotificationServiceError_Invalid_Token: return "Invalid_Token"
    case ZoomSDKNotificationServiceError_Multi_Connect: return "Multi_Connect"
    case ZoomSDKNotificationServiceError_Network_Issue: return "Network_Issue"
    case ZoomSDKNotificationServiceError_Max_Duration: return "Max_Duration"
    default: return "UNDEFINED"
    }
  }
}
