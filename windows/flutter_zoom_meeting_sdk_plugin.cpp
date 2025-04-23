#include "flutter_zoom_meeting_sdk_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

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
#include "event_auth.h"
#include "zoom_event_stream_handler.h"

namespace flutter_zoom_meeting_sdk
{
  // Using a raw pointer for the global event handler
  static ZoomEventStreamHandler *g_event_handler_ptr = nullptr;

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

    // Set up the event channel for Zoom SDK events
    auto event_channel = std::make_unique<flutter::EventChannel<flutter::EncodableValue>>(
        registrar->messenger(),
        "flutter_zoom_meeting_sdk/events",
        &flutter::StandardMethodCodec::GetInstance());

    // Create the event handler
    auto handler = std::make_unique<ZoomEventStreamHandler>();
    g_event_handler_ptr = handler.get(); // Store global pointer before transferring ownership

    // Set the stream handler
    event_channel->SetStreamHandler(std::move(handler));

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
            "Initialized successfully",
            0,
            "SDKERR_SUCCESS"));
      }
      else
      {

        result->Success(CreateStandardZoomMeetingResponse(
            false,
            "Initialization failed",
            static_cast<uint32_t>(initResult),
            "SDKERR_FAILURE"));
      }
    }
    else if (method_call.method_name().compare("authZoom") == 0)
    {
      std::wcout << L"Enter Auth Zoom: " << std::endl;
      ArgReader reader(method_call);

      auto token = reader.GetString("jwtToken").value_or("");

      ZOOM_SDK_NAMESPACE::IAuthService *authService;
      ZOOM_SDK_NAMESPACE::SDKError authServiceInitReturnVal = ZOOM_SDK_NAMESPACE::CreateAuthService(&authService);
      if (authServiceInitReturnVal == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
      {
        // Create IAuthServiceEvent object to listen for Auth events from SDK
        ZoomSDKAuthServiceEventListener *authListener = new ZoomSDKAuthServiceEventListener();
        // Set the event handler - using the global event handler
        if (g_event_handler_ptr)
        {
          std::cout << "Setting event handler for auth events" << std::endl;
          authListener->SetEventHandler(g_event_handler_ptr);
        }
        else
        {
          std::cout << "WARNING: Global event handler is null!" << std::endl;
        }

        // Auth SDK with AuthContext object
        ZOOM_SDK_NAMESPACE::AuthContext authContext;
        ZOOM_SDK_NAMESPACE::SDKError authCallReturnValue(ZOOM_SDK_NAMESPACE::SDKERR_UNAUTHENTICATION);
        // Call SetEvent to assign your IAuthServiceEvent listener
        authService->SetEvent(authListener);

        // Provide your JWT to the AuthContext object
        std::wstring wide_token(token.begin(), token.end()); // Convert the token to wide string
        authContext.jwt_token = wide_token.c_str();
        authCallReturnValue = authService->SDKAuth(authContext);
        if (authCallReturnValue == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
        {
          // SDK Auth in progress
          result->Success(CreateStandardZoomMeetingResponse(
              true,
              "SDK Auth in progress",
              0,
              "SDKERR_SUCCESS"));
          return;
        }
      }

      result->Success(CreateStandardZoomMeetingResponse(
          true,
          token,
          0,
          "SDKERR_SUCCESS"));
    }
    else if (method_call.method_name().compare("joinMeeting") == 0)
    {
      //
      ZOOM_SDK_NAMESPACE::IMeetingService *meetingService;
      ZOOM_SDK_NAMESPACE::SDKError meetingServiceInitReturnVal = ZOOM_SDK_NAMESPACE::CreateMeetingService(&meetingService);
      if (meetingServiceInitReturnVal == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
      {

        ArgReader reader(method_call);

        std::cout << "Meeting Service Init Success" << std::endl;

        // Join meeting for end user with JoinParam object

        ZOOM_SDK_NAMESPACE::JoinParam joinParam;
        joinParam.userType = ZOOM_SDK_NAMESPACE::SDK_UT_NORMALUSER;
        auto &normalParam = joinParam.param.normaluserJoin;

        // Get meeting number as UINT64 using our new helper
        auto meetingNumber = reader.GetUINT64("meetingNumber").value_or(0);
        // Continue with string parameters
        auto password = reader.GetWString("password").value_or(L"");
        auto displayName = reader.GetWString("displayName").value_or(L"Zoom User");

        std::wcout << L"meetingNumber: " << meetingNumber << std::endl;
        std::wcout << L"password: " << password << std::endl;
        std::wcout << L"displayName: " << displayName << std::endl;

        normalParam.meetingNumber = meetingNumber;
        normalParam.userName = displayName.c_str();
        normalParam.psw = password.c_str();
        normalParam.isVideoOff = false;
        normalParam.isAudioOff = false;

        auto joinResult = meetingService->Join(joinParam);

        std::cout << "joinResult: " << joinResult << std::endl;
        if (joinResult == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS)
        {
          // Join meeting call succeeded, listen for join meeting result using the onMeetingStatusChanged callback
          result->Success(CreateStandardZoomMeetingResponse(
              true,
              "Join meeting call succeeded",
              0,
              "SDKERR_SUCCESS"));
          return;
        }
        else
        {
          result->Success(CreateStandardZoomMeetingResponse(
              true,
              "Join meeting call failed",
              0,
              "SDKERR_SUCCESS"));
          return;
        }
      }
    }
    else
    {
      result->NotImplemented();
    }
  }
} // namespace flutter_zoom_meeting_sdk
