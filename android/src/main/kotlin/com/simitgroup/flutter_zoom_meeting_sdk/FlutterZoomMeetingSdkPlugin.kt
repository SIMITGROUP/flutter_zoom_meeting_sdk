package com.simitgroup.flutter_zoom_meeting_sdk

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** FlutterZoomMeetingSdkPlugin */
class FlutterZoomMeetingSdkPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_zoom_meeting_sdk")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "initZoom") {
      val response = StandardZoomMeetingResponse(
        success = true,
        message = "Initialized successfully",
        statusCode = 0,
        statusText = "Success"
      )

      result.success(response.toMap())

    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}

data class StandardZoomMeetingResponse(
  val success: Boolean,
  val message: String,
  val statusCode: Int,
  val statusText: String
) {
  fun toMap(): Map<String, Any> {
    return mapOf(
      "success" to success,
      "message" to message,
      "statusCode" to statusCode,
      "statusText" to statusText
    )
  }
}

