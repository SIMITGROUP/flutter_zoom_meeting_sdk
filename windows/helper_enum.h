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