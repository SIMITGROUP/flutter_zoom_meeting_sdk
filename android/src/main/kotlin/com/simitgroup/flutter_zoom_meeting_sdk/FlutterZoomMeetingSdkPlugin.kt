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
 
        if (call.method == "authZoom") {
            initZoom(call)

            val response = StandardZoomMeetingResponse(
                success = true,
                message = "Init Zoom Triggered... Waiting Callback",
                statusCode = 0,
                statusText = "Success"
            )

            result.success(response.toMap())

        }else if (call.method == "joinMeeting") {
            val response = joinZoomMeeting(call)

            result.success(response.toMap())

        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        eventSink = null
        eventChannel.setStreamHandler(null)

        ZoomSDK.getInstance().uninitialize()
    }

    private fun log(tag: String, message: String)
    {
        Log.d("FlutterZoomMeetingSDK::$tag", message)
    }

    private fun initZoom(call: MethodCall) {
        val arguments = call.arguments<Map<String, String>>() ?: emptyMap<String, String>()
        val token = arguments["jwtToken"]

        val sdk = ZoomSDK.getInstance()

        val params = ZoomSDKInitParams().apply {
            jwtToken = token
            domain = "zoom.us"
        }

        sdk.initialize(context, createZoomInitListener(), params)
    }

    private fun joinZoomMeeting(call: MethodCall) : StandardZoomMeetingResponse{
        Log.d(
            "joinZoomMeeting",
            "Start Join Meeting Process"
        )

        val arguments = call.arguments<Map<String, String>>() ?: emptyMap<String, String>()
        val meetingNumber = arguments["meetingNumber"]
        val password = arguments["password"]
        val displayName = arguments["displayName"]

        val meetingService = ZoomSDK.getInstance().meetingService

        meetingService.addListener(createMeetingServiceListener())

        val opts = JoinMeetingOptions()

        val params = JoinMeetingParams()
        params.meetingNo = meetingNumber
        params.password = password
        params.displayName = displayName

        val response: StandardZoomMeetingResponse

        val joinResult = meetingService.joinMeetingWithParams(context, params, opts)
        if(joinResult == MeetingError.MEETING_ERROR_SUCCESS){
            Log.d(
                "joinZoomMeeting",
                "Join Meeting Success"
            )

            response = StandardZoomMeetingResponse(
                success = true,
                message = "Join Zoom Meeting Triggered... Waiting Callback",
                statusCode = joinResult,
                statusText = "Success"
            )

        }else {
            Log.d(
                "joinZoomMeeting",
                "Join Meeting Fail"
            )

            response = StandardZoomMeetingResponse(
                success = false,
                message = "Join Zoom Meeting Triggered... Waiting Callback",
                statusCode = joinResult,
                statusText = "Fail"
            )
        }

        return response;
    }

    private fun createZoomInitListener(): ZoomSDKInitializeListener {
        return object : ZoomSDKInitializeListener {
            override fun onZoomSDKInitializeResult(errorCode: Int, internalErrorCode: Int) {
                log("eventOnZoomSDKInitializeResult", "Init Result: errorCode=$errorCode, internalErrorCode=$internalErrorCode")

                if (errorCode == ZoomError.ZOOM_ERROR_SUCCESS) {
                    log("eventOnZoomSDKInitializeResult", "Zoom SDK initialized successfully")
                } else {
                    log("eventOnZoomSDKInitializeResult", "Zoom SDK initialization failed!")
                }

                eventSink?.success(
                    mapOf(
                        "platform" to PLATFORM,
                        "event" to "onZoomSDKInitializeResult",
                        "oriEvent" to "onZoomSDKInitializeResult",
                        "params" to mapOf(
                            "errorCode" to errorCode,
                            "internalErrorCode" to internalErrorCode
                        )
                    )
                )
            }

            override fun onZoomAuthIdentityExpired() {
                log("eventOnZoomAuthIdentityExpired", "Zoom SDK auth identity expired")

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
                log("eventOnMeetingStatusChanged", "Zoom Meeting Status Changed: $meetingStatus")

                eventSink?.success(
                    mapOf(
                        "platform" to PLATFORM,
                        "event" to "onMeetingStatusChanged",
                        "oriEvent" to "onMeetingStatusChanged",
                        "params" to mapOf(
                            "status" to meetingStatus.ordinal,
                            "statusName" to meetingStatus.name,
                            "errorCode" to errorCode,
                            "internalErrorCode" to internalErrorCode
                        )
                    )
                )
            }

            override fun onMeetingParameterNotification(params: MeetingParameter) {
                log("eventOnMeetingParameterNotification", "Params: $params")

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



