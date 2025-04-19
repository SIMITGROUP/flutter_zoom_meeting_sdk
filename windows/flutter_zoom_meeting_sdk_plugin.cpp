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

#include "zoom_sdk.h"
#include "auth_service_interface.h"
#include "meeting_service_interface.h"
using namespace ZOOM_SDK_NAMESPACE;

namespace flutter_zoom_meeting_sdk {

    flutter::EncodableMap CreateStandardZoomMeetingResponse(bool success, std::string message, uint32_t statusCode, std::string statusText) {
        flutter::EncodableMap response;
        response[flutter::EncodableValue("success")] = flutter::EncodableValue(success);
        response[flutter::EncodableValue("message")] = flutter::EncodableValue(message);
        response[flutter::EncodableValue("statusCode")] = flutter::EncodableValue(statusCode);
        response[flutter::EncodableValue("statusText")] = flutter::EncodableValue(statusText);
        return response;
    }

// static
void FlutterZoomMeetingSdkPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "flutter_zoom_meeting_sdk",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<FlutterZoomMeetingSdkPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

FlutterZoomMeetingSdkPlugin::FlutterZoomMeetingSdkPlugin() {}

FlutterZoomMeetingSdkPlugin::~FlutterZoomMeetingSdkPlugin() {}

void FlutterZoomMeetingSdkPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getPlatformVersion") == 0) {
    std::ostringstream version_stream;
    version_stream << "Windows ";
    if (IsWindows10OrGreater()) {
      version_stream << "10+";
    } else if (IsWindows8OrGreater()) {
      version_stream << "8";
    } else if (IsWindows7OrGreater()) {
      version_stream << "7";
    }
    result->Success(flutter::EncodableValue(version_stream.str()));
  }
  else if (method_call.method_name().compare("initZoom") == 0) {
      ZOOM_SDK_NAMESPACE::InitParam initParam;
      initParam.strWebDomain = L"https://zoom.us";

      //std::wcout << L"Initializing SDK..." << std::endl;
      auto initResult = ZOOM_SDK_NAMESPACE::InitSDK(initParam);
      if (initResult == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS) {

      }

      //if (initResult == ZOOM_SDK_NAMESPACE::SDKError::SDKERR_SUCCESS) {
      //    result->Success(CreateStandardZoomMeetingResponse(
      //        true,
      //        "Initialized successfully",
      //        static_cast<uint32_t>(initResult),
      //        "SDKERR_SUCCESS"));
      //}
      //else {
      //    result->Success(CreateStandardZoomMeetingResponse(
      //        false,
      //        "Failed to initialize",
      //        static_cast<uint32_t>(initResult),
      //        "SDKERR_" + std::to_string(static_cast<int>(initResult)))); // or map this to a string yourself
      //}
  }
  else {
    result->NotImplemented();
  }
}

}  // namespace flutter_zoom_meeting_sdk
