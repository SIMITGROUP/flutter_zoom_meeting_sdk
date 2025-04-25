import MobileRTC
extension MobileRTCMeetingState {
    var name: String {
        switch self {
        case .idle: return "Idle"
        case .connecting: return "Connecting"
        case .waitingForHost: return "WaitingForHost"
        case .inMeeting: return "InMeeting"
        case .disconnecting: return "Disconnecting"
        case .reconnecting: return "Reconnecting"
        case .failed: return "Failed"
        case .ended: return "Ended"
        case .locked: return "Locked"
        case .unlocked: return "Unlocked"
        case .inWaitingRoom: return "InWaitingRoom"
        case .webinarPromote: return "WebinarPromote"
        case .webinarDePromote: return "WebinarDePromote"
        case .joinBO: return "JoinBO"
        case .leaveBO: return "LeaveBO"
        @unknown default: return "Unknown"
        }
    }
}


extension MobileRTCAuthError {
    var name: String {
        switch self {
        case .success: return "Success"
        case .keyOrSecretEmpty: return "KeyOrSecretEmpty"
        case .keyOrSecretWrong: return "KeyOrSecretWrong"
        case .accountNotSupport: return "AccountNotSupport"
        case .accountNotEnableSDK: return "AccountNotEnableSDK"
        case .unknown: return "Unknown"
        case .serviceBusy: return "ServiceBusy"
        case .none: return "None"
        case .overTime: return "OverTime"
        case .networkIssue: return "NetworkIssue"
        case .clientIncompatible: return "ClientIncompatible"
        case .tokenWrong: return "TokenWrong"
        case .limitExceededException: return "LimitExceededException"
        @unknown default: return "Unknown"
        }
    }
}

extension MobileRTCSDKError {
    var name: String {
        switch self {
        case .success: return "Success"
        case .noImpl: return "NoImpl"
        case .wrongUsage: return "WrongUsage"
        case .invalidParameter: return "InvalidParameter"
        case .moduleLoadFailed: return "ModuleLoadFailed"
        case .memoryFailed: return "MemoryFailed"
        case .serviceFailed: return "ServiceFailed"
        case .uninitialize: return "Uninitialize"
        case .unauthentication: return "Unauthentication"
        case .noRecordingInprocess: return "NoRecordingInprocess"
        case .transcoderNoFound: return "TranscoderNoFound"
        case .videoNotReady: return "VideoNotReady"
        case .noPermission: return "NoPermission"
        case .unknown: return "Unknown"
        case .otherSdkInstanceRunning: return "OtherSdkInstanceRunning"
        case .internalError: return "InternalError"
        case .noAudiodeviceIsFound: return "NoAudiodeviceIsFound"
        case .noVideoDeviceIsFound: return "NoVideoDeviceIsFound"
        case .tooFrequentCall: return "TooFrequentCall"
        case .failAssignUserPrivilege: return "FailAssignUserPrivilege"
        case .meetingDontSupportFeature: return "MeetingDontSupportFeature"
        case .meetingNotShareSender: return "MeetingNotShareSender"
        case .meetingYouHaveNoShare: return "MeetingYouHaveNoShare"
        case .meetingViewtypeParameterIsWrong: return "MeetingViewtypeParameterIsWrong"
        case .meetingAnnotationIsOff: return "MeetingAnnotationIsOff"
        case .settingOsDontSupport: return "SettingOsDontSupport"
        case .emailLoginIsDisabled: return "EmailLoginIsDisabled"
        case .hardwareNotMeetForVb: return "HardwareNotMeetForVb"
        case .needUserConfirmRecordDisclaimer: return "NeedUserConfirmRecordDisclaimer"
        case .noShareData: return "NoShareData"
        case .shareCannotSubscribeMyself: return "ShareCannotSubscribeMyself"
        case .notInMeeting: return "NotInMeeting"
        case .meetingCallOutFailed: return "MeetingCallOutFailed"
        case .notSupportMultiStreamVideoUser: return "NotSupportMultiStreamVideoUser"
        case .meetingRemoteControlIsOff: return "MeetingRemoteControlIsOff"
        case .fileTransferError: return "FileTransferError"
        @unknown default: return "Unknown"
        }
    }
}

extension MobileRTCMeetError {
    var name: String {
        switch self {
        case .success: return "Success"
        case .networkError: return "NetworkError"
        case .reconnectError: return "ReconnectError"
        case .mmrError: return "MMRError"
        case .passwordError: return "PasswordError"
        case .sessionError: return "SessionError"
        case .meetingOver: return "MeetingOver"
        case .meetingNotStart: return "MeetingNotStart"
        case .meetingNotExist: return "MeetingNotExist"
        case .meetingUserFull: return "MeetingUserFull"
        case .meetingClientIncompatible: return "MeetingClientIncompatible"
        case .noMMR: return "NoMMR"
        case .meetingLocked: return "MeetingLocked"
        case .meetingRestricted: return "MeetingRestricted"
        case .meetingRestrictedJBH: return "MeetingRestrictedJBH"
        case .cannotEmitWebRequest: return "CannotEmitWebRequest"
        case .cannotStartTokenExpire: return "CannotStartTokenExpire"
        case .videoError: return "VideoError"
        case .audioAutoStartError: return "AudioAutoStartError"
        case .registerWebinarFull: return "RegisterWebinarFull"
        case .registerWebinarHostRegister: return "RegisterWebinarHostRegister"
        case .registerWebinarPanelistRegister: return "RegisterWebinarPanelistRegister"
        case .registerWebinarDeniedEmail: return "RegisterWebinarDeniedEmail"
        case .registerWebinarEnforceLogin: return "RegisterWebinarEnforceLogin"
        case .zcCertificateChanged: return "ZCCertificateChanged"
        case .vanityNotExist: return "VanityNotExist"
        case .joinWebinarWithSameEmail: return "JoinWebinarWithSameEmail"
        case .writeConfigFile: return "WriteConfigFile"
        case .removedByHost: return "RemovedByHost"
        case .hostDisallowOutsideUserJoin: return "HostDisallowOutsideUserJoin"
        case .unableToJoinExternalMeeting: return "UnableToJoinExternalMeeting"
        case .blockedByAccountAdmin: return "BlockedByAccountAdmin"
        case .needSignInForPrivateMeeting: return "NeedSignInForPrivateMeeting"
        case .invalidArguments: return "InvalidArguments"
        case .invalidUserType: return "InvalidUserType"
        case .inAnotherMeeting: return "InAnotherMeeting"
        case .tooFrequenceCall: return "TooFrequenceCall"
        case .wrongUsage: return "WrongUsage"
        case .failed: return "Failed"
        case .vbBase: return "VBBase"
        case .vbSetError: return "VBSetError"
        case .vbMaximumNum: return "VBMaximumNum"
        case .vbSaveImage: return "VBSaveImage"
        case .vbRemoveNone: return "VBRemoveNone"
        case .vbNoSupport: return "VBNoSupport"
        case .vbGreenScreenNoSupport: return "VBGreenScreenNoSupport"
        case .appPrivilegeTokenError: return "AppPrivilegeTokenError"
        case .unknown: return "Unknown"
        @unknown default: return "Unknown"
        }
    }
}

extension MobileRTCMeetingEndReason {
    var name: String {
        switch self {
        case .selfLeave: return "SelfLeave"
        case .removedByHost: return "RemovedByHost"
        case .endByHost: return "EndByHost"
        case .jbhTimeout: return "JBHTimeout"
        case .freeMeetingTimeout: return "FreeMeetingTimeout"
        case .noAteendee: return "NoAteendee"
        case .hostEndForAnotherMeeting: return "HostEndForAnotherMeeting"
        case .connectBroken: return "ConnectBroken"
        case .unknown: return "Unknown"
        @unknown default: return "Unknown"
        }
    }
}

extension MobileRTCLoginFailReason {
    var name: String {
        switch self {
        case .success: return "Success"
        case .emailLoginDisable: return "EmailLoginDisable"
        case .userNotExist: return "UserNotExist"
        case .wrongPassword: return "WrongPassword"
        case .accountLocked: return "AccountLocked"
        case .sdkNeedUpdate: return "SDKNeedUpdate"
        case .tooManyFailedAttempts: return "TooManyFailedAttempts"
        case .smsCodeError: return "SMSCodeError"
        case .smsCodeExpired: return "SMSCodeExpired"
        case .phoneNumberFormatInValid: return "PhoneNumberFormatInValid"
        case .loginTokenInvalid: return "LoginTokenInvalid"
        case .userDisagreeLoginDisclaimer: return "UserDisagreeLoginDisclaimer"
        case .mfaRequired: return "MFARequired"
        case .needBirthdayAsk: return "NeedBirthdayAsk"
        case .otherIssue: return "OtherIssue"
        case .invalidArguments: return "InvalidArguments"
        case .sdkNotAuthorized: return "SDKNotAuthorized"
        case .inAutoLoginProcess: return "InAutoLoginProcess"
        case .alreayLoggedin: return "AlreayLoggedin"
        @unknown default: return "Unknown"
        }
    }
}

extension MobileRTCNotificationServiceStatus {
    var name: String {
        switch self {
        case .none: return "None"
        case .starting: return "Starting"
        case .started: return "Started"
        case .startFailed: return "StartFailed"
        case .closed: return "Closed"
        @unknown default: return "Unknown"
        }
    }
}

extension MobileRTCNotificationServiceError {
    var name: String {
        switch self {
        case .success: return "Success"
        case .unknown: return "Unknown"
        case .internal_Error: return "Internal_Error"
        case .invalid_Token: return "Invalid_Token"
        case .multi_Connect: return "Multi_Connect"
        case .network_Issue: return "Network_Issue"
        case .max_Duration: return "Max_Duration"
        case .app_Background: return "App_Background"
        @unknown default: return "Unknown"
        }
    }
}
