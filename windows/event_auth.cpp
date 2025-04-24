#include "event_auth.h"
#include <iostream>
#include "zoom_event_stream_handler.h"
#include "helper_enum.h"
#include "helper.h"

ZoomSDKAuthServiceEventListener::ZoomSDKAuthServiceEventListener() : event_handler_(nullptr) {}
ZoomSDKAuthServiceEventListener::~ZoomSDKAuthServiceEventListener() {}

void ZoomSDKAuthServiceEventListener::SetEventHandler(ZoomEventStreamHandler *handler)
{
    event_handler_ = handler;
}

void ZoomSDKAuthServiceEventListener::SendAuthEvent(const std::string &eventName, const flutter::EncodableMap &params)
{
    const std::string tag = "SendAuthEventToFlutter";

    if (!event_handler_)
    {
        sLog(tag, "=== ERROR: Event handler is NULL, cannot send: " + eventName + " event ===");
        return;
    }

    sLog(tag, "=== Sending event: " + eventName + " ===");

    flutter::EncodableMap eventMap;
    eventMap[flutter::EncodableValue("platform")] = flutter::EncodableValue("windows");
    eventMap[flutter::EncodableValue("event")] = flutter::EncodableValue(eventName);
    eventMap[flutter::EncodableValue("oriEvent")] = flutter::EncodableValue(eventName);
    eventMap[flutter::EncodableValue("params")] = flutter::EncodableValue(params);

    event_handler_->SendEvent(flutter::EncodableValue(eventMap));
}

void ZoomSDKAuthServiceEventListener::onAuthenticationReturn(ZOOM_SDK_NAMESPACE::AuthResult ret)
{
    const std::string tag = "onAuthenticationReturn";
    sLog(tag, L"Authentication result: " + std::to_wstring(ret));

    if (ret == ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_SUCCESS)
    {
        sLog(tag, L"Authentication successful");
    }
    else
    {
        sLog(tag, L"Authentication failed");
    }

    flutter::EncodableMap params;

    params[flutter::EncodableValue("status")] = flutter::EncodableValue(static_cast<int>(ret));
    params[flutter::EncodableValue("statusName")] = flutter::EncodableValue(EnumToString(ret));

    SendAuthEvent(tag, params);
}

void ZoomSDKAuthServiceEventListener::onLoginReturnWithReason(ZOOM_SDK_NAMESPACE::LOGINSTATUS ret,
                                                              ZOOM_SDK_NAMESPACE::IAccountInfo *pAccountInfo,
                                                              ZOOM_SDK_NAMESPACE::LoginFailReason reason)
{
    const std::string tag = "onLoginReturnWithReason";
    sLog(tag, L"Login status: " + std::to_wstring(ret));
    sLog(tag, L"Login Fail Reason: " + std::to_wstring(reason));

    flutter::EncodableMap params;
    params[flutter::EncodableValue("status")] = flutter::EncodableValue(static_cast<int>(ret));
    params[flutter::EncodableValue("statusName")] = flutter::EncodableValue(EnumToString(ret));
    params[flutter::EncodableValue("failReason")] = flutter::EncodableValue(static_cast<int>(reason));
    params[flutter::EncodableValue("failReasonName")] = flutter::EncodableValue(EnumToString(reason));

    flutter::EncodableMap accountInfo;

    if (pAccountInfo)
    {
        const ZOOMSDK::LoginType loginType = pAccountInfo->GetLoginType();
        std::wstring wDisplayName = pAccountInfo->GetDisplayName();
        std::string displayName = WStringToString(wDisplayName);

        accountInfo[flutter::EncodableValue("loginType")] = flutter::EncodableValue(static_cast<int>(loginType));
        accountInfo[flutter::EncodableValue("loginTypeName")] = flutter::EncodableValue(EnumToString(loginType));
        accountInfo[flutter::EncodableValue("displayName")] = flutter::EncodableValue(displayName);
    }

    params[flutter::EncodableValue("accountInfo")] = flutter::EncodableValue(accountInfo);

    SendAuthEvent(tag, params);
}

void ZoomSDKAuthServiceEventListener::onLogout()
{
    const std::string tag = "onLogout";
    sLog(tag, L"");

    flutter::EncodableMap params;
    SendAuthEvent(tag, params);
}

void ZoomSDKAuthServiceEventListener::onZoomIdentityExpired()
{
    const std::string tag = "onZoomIdentityExpired";
    sLog(tag, L"");

    flutter::EncodableMap params;
    SendAuthEvent(tag, params);
}

void ZoomSDKAuthServiceEventListener::onZoomAuthIdentityExpired()
{
    const std::string tag = "onZoomAuthIdentityExpired";
    sLog(tag, L"");

    flutter::EncodableMap params;
    SendAuthEvent(tag, params);
}

#if defined(WIN32)
void ZoomSDKAuthServiceEventListener::onNotificationServiceStatus(ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus status,
                                                                  ZOOM_SDK_NAMESPACE::SDKNotificationServiceError error)
{
    const std::string tag = "onNotificationServiceStatus";
    sLog(tag, L"Status: " + std::to_wstring(status));
    sLog(tag, L"Error: " + std::to_wstring(error));

    flutter::EncodableMap params;
    params[flutter::EncodableValue("status")] = flutter::EncodableValue(static_cast<int>(status));
    params[flutter::EncodableValue("statusName")] = flutter::EncodableValue(EnumToString(status));
    params[flutter::EncodableValue("error")] = flutter::EncodableValue(static_cast<int>(error));
    params[flutter::EncodableValue("errorName")] = flutter::EncodableValue(EnumToString(error));

    SendAuthEvent(tag, params);
}
#endif
