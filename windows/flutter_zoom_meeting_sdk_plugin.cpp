#include "flutter_zoom_meeting_sdk_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>
#include <zoom_sdk.h>
#include "auth_service_interface.h"
#include "meeting_service_interface.h"

namespace flutter_zoom_meeting_sdk
{
  flutter::EncodableMap CreateStandardZoomMeetingResponse(bool success, std::string message, uint32_t statusCode, std::string statusText)
  {
    flutter::EncodableMap response;
    response[flutter::EncodableValue("success")] = flutter::EncodableValue(success);
    response[flutter::EncodableValue("message")] = flutter::EncodableValue(message);
    response[flutter::EncodableValue("statusCode")] = flutter::EncodableValue(statusCode);
    response[flutter::EncodableValue("statusText")] = flutter::EncodableValue(statusText);
    return response;
  }

  // static
  void FlutterZoomMeetingSdkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "flutter_zoom_meeting_sdk",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<FlutterZoomMeetingSdkPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  FlutterZoomMeetingSdkPlugin::FlutterZoomMeetingSdkPlugin() {}

  FlutterZoomMeetingSdkPlugin::~FlutterZoomMeetingSdkPlugin() {}

  void FlutterZoomMeetingSdkPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("initZoom") == 0)
    {

      ZOOM_SDK_NAMESPACE::InitParam initParam;
      initParam.strWebDomain = L"https://zoom.us";

      auto initResult = ZOOM_SDK_NAMESPACE::InitSDK(initParam);
      if (initResult == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
      {
        result->Success(CreateStandardZoomMeetingResponse(
            true,
            "Initialized successfully 222333",
            0,
            "SDKERR_SUCCESS"));
      }
      else
      {

        result->Success(CreateStandardZoomMeetingResponse(
            true,
            "Initialized successfully 333444",
            0,
            "SDKERR_SUCCESS"));
      }
    }
    else if (method_call.method_name().compare("authZoom") == 0)
    {
      const auto *args = std::get_if<flutter::EncodableMap>(method_call.arguments());
      if (args)
      {
        auto jwt_iter = args->find(flutter::EncodableValue("jwtToken"));
        if (jwt_iter != args->end())
        {

          const auto &jwt_value = jwt_iter->second;
          std::string jwt_token = std::get<std::string>(jwt_value);
          result->Success(CreateStandardZoomMeetingResponse(
              true,
              jwt_token,
              0,
              "SDKERR_SUCCESS"));
        }
      }
    }
    else
    {
      result->NotImplemented();
    }
  }

  void FlutterZoomMeetingSdkPlugin::onAuthenticationReturn(ZOOM_SDK_NAMESPACE::AuthResult ret)
  {
    std::wcout << L"onAuthenticationReturn called with result: " << ret << std::endl;
    if (ret == ZOOM_SDK_NAMESPACE::AuthResult::AUTHRET_SUCCESS)
    {
      std::wcout << L"Authentication successful" << std::endl;
    }
    else
    {
      std::wcout << L"Authentication failed: " << ret << std::endl;
    }
  }

  // Other event handlers
  void FlutterZoomMeetingSdkPlugin::onLoginReturn(ZOOM_SDK_NAMESPACE::LOGINSTATUS status)
  {
    std::wcout << L"onLoginReturn called with status: " << status << std::endl;
  }
  void FlutterZoomMeetingSdkPlugin::onLogout()
  {
    std::wcout << L"onLogout called" << std::endl;
  }
  void FlutterZoomMeetingSdkPlugin::onZoomIdentityExpired()
  {
    std::wcout << L"onZoomIdentityExpired called" << std::endl;
  }
  void FlutterZoomMeetingSdkPlugin::onZoomAuthIdentityExpired()
  {
    std::wcout << L"onZoomAuthIdentityExpired called" << std::endl;
  }
  void FlutterZoomMeetingSdkPlugin::onLoginReturnWithReason(ZOOM_SDK_NAMESPACE::LOGINSTATUS status, ZOOM_SDK_NAMESPACE::IAccountInfo *pAccountInfo, ZOOM_SDK_NAMESPACE::LoginFailReason reason)
  {
    std::wcout << L"onLoginReturnWithReason called with status: " << status << L", reason: " << reason << std::endl;
  }
  void FlutterZoomMeetingSdkPlugin::onSSOLoginURINotification(const wchar_t *uri)
  {
    std::wcout << L"onSSOLoginURINotification called with URI: " << (uri ? uri : L"null") << std::endl;
  }
  void FlutterZoomMeetingSdkPlugin::onNotificationServiceStatus(ZOOM_SDK_NAMESPACE::SDKNotificationServiceStatus status, ZOOM_SDK_NAMESPACE::SDKNotificationServiceError error)
  {
    std::wcout << L"onNotificationServiceStatus called with status: " << status << L", error: " << error << std::endl;
  }

} // namespace flutter_zoom_meeting_sdk
