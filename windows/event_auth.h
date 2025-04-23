#pragma once

#include <windows.h>
#include <flutter/encodable_value.h>
#include "auth_service_interface.h"
#include "meeting_service_interface.h"

// Forward declaration of the ZoomEventStreamHandler class
class ZoomEventStreamHandler;

class ZoomSDKAuthServiceEventListener : public ZOOM_SDK_NAMESPACE::IAuthServiceEvent
{
public:
    ZoomSDKAuthServiceEventListener();
    virtual ~ZoomSDKAuthServiceEventListener();

    void SetEventHandler(ZoomEventStreamHandler *handler);

    void onAuthenticationReturn(ZOOM_SDK_NAMESPACE::AuthResult ret) override;
    void onLoginReturnWithReason(ZOOM_SDK_NAMESPACE::LOGINSTATUS ret,
                                 ZOOM_SDK_NAMESPACE::IAccountInfo *pAccountInfo,
                                 ZOOM_SDK_NAMESPACE::LoginFailReason reason) override;
    void onLogout() override;
    void onZoomIdentityExpired() override;
    void onZoomAuthIdentityExpired() override;

#if defined(WIN32)
    void onNotificationServiceStatus(ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus status,
                                     ZOOM_SDK_NAMESPACE::SDKNotificationServiceError error) override;
#endif

private:
    void SendAuthEvent(const std::string &eventName, const flutter::EncodableMap &params);
    ZoomEventStreamHandler *event_handler_;
};
