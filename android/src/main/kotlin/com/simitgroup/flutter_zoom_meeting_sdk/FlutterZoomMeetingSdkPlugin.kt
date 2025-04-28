package com.simitgroup.flutter_zoom_meeting_sdk

import android.content.Context
import android.util.Log
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import us.zoom.sdk.*


/** FlutterZoomMeetingSdkPlugin */
class FlutterZoomMeetingSdkPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var eventChannel: EventChannel

    private var eventSink: EventChannel.EventSink? = null

    private lateinit var context: Context

    companion object {
        const val PLATFORM = "android"
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext

        // Method Channel
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_zoom_meeting_sdk")
        channel.setMethodCallHandler(this)

        // Event Channel
        eventChannel =
            EventChannel(flutterPluginBinding.binaryMessenger, "flutter_zoom_meeting_sdk/events")
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
            }
        })
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        val action = call.method
      
        when {
            (action == "initZoom") -> {
                val response = StandardZoomResponse(
                    isSuccess = true,
                    message = "MSG_ANDROID_INIT",
                    action = action
                )

                result.success(response.toMap())
            }
            (action == "authZoom") -> {
                val response = authZoom(call)
                result.success(response.toMap())
            }
            (action == "joinMeeting") -> {
                val response = joinZoomMeeting(call)

                result.success(response.toMap())
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        eventSink = null
        channel.setMethodCallHandler(null)
        eventChannel.setStreamHandler(null)

        ZoomSDK.getInstance().uninitialize()
    }

    private fun authZoom(call: MethodCall) : StandardZoomResponse{
        val action = "authZoom";
        val arguments = call.arguments<Map<String, String>>() ?: emptyMap<String, String>()
        if(arguments.isEmpty())
        {
            return StandardZoomResponse(
                isSuccess = false,
                message = "MSG_NO_ARGS_PROVIDED",
                action = action
            )
        }

        val token = arguments["jwtToken"]
        if (token.isNullOrEmpty()) {
            return StandardZoomResponse(
                isSuccess = false,
                message = "MSG_NO_JWT_TOKEN_PROVIDED",
                action = action
            )
        }

        val sdk = ZoomSDK.getInstance()

        val params = ZoomSDKInitParams().apply {
            jwtToken = token
            domain = "zoom.us"
        }

        sdk.initialize(context, createZoomAuthListener(), params)

        return StandardZoomResponse(
            isSuccess = true,
            message = "MSG_AUTH_SENT_SUCCESS",
            action = action,
            params = mapOf(
                "status" to 0,
                "statusName" to "Success"
            )
        )
    }

    private fun joinZoomMeeting(call: MethodCall) : StandardZoomResponse{
        val action = "joinMeeting"

        val arguments = call.arguments<Map<String, String>>() ?: emptyMap<String, String>()
        if(arguments.isEmpty())
        {
            return StandardZoomResponse(
                isSuccess = false,
                message = "MSG_NO_ARGS_PROVIDED",
                action = action
            )
        }

        val meetingNumber = arguments["meetingNumber"]
        val password = arguments["password"]
        val displayName = arguments["displayName"]

        val meetingService = ZoomSDK.getInstance().meetingService
            ?: return StandardZoomResponse(
                isSuccess = false,
                message = "MSG_MEETING_SERVICE_NOT_AVAILABLE",
                action = action
            )

        meetingService.addListener(createMeetingServiceListener())

        val opts = JoinMeetingOptions()

        val params = JoinMeetingParams()
        params.meetingNo = meetingNumber
        params.password = password
        params.displayName = displayName

        val joinResult = meetingService.joinMeetingWithParams(context, params, opts)

        val response = StandardZoomResponse(
            isSuccess = joinResult == MeetingError.MEETING_ERROR_SUCCESS,
            message = if (joinResult == MeetingError.MEETING_ERROR_SUCCESS) "MSG_JOIN_SENT_SUCCESS" else "MSG_JOIN_SENT_FAILED",
            action = action,
            params = mapOf(
                "status" to joinResult,
                "statusName" to "TODO"
            )
        )

        return response;
    }

    private fun createZoomAuthListener(): ZoomSDKInitializeListener {
        return object : ZoomSDKInitializeListener {
            override fun onZoomSDKInitializeResult(errorCode: Int, internalErrorCode: Int) {
                eventLog("onZoomSDKInitializeResult", "Init Result: errorCode=$errorCode, internalErrorCode=$internalErrorCode")

                eventSink?.success(
                    mapOf(
                        "platform" to PLATFORM,
                        "event" to "onAuthenticationReturn",
                        "oriEvent" to "onZoomSDKInitializeResult",
                        "params" to mapOf(
                            "status" to errorCode,
                            "statusName" to MapperZoomError.getErrorName(errorCode),
                            "internalErrorCode" to internalErrorCode
                        )
                    )
                )
            }

            override fun onZoomAuthIdentityExpired() {
                eventLog("onZoomAuthIdentityExpired", "Zoom SDK auth identity expired")

                eventSink?.success(
                    mapOf(
                        "platform" to PLATFORM,
                        "event" to "onZoomAuthIdentityExpired",
                        "oriEvent" to "onZoomAuthIdentityExpired",
                        "params" to emptyMap<String, Any>()
                    )
                )
            }
        }
    }

    private fun createMeetingServiceListener(): MeetingServiceListener {
        return object : MeetingServiceListener {
            override fun onMeetingStatusChanged(
                meetingStatus: MeetingStatus,
                errorCode: Int,
                internalErrorCode: Int
            ) {
                eventLog("onMeetingStatusChanged", "Zoom Meeting Status Changed: $meetingStatus")
                eventSink?.success(
                    mapOf(
                        "platform" to PLATFORM,
                        "event" to "onMeetingStatusChanged",
                        "oriEvent" to "onMeetingStatusChanged",
                        "params" to mapOf(
                            "status" to meetingStatus.ordinal,
                            "statusName" to meetingStatus.name,
                            "error" to errorCode,
                            "errorName" to MapperMeetingError.getErrorName(errorCode),
                            "internalErrorCode" to internalErrorCode
                        )
                    )
                )
            }

            override fun onMeetingParameterNotification(params: MeetingParameter) {
                eventLog("eventOnMeetingParameterNotification", "Params: $params")

                eventSink?.success(
                    mapOf(
                        "platform" to PLATFORM,
                        "event" to "onMeetingParameterNotification",
                        "oriEvent" to "onMeetingParameterNotification",
                        "params" to params
                    )
                )
            }
        }
    }
}

