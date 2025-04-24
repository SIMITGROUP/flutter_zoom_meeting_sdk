#pragma once

#include <windows.h>
#include <string>
#include <unordered_map>
#include "auth_service_interface.h"

// Generalized function for mapping enums to strings
template <typename EnumType>
inline std::string ConvertEnumToString(EnumType result, const std::unordered_map<EnumType, std::string> &names)
{
    auto it = names.find(result);
    return it != names.end() ? it->second : "UNKNOWN";
}

// Auth Service
inline std::string EnumToString(ZOOM_SDK_NAMESPACE::AuthResult result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::AuthResult, std::string> names = {
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_SUCCESS, "SUCCESS"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_KEYORSECRETEMPTY, "KEYORSECRETEMPTY"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_KEYORSECRETWRONG, "KEYORSECRETWRONG"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_ACCOUNTNOTSUPPORT, "ACCOUNTNOTSUPPORT"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_ACCOUNTNOTENABLESDK, "ACCOUNTNOTENABLESDK"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_UNKNOWN, "UNKNOWN"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_SERVICE_BUSY, "SERVICE_BUSY"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_NONE, "NONE"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_OVERTIME, "OVERTIME"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_NETWORKISSUE, "NETWORKISSUE"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_CLIENT_INCOMPATIBLE, "CLIENT_INCOMPATIBLE"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_JWTTOKENWRONG, "JWTTOKENWRONG"},
        {ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_LIMIT_EXCEEDED_EXCEPTION, "LIMIT_EXCEEDED_EXCEPTION"},
    };

    return ConvertEnumToString(result, names);
}

inline std::string EnumToString(ZOOM_SDK_NAMESPACE::LOGINSTATUS result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::LOGINSTATUS, std::string> names = {
        {ZOOM_SDK_NAMESPACE::LOGINSTATUS::LOGIN_IDLE, "IDLE"},
        {ZOOM_SDK_NAMESPACE::LOGINSTATUS::LOGIN_PROCESSING, "PROCESSING"},
        {ZOOM_SDK_NAMESPACE::LOGINSTATUS::LOGIN_SUCCESS, "SUCCESS"},
        {ZOOM_SDK_NAMESPACE::LOGINSTATUS::LOGIN_FAILED, "FAILED"},
    };

    return ConvertEnumToString(result, names);
}

inline std::string EnumToString(ZOOM_SDK_NAMESPACE::LoginFailReason result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::LoginFailReason, std::string> names = {
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_None, "None"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_EmailLoginDisable, "EmailLoginDisable"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_UserNotExist, "UserNotExist"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_WrongPassword, "WrongPassword"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_AccountLocked, "AccountLocked"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_SDKNeedUpdate, "SDKNeedUpdate"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_TooManyFailedAttempts, "TooManyFailedAttempts"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_SMSCodeError, "SMSCodeError"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_SMSCodeExpired, "SMSCodeExpired"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_PhoneNumberFormatInValid, "PhoneNumberFormatInValid"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_LoginTokenInvalid, "LoginTokenInvalid"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_UserDisagreeLoginDisclaimer, "UserDisagreeLoginDisclaimer"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_Mfa_Required, "Mfa_Required"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_Need_Bitrthday_ask, "Need_Bitrthday_ask"},
        {ZOOM_SDK_NAMESPACE::LoginFailReason::LoginFail_OtherIssue, "OtherIssue"},
    };

    return ConvertEnumToString(result, names);
}

inline std::string EnumToString(ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus, std::string> names = {
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus::SDK_Notification_Service_None, "None"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus::SDK_Notification_Service_Starting, "Starting"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus::SDK_Notification_Service_Started, "Started"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus::SDK_Notification_Service_StartFailed, "StartFailed"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus::SDK_Notification_Service_Closed, "Closed"},
    };

    return ConvertEnumToString(result, names);
}

inline std::string EnumToString(ZOOM_SDK_NAMESPACE::SDKNotificationServiceError result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::SDKNotificationServiceError, std::string> names = {
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceError::SDK_Notification_Service_Error_Success, "Success"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceError::SDK_Notification_Service_Error_Unknown, "Unknown"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceError::SDK_Notification_Service_Error_Internal_Error, "Internal_Error"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceError::SDK_Notification_Service_Error_Invalid_Token, "Invalid_Token"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceError::SDK_Notification_Service_Error_Multi_Connect, "Multi_Connect"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceError::SDK_Notification_Service_Error_Network_Issue, "Network_Issue"},
        {ZOOM_SDK_NAMESPACE::SDKNotificationServiceError::SDK_Notification_Service_Error_Max_Duration, "Max_Duration"},
    };

    return ConvertEnumToString(result, names);
}

inline std::string EnumToString(ZOOM_SDK_NAMESPACE::LoginType result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::LoginType, std::string> names = {
        {ZOOM_SDK_NAMESPACE::LoginType::LoginType_Unknown, "Unknown"},
        {ZOOM_SDK_NAMESPACE::LoginType::LoginType_SSO, "SSO"},
    };

    return ConvertEnumToString(result, names);
}

// Meeting Service
inline std::string EnumToString(ZOOM_SDK_NAMESPACE::MeetingStatus result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::MeetingStatus, std::string> names = {
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_IDLE, "IDLE"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_CONNECTING, "CONNECTING"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_WAITINGFORHOST, "WAITINGFORHOST"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_INMEETING, "INMEETING"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_DISCONNECTING, "DISCONNECTING"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_RECONNECTING, "RECONNECTING"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_FAILED, "FAILED"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_ENDED, "ENDED"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_UNKNOWN, "UNKNOWN"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_LOCKED, "LOCKED"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_UNLOCKED, "UNLOCKED"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_IN_WAITING_ROOM, "IN_WAITING_ROOM"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_WEBINAR_PROMOTE, "WEBINAR_PROMOTE"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_WEBINAR_DEPROMOTE, "WEBINAR_DEPROMOTE"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_JOIN_BREAKOUT_ROOM, "JOIN_BREAKOUT_ROOM"},
        {ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_LEAVE_BREAKOUT_ROOM, "LEAVE_BREAKOUT_ROOM"},
    };

    return ConvertEnumToString(result, names);
}

inline std::string EnumToString(ZOOM_SDK_NAMESPACE::MeetingFailCode result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::MeetingFailCode, std::string> names = {
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_SUCCESS, "MEETING_SUCCESS"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_NETWORK_ERR, "MEETING_FAIL_NETWORK_ERR"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_RECONNECT_ERR, "MEETING_FAIL_RECONNECT_ERR"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_MMR_ERR, "MEETING_FAIL_MMR_ERR"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_PASSWORD_ERR, "MEETING_FAIL_PASSWORD_ERR"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_SESSION_ERR, "MEETING_FAIL_SESSION_ERR"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_MEETING_OVER, "MEETING_FAIL_MEETING_OVER"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_MEETING_NOT_START, "MEETING_FAIL_MEETING_NOT_START"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_MEETING_NOT_EXIST, "MEETING_FAIL_MEETING_NOT_EXIST"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_MEETING_USER_FULL, "MEETING_FAIL_MEETING_USER_FULL"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_CLIENT_INCOMPATIBLE, "MEETING_FAIL_CLIENT_INCOMPATIBLE"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_NO_MMR, "MEETING_FAIL_NO_MMR"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_CONFLOCKED, "MEETING_FAIL_CONFLOCKED"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_MEETING_RESTRICTED, "MEETING_FAIL_MEETING_RESTRICTED"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_MEETING_RESTRICTED_JBH, "MEETING_FAIL_MEETING_RESTRICTED_JBH"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_CANNOT_EMIT_WEBREQUEST, "MEETING_FAIL_CANNOT_EMIT_WEBREQUEST"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_CANNOT_START_TOKENEXPIRE, "MEETING_FAIL_CANNOT_START_TOKENEXPIRE"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::SESSION_VIDEO_ERR, "SESSION_VIDEO_ERR"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::SESSION_AUDIO_AUTOSTARTERR, "SESSION_AUDIO_AUTOSTARTERR"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_REGISTERWEBINAR_FULL, "MEETING_FAIL_REGISTERWEBINAR_FULL"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_REGISTERWEBINAR_HOSTREGISTER, "MEETING_FAIL_REGISTERWEBINAR_HOSTREGISTER"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_REGISTERWEBINAR_PANELISTREGISTER, "MEETING_FAIL_REGISTERWEBINAR_PANELISTREGISTER"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_REGISTERWEBINAR_DENIED_EMAIL, "MEETING_FAIL_REGISTERWEBINAR_DENIED_EMAIL"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_ENFORCE_LOGIN, "MEETING_FAIL_ENFORCE_LOGIN"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::CONF_FAIL_ZC_CERTIFICATE_CHANGED, "CONF_FAIL_ZC_CERTIFICATE_CHANGED"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::CONF_FAIL_VANITY_NOT_EXIST, "CONF_FAIL_VANITY_NOT_EXIST"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::CONF_FAIL_JOIN_WEBINAR_WITHSAMEEMAIL, "CONF_FAIL_JOIN_WEBINAR_WITHSAMEEMAIL"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::CONF_FAIL_DISALLOW_HOST_MEETING, "CONF_FAIL_DISALLOW_HOST_MEETING"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_WRITE_CONFIG_FILE, "MEETING_FAIL_WRITE_CONFIG_FILE"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_FORBID_TO_JOIN_INTERNAL_MEETING, "MEETING_FAIL_FORBID_TO_JOIN_INTERNAL_MEETING"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::CONF_FAIL_REMOVED_BY_HOST, "CONF_FAIL_REMOVED_BY_HOST"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_HOST_DISALLOW_OUTSIDE_USER_JOIN, "MEETING_FAIL_HOST_DISALLOW_OUTSIDE_USER_JOIN"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_UNABLE_TO_JOIN_EXTERNAL_MEETING, "MEETING_FAIL_UNABLE_TO_JOIN_EXTERNAL_MEETING"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_BLOCKED_BY_ACCOUNT_ADMIN, "MEETING_FAIL_BLOCKED_BY_ACCOUNT_ADMIN"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_NEED_SIGN_IN_FOR_PRIVATE_MEETING, "MEETING_FAIL_NEED_SIGN_IN_FOR_PRIVATE_MEETING"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_APP_PRIVILEGE_TOKEN_ERROR, "MEETING_FAIL_APP_PRIVILEGE_TOKEN_ERROR"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_JMAK_USER_EMAIL_NOT_MATCH, "MEETING_FAIL_JMAK_USER_EMAIL_NOT_MATCH"},
        {ZOOM_SDK_NAMESPACE::MeetingFailCode::MEETING_FAIL_UNKNOWN, "MEETING_FAIL_UNKNOWN"},
    };

    return ConvertEnumToString(result, names);
}

inline std::string EnumToString(ZOOM_SDK_NAMESPACE::MeetingEndReason result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::MeetingEndReason, std::string> names = {
        {ZOOM_SDK_NAMESPACE::MeetingEndReason::EndMeetingReason_None, "None"},
        {ZOOM_SDK_NAMESPACE::MeetingEndReason::EndMeetingReason_KickByHost, "KickByHost"},
        {ZOOM_SDK_NAMESPACE::MeetingEndReason::EndMeetingReason_EndByHost, "EndByHost"},
        {ZOOM_SDK_NAMESPACE::MeetingEndReason::EndMeetingReason_JBHTimeOut, "JBHTimeOut"},
        {ZOOM_SDK_NAMESPACE::MeetingEndReason::EndMeetingReason_NoAttendee, "NoAttendee"},
        {ZOOM_SDK_NAMESPACE::MeetingEndReason::EndMeetingReason_HostStartAnotherMeeting, "HostStartAnotherMeeting"},
        {ZOOM_SDK_NAMESPACE::MeetingEndReason::EndMeetingReason_FreeMeetingTimeOut, "FreeMeetingTimeOut"},
        {ZOOM_SDK_NAMESPACE::MeetingEndReason::EndMeetingReason_NetworkBroken, "NetworkBroken"},
    };

    return ConvertEnumToString(result, names);
}

inline std::string EnumToString(ZOOM_SDK_NAMESPACE::StatisticsWarningType result)
{
    static const std::unordered_map<ZOOM_SDK_NAMESPACE::StatisticsWarningType, std::string> names = {
        {ZOOM_SDK_NAMESPACE::StatisticsWarningType::Statistics_Warning_None, "None"},
        {ZOOM_SDK_NAMESPACE::StatisticsWarningType::Statistics_Warning_Network_Quality_Bad, "Network_Quality_Bad"},
        {ZOOM_SDK_NAMESPACE::StatisticsWarningType::Statistics_Warning_Busy_System, "Busy_System"},
    };

    return ConvertEnumToString(result, names);
}