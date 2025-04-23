#include "event_auth.h"
#include <iostream>
#include "zoom_event_stream_handler.h"

ZoomSDKAuthServiceEventListener::ZoomSDKAuthServiceEventListener() : event_handler_(nullptr) {}
ZoomSDKAuthServiceEventListener::~ZoomSDKAuthServiceEventListener() {}

void ZoomSDKAuthServiceEventListener::SetEventHandler(ZoomEventStreamHandler *handler)
{
    event_handler_ = handler;
}

void ZoomSDKAuthServiceEventListener::SendAuthEvent(const std::string &eventName, const flutter::EncodableMap &params)
{
    if (!event_handler_)
    {
        std::cout << "ERROR: Event handler is NULL, cannot send " << eventName << " event!" << std::endl;
        return;
    }

    std::cout << "Sending event: " << eventName << std::endl;

    flutter::EncodableMap eventMap;
    eventMap[flutter::EncodableValue("platform")] = flutter::EncodableValue("windows");
    eventMap[flutter::EncodableValue("event")] = flutter::EncodableValue(eventName);
    eventMap[flutter::EncodableValue("oriEvent")] = flutter::EncodableValue(eventName);
    eventMap[flutter::EncodableValue("params")] = flutter::EncodableValue(params);

    event_handler_->SendEvent(flutter::EncodableValue(eventMap));
}

void ZoomSDKAuthServiceEventListener::onAuthenticationReturn(ZOOM_SDK_NAMESPACE::AuthResult ret)
{
    std::wcout << L"Authentication result: " << ret << std::endl;

    // Create the parameters map for the event
    flutter::EncodableMap params;
    params[flutter::EncodableValue("result")] = flutter::EncodableValue(static_cast<int>(ret));

    // Add a readable status message
    std::string status_message = "Unknown";
    if (ret == ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_SUCCESS)
    {
        status_message = "Authentication successful";
    }
    else if (ret == ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_KEYORSECRETWRONG)
    {
        status_message = "SDK key or secret is wrong";
    }
    else if (ret == ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_ACCOUNTNOTSUPPORT)
    {
        status_message = "Account does not support";
    }
    else if (ret == ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_ACCOUNTNOTENABLESDK)
    {
        status_message = "Account does not enable SDK";
    }
    else if (ret == ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_UNKNOWN)
    {
        status_message = "Unknown error";
    }
    params[flutter::EncodableValue("message")] = flutter::EncodableValue(status_message);

    // Print the event being sent for debugging
    std::cout << "Sending onAuthenticationReturn with result code: " << static_cast<int>(ret) << std::endl;

    // Send the event to Flutter
    SendAuthEvent("onAuthenticationReturn", params);

    if (ret == ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_SUCCESS)
    {
        std::wcout << L"Authentication successful" << std::endl;
    }
    else
    {
        std::wcout << L"Authentication failed" << std::endl;
    }
}

void ZoomSDKAuthServiceEventListener::onLoginReturnWithReason(ZOOM_SDK_NAMESPACE::LOGINSTATUS ret,
                                                              ZOOM_SDK_NAMESPACE::IAccountInfo *pAccountInfo,
                                                              ZOOM_SDK_NAMESPACE::LoginFailReason reason)
{
    std::wcout << L"Login status: " << ret << L", reason: " << reason << std::endl;

    flutter::EncodableMap params;
    params[flutter::EncodableValue("status")] = flutter::EncodableValue(static_cast<int>(ret));
    params[flutter::EncodableValue("reason")] = flutter::EncodableValue(static_cast<int>(reason));

    SendAuthEvent("onLoginReturnWithReason", params);
}

void ZoomSDKAuthServiceEventListener::onLogout()
{
    std::wcout << L"Logout" << std::endl;

    flutter::EncodableMap params;
    SendAuthEvent("onLogout", params);
}

void ZoomSDKAuthServiceEventListener::onZoomIdentityExpired()
{
    std::wcout << L"Zoom Identity Expired" << std::endl;

    flutter::EncodableMap params;
    SendAuthEvent("onZoomIdentityExpired", params);
}

void ZoomSDKAuthServiceEventListener::onZoomAuthIdentityExpired()
{
    std::wcout << L"Zoom Auth Identity Expired" << std::endl;

    flutter::EncodableMap params;
    SendAuthEvent("onZoomAuthIdentityExpired", params);
}

#if defined(WIN32)
void ZoomSDKAuthServiceEventListener::onNotificationServiceStatus(ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus status,
                                                                  ZOOM_SDK_NAMESPACE::SDKNotificationServiceError error)
{
    std::wcout << L"Notification service status: " << status << L", error: " << error << std::endl;

    flutter::EncodableMap params;
    params[flutter::EncodableValue("status")] = flutter::EncodableValue(static_cast<int>(status));
    params[flutter::EncodableValue("error")] = flutter::EncodableValue(static_cast<int>(error));

    SendAuthEvent("onNotificationServiceStatus", params);
}
#endif
