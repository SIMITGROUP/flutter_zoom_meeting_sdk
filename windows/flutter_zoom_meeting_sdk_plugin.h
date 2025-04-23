#ifndef FLUTTER_PLUGIN_FLUTTER_ZOOM_MEETING_SDK_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_ZOOM_MEETING_SDK_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>
#include "zoom_sdk.h"
#include "auth_service_interface.h"
#include "meeting_service_interface.h"
#include "zoom_event_stream_handler.h"

namespace flutter_zoom_meeting_sdk
{

    class FlutterZoomMeetingSdkPlugin : public flutter::Plugin
    {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        FlutterZoomMeetingSdkPlugin();

        virtual ~FlutterZoomMeetingSdkPlugin();

        std::unique_ptr<ZoomEventStreamHandler> event_stream_handler_;

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
