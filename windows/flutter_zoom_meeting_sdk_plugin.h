#ifndef FLUTTER_PLUGIN_FLUTTER_ZOOM_MEETING_SDK_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_ZOOM_MEETING_SDK_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>
#include "zoom_sdk.h"
#include "auth_service_interface.h"
#include "meeting_service_interface.h"

namespace flutter_zoom_meeting_sdk
{

    class FlutterZoomMeetingSdkPlugin : public flutter::Plugin, public ZOOM_SDK_NAMESPACE::IAuthServiceEvent
    {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        FlutterZoomMeetingSdkPlugin();

        virtual ~FlutterZoomMeetingSdkPlugin();

        // IAuthServiceEvent overrides
        void onAuthenticationReturn(ZOOM_SDK_NAMESPACE::AuthResult ret) override;
        void onLoginReturn(ZOOM_SDK_NAMESPACE::LOGINSTATUS status);
        void onLogout() override;
        void onZoomIdentityExpired() override;
        void onZoomAuthIdentityExpired() override;
        void onLoginReturnWithReason(ZOOM_SDK_NAMESPACE::LOGINSTATUS status, ZOOM_SDK_NAMESPACE::IAccountInfo *pAccountInfo, ZOOM_SDK_NAMESPACE::LoginFailReason reason) override;
        void onSSOLoginURINotification(const wchar_t *uri);
        void onNotificationServiceStatus(ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus status, ZOOM_SDK_NAMESPACE::SDKNotificationServiceError error) override;

        // Disallow copy and assign.
        FlutterZoomMeetingSdkPlugin(const FlutterZoomMeetingSdkPlugin &) = delete;
        FlutterZoomMeetingSdkPlugin &operator=(const FlutterZoomMeetingSdkPlugin &) = delete;

        // Called when a method is called on this plugin's channel from Dart.
        void HandleMethodCall(
            const flutter::MethodCall<flutter::EncodableValue> &method_call,
            std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
    };

} // namespace flutter_zoom_meeting_sdk

#endif // FLUTTER_PLUGIN_FLUTTER_ZOOM_MEETING_SDK_PLUGIN_H_
