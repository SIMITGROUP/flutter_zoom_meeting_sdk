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
    default: return "Unknown"
    }
  }
}

extension ZoomSDKAuthError {
  var name: String {
    switch self {
    case ZoomSDKAuthError_Success: return "Success"
    case ZoomSDKAuthError_KeyOrSecretWrong: return "KeyOrSecretWrong"
    case ZoomSDKAuthError_AccountNotSupport: return "AccountNotSupport"
    case ZoomSDKAuthError_AccountNotEnableSDK: return "AccountNotEnableSDK"
    case ZoomSDKAuthError_Timeout: return "Timeout"
    case ZoomSDKAuthError_NetworkIssue: return "NetworkIssue"
    case ZoomSDKAuthError_Client_Incompatible: return "Client_Incompatible"
    case ZoomSDKAuthError_JwtTokenWrong: return "JwtTokenWrong"
    case ZoomSDKAuthError_KeyOrSecretEmpty: return "KeyOrSecretEmpty"
    case ZoomSDKAuthError_LimitExceededException: return "LimitExceededException"
    case ZoomSDKAuthError_Unknown: return "Unknown"
    default: return "Unknown(\(self.rawValue))"
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
    default: return "Unknown(\(self.rawValue))"
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
    default: return "Unknown(\(self.rawValue))"
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
    default: return "Unknown(\(self.rawValue))"
    }
  }
}
