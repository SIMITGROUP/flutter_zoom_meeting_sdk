import MobileRTC
extension MobileRTCMeetingState {
    var name: String {
        switch self {
        case .idle:
            return "Idle"
        case .connecting:
            return "Connecting"
        case .waitingForHost:
            return "Waiting for Host"
        case .inMeeting:
            return "In Meeting"
        case .disconnecting:
            return "Disconnecting"
        case .reconnecting:
            return "Reconnecting"
        case .failed:
            return "Failed"
        case .ended:
            return "Ended"
        case .locked:
            return "Locked"
        case .unlocked:
            return "Unlocked"
        case .inWaitingRoom:
            return "In Waiting Room"
        case .webinarPromote:
            return "Webinar Promote"
        case .webinarDePromote:
            return "Webinar De-Promote"
        case .joinBO:
            return "Join Breakout Room"
        case .leaveBO:
            return "Leave Breakout Room"
        @unknown default:
            return "Unknown"
        }
    }
}


extension MobileRTCAuthError {
    var name: String {
        switch self {
        case .success:
            return "Success"
        case .keyOrSecretEmpty:
            return "KeyOrSecretEmpty"
        case .keyOrSecretWrong:
            return "KeyOrSecretWrong"
        case .accountNotSupport:
            return "AccountNotSupport"
        case .accountNotEnableSDK:
            return "AccountNotEnableSDK"
        case .unknown:
            return "Unknown"
        case .serviceBusy:
            return "ServiceBusy"
        case .none:
            return "None"
        case .overTime:
            return "OverTime"
        case .networkIssue:
            return "NetworkIssue"
        case .clientIncompatible:
            return "ClientIncompatible"
        case .tokenWrong:
            return "TokenWrong"
        case .limitExceededException:
            return "LimitExceededException"
        @unknown default:
            return "Unknown (Unhandled)"
        }
    }
}

extension MobileRTCSDKError {
    var name: String {
        switch self {
        case .success: return "Success"
        case .noImpl: return "No Implementation"
        case .wrongUsage: return "Wrong Usage"
        case .invalidParameter: return "Invalid Parameter"
        case .moduleLoadFailed: return "Module Load Failed"
        case .memoryFailed: return "Memory Failed"
        case .serviceFailed: return "Service Failed"
        case .uninitialize: return "Uninitialized"
        case .unauthentication: return "Unauthenticated"
        case .noRecordingInprocess: return "No Recording In Process"
        case .transcoderNoFound: return "Transcoder Not Found"
        case .videoNotReady: return "Video Not Ready"
        case .noPermission: return "No Permission"
        case .unknown: return "Unknown Error"
        case .otherSdkInstanceRunning: return "Other SDK Instance Running"
        case .internalError: return "Internal Error"
        case .noAudiodeviceIsFound: return "No Audio Device Found"
        case .noVideoDeviceIsFound: return "No Video Device Found"
        case .tooFrequentCall: return "Too Frequent Call"
        case .failAssignUserPrivilege: return "Fail Assign User Privilege"
        case .meetingDontSupportFeature: return "Meeting Doesn't Support Feature"
        case .meetingNotShareSender: return "Not Share Sender"
        case .meetingYouHaveNoShare: return "You Have No Share"
        case .meetingViewtypeParameterIsWrong: return "Wrong View Type Parameter"
        case .meetingAnnotationIsOff: return "Annotation Is Off"
        case .settingOsDontSupport: return "OS Doesn't Support Setting"
        case .emailLoginIsDisabled: return "Email Login Disabled"
        case .hardwareNotMeetForVb: return "Hardware Doesn't Meet VB Requirements"
        case .needUserConfirmRecordDisclaimer: return "Need User Confirmation for Record Disclaimer"
        case .noShareData: return "No Share Data"
        case .shareCannotSubscribeMyself: return "Cannot Subscribe Own Share"
        case .notInMeeting: return "Not In Meeting"
        case .meetingCallOutFailed: return "Meeting Call Out Failed"
        case .notSupportMultiStreamVideoUser: return "Multi-Stream Video User Not Supported"
        case .meetingRemoteControlIsOff: return "Remote Control Is Off"
        case .fileTransferError: return "File Transfer Error"
        @unknown default: return "Unknown"
        }
    }
}

extension MobileRTCMeetError {
    var name: String {
        switch self {
        case .success: return "Success"
        case .networkError: return "Network Error"
        case .reconnectError: return "Reconnect Error"
        case .mmrError: return "MMR Error"
        case .passwordError: return "Password Error"
        case .sessionError: return "Session Error"
        case .meetingOver: return "Meeting Over"
        case .meetingNotStart: return "Meeting Not Started"
        case .meetingNotExist: return "Meeting Not Exist"
        case .meetingUserFull: return "Meeting User Full"
        case .meetingClientIncompatible: return "Client Incompatible"
        case .noMMR: return "No MMR"
        case .meetingLocked: return "Meeting Locked"
        case .meetingRestricted: return "Meeting Restricted"
        case .meetingRestrictedJBH: return "Restricted Join Before Host"
        case .cannotEmitWebRequest: return "Cannot Emit Web Request"
        case .cannotStartTokenExpire: return "Token Expired"
        case .videoError: return "Video Error"
        case .audioAutoStartError: return "Audio Auto Start Error"
        case .registerWebinarFull: return "Webinar Full"
        case .registerWebinarHostRegister: return "Webinar Host Needs Registration"
        case .registerWebinarPanelistRegister: return "Webinar Panelist Needs Registration"
        case .registerWebinarDeniedEmail: return "Webinar Registration Denied"
        case .registerWebinarEnforceLogin: return "Enforce Login for Webinar"
        case .zcCertificateChanged: return "ZC Certificate Changed"
        case .vanityNotExist: return "Vanity URL Not Exist"
        case .joinWebinarWithSameEmail: return "Same Email Already Joined Webinar"
        case .writeConfigFile: return "Write Config File Error"
        case .removedByHost: return "Removed By Host"
        case .hostDisallowOutsideUserJoin: return "Host Disallowed External Users"
        case .unableToJoinExternalMeeting: return "Blocked from External Meeting"
        case .blockedByAccountAdmin: return "Blocked By Account Admin"
        case .needSignInForPrivateMeeting: return "Need Sign-In for Private Meeting"
        case .invalidArguments: return "Invalid Arguments"
        case .invalidUserType: return "Invalid User Type"
        case .inAnotherMeeting: return "In Another Meeting"
        case .tooFrequenceCall: return "Too Frequent Call"
        case .wrongUsage: return "Wrong Usage"
        case .failed: return "Failed"
        case .vbSetError: return "VB Set Error"
        case .vbMaximumNum: return "VB Max Image Limit"
        case .vbSaveImage: return "VB Save Image Error"
        case .vbRemoveNone: return "VB Remove None"
        case .vbNoSupport: return "VB Not Supported"
        case .vbGreenScreenNoSupport: return "Green Screen Not Supported"
        case .appPrivilegeTokenError: return "App Privilege Token Error"
        case .unknown: return "Unknown Error"
        @unknown default: return "Unknown"
        }
    }
}

