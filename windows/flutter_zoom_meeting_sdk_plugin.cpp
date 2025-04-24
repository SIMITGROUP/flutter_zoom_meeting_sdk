#include "flutter_zoom_meeting_sdk_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <flutter/event_channel.h>

#include <memory>
#include <sstream>
#include <zoom_sdk.h>
#include "auth_service_interface.h"
#include "meeting_service_interface.h"
#include "arg_reader.h"
#include "zoom_event_listener_auth_service.h"
#include "zoom_event_stream_handler.h"
#include "zoom_event_listener_meeting_service.h"
#include "zoom_event_manager.h"
#include "helper.h"
#include "helper_enum.h"
#include "zoom_response_builder.h"

namespace flutter_zoom_meeting_sdk
{
  namespace
  {
    bool sdkInitialized = false;

    std::unique_ptr<ZoomSDKEventListenerAuthService> authListener;
    std::unique_ptr<ZoomSDKEventListenerMeetingService> meetingListener;
  }

  // static
  void FlutterZoomMeetingSdkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "flutter_zoom_meeting_sdk",
            &flutter::StandardMethodCodec::GetInstance());

    auto event_channel = std::make_unique<flutter::EventChannel<flutter::EncodableValue>>(
        registrar->messenger(),
        "flutter_zoom_meeting_sdk/events",
        &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<FlutterZoomMeetingSdkPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    // Create the event handler
    auto handler = std::make_unique<ZoomEventStreamHandler>();
    ZoomEventManager::GetInstance().SetEventHandler(handler.get());

    // Set the stream handler
    event_channel->SetStreamHandler(std::move(handler));

    registrar->AddPlugin(std::move(plugin));
  }

  FlutterZoomMeetingSdkPlugin::FlutterZoomMeetingSdkPlugin() {}

  FlutterZoomMeetingSdkPlugin::~FlutterZoomMeetingSdkPlugin()
  {
    ZoomEventManager::GetInstance().SetEventHandler(nullptr);
    authListener.reset();
    meetingListener.reset();
  }

  void FlutterZoomMeetingSdkPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("initZoom") == 0)
    {
      ZoomResponse response = InitZoom();
      result->Success(flutter::EncodableValue(response.ToEncodableMap()));
    }
    else if (method_call.method_name().compare("authZoom") == 0)
    {
      ArgReader reader(method_call);
      auto token = reader.GetString("jwtToken").value_or("");

      ZoomResponse response = AuthZoom(token);
      result->Success(flutter::EncodableValue(response.ToEncodableMap()));
    }
    else if (method_call.method_name().compare("joinMeeting") == 0)
    {
      ArgReader reader(method_call);

      auto meetingNumber = reader.GetUINT64("meetingNumber").value_or(0);
      auto password = reader.GetWString("password").value_or(L"");
      auto displayName = reader.GetWString("displayName").value_or(L"Zoom User");

      ZoomResponse response = JoinMeeting(meetingNumber, password, displayName);
      result->Success(flutter::EncodableValue(response.ToEncodableMap()));
    }
    else
    {
      result->NotImplemented();
    }
  }

  ZoomResponse InitZoom()
  {
    std::string tag = "initZoom";

    if (sdkInitialized)
    {
      return ZoomResponseBuilder(tag)
          .Success(true)
          .Message("Zoom SDK already initialized.")
          .Build();
    }

    ZOOM_SDK_NAMESPACE::InitParam initParam;
    initParam.strWebDomain = L"https://zoom.us";

    auto initResult = ZOOM_SDK_NAMESPACE::InitSDK(initParam);
    if (initResult == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
    {
      return ZoomResponseBuilder(tag)
          .Success(true)
          .Message("Initialization successfully.")
          .Param("status", static_cast<int>(initResult))
          .Param("statusName", EnumToString(initResult))
          .Build();
    }

    return ZoomResponseBuilder(tag)
        .Success(false)
        .Message("Initialization failed")
        .Param("status", static_cast<int>(initResult))
        .Param("statusName", EnumToString(initResult))
        .Build();
  }

  ZoomResponse AuthZoom(std::string token)
  {
    std::string tag = "authZoom";

    ZOOM_SDK_NAMESPACE::IAuthService *authService;
    ZOOM_SDK_NAMESPACE::SDKError authServiceInitReturnVal = ZOOM_SDK_NAMESPACE::CreateAuthService(&authService);
    if (authServiceInitReturnVal != ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
    {
      return ZoomResponseBuilder(tag)
          .Success(false)
          .Message("Failed to create auth service")
          .Param("status", static_cast<int>(authServiceInitReturnVal))
          .Param("statusName", EnumToString(authServiceInitReturnVal))
          .Build();
    }

    auto handler = ZoomEventManager::GetInstance().GetEventHandler();
    if (!handler)
    {
      return ZoomResponseBuilder(tag)
          .Success(false)
          .Message("Missing ZoomEventManager handler")
          .Build();
    }

    authListener = std::make_unique<ZoomSDKEventListenerAuthService>();
    authListener->SetEventHandler(handler);
    authService->SetEvent(authListener.get());

    std::wstring wide_token(token.begin(), token.end());

    ZOOM_SDK_NAMESPACE::SDKError authCallReturnValue(ZOOM_SDK_NAMESPACE::SDKERR_UNAUTHENTICATION);
    ZOOM_SDK_NAMESPACE::AuthContext authContext;
    authContext.jwt_token = wide_token.c_str();

    authCallReturnValue = authService->SDKAuth(authContext);

    if (authCallReturnValue == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
    {
      return ZoomResponseBuilder(tag)
          .Success(true)
          .Message("Authentication call succeeded, listen onAuthenticationReturn for further action.")
          .Param("status", static_cast<int>(authCallReturnValue))
          .Param("statusName", EnumToString(authCallReturnValue))
          .Build();
    }

    return ZoomResponseBuilder(tag)
        .Success(false)
        .Message("SDK Authentication failed")
        .Param("status", static_cast<int>(authCallReturnValue))
        .Param("statusName", EnumToString(authCallReturnValue))
        .Build();
  }

  ZoomResponse JoinMeeting(uint64_t meetingNumber, std::wstring password, std::wstring displayName)
  {
    std::string tag = "joinMeeting";

    ZOOM_SDK_NAMESPACE::IMeetingService *meetingService;
    ZOOM_SDK_NAMESPACE::SDKError meetingServiceInitReturnVal = ZOOM_SDK_NAMESPACE::CreateMeetingService(&meetingService);

    if (meetingServiceInitReturnVal != ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
    {
      return ZoomResponseBuilder(tag)
          .Success(false)
          .Message("Failed to create meeting service")
          .Param("status", static_cast<int>(meetingServiceInitReturnVal))
          .Param("statusName", EnumToString(meetingServiceInitReturnVal))
          .Build();
    }

    ZOOM_SDK_NAMESPACE::JoinParam joinParam;
    joinParam.userType = ZOOM_SDK_NAMESPACE::SDK_UT_NORMALUSER;
    auto &normalParam = joinParam.param.normaluserJoin;
    normalParam.meetingNumber = meetingNumber;
    normalParam.userName = displayName.c_str();
    normalParam.psw = password.c_str();
    normalParam.isVideoOff = false;
    normalParam.isAudioOff = false;

    auto handler = ZoomEventManager::GetInstance().GetEventHandler();
    if (!handler)
    {
      return ZoomResponseBuilder(tag)
          .Success(false)
          .Message("Missing ZoomEventManager handler")
          .Build();
    }

    meetingListener = std::make_unique<ZoomSDKEventListenerMeetingService>();
    meetingListener->SetEventHandler(handler);
    meetingService->SetEvent(meetingListener.get());

    auto joinResult = meetingService->Join(joinParam);
    if (joinResult == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
    {
      return ZoomResponseBuilder(tag)
          .Success(true)
          .Message("Join meeting call succeeded, listen for join meeting result using the onMeetingStatusChanged callback")
          .Param("status", static_cast<int>(joinResult))
          .Param("statusName", EnumToString(joinResult))
          .Build();
    }

    return ZoomResponseBuilder(tag)
        .Success(false)
        .Message("Join meeting call failed")
        .Param("status", static_cast<int>(joinResult))
        .Param("statusName", EnumToString(joinResult))
        .Build();
  }

} // namespace flutter_zoom_meeting_sdk
