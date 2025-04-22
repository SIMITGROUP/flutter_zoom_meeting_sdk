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


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_zoom_meeting_sdk")
        channel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "flutter_zoom_meeting_sdk/events")
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
        if (call.method == "initZoom") {
            val sdk = ZoomSDK.getInstance()
            val params = ZoomSDKInitParams().apply {
                jwtToken =
                    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBLZXkiOiJBYlhXS2VDTFJ5Q1pyUURRWEVtMVEiLCJzZGtLZXkiOiJBYlhXS2VDTFJ5Q1pyUURRWEVtMVEiLCJtbiI6IjMyNzM1ODg2MTMiLCJyb2xlIjowLCJ0b2tlbkV4cCI6MTc0NTMxNzIyMSwiaWF0IjoxNzQ1MzEzNjIxLCJleHAiOjE3NDUzMTcyMjF9.thawFF8tTPQROE8xvnQbIhD1pYUnTmGMxZDydcIV79A" // TODO: Retrieve your JWT Token and enter it here
                domain = "zoom.us"
                enableLog = true // Optional: enable logging for debugging
            }


            val listener = object : ZoomSDKInitializeListener {
                /**
                 * If the [errorCode] is [ZoomError.ZOOM_ERROR_SUCCESS], the SDK was initialized and can
                 * now be used to join/start a meeting.
                 */
                override fun onZoomSDKInitializeResult(errorCode: Int, internalErrorCode: Int) {
                    println("Zoom Init: errorCode=$errorCode, internalErrorCode=$internalErrorCode")
                    Log.d(
                        "ZoomInit",
                        "Zoom SDK Init Result: errorCode=$errorCode, internalErrorCode=$internalErrorCode"
                    )
                    if (errorCode == ZoomError.ZOOM_ERROR_SUCCESS) {
                        Log.d("ZoomInit", "Zoom SDK initialized successfully")
                        val meetingService = ZoomSDK.getInstance().meetingService


                        val meetingListener = object : MeetingServiceListener {
                            override fun onMeetingStatusChanged(
                                meetingStatus: MeetingStatus, errorCode: Int,
                                internalErrorCode: Int
                            ) {
                                Log.e("ZoomMeetingStatus", "Zoom Meeting Status Changed: $meetingStatus")

                                if (meetingStatus === MeetingStatus.MEETING_STATUS_FAILED && errorCode == MeetingError.MEETING_ERROR_CLIENT_INCOMPATIBLE) {
                                    Log.e("ZoomMeetingStatus", "Failed to join meeting")
                                }

                                eventSink?.success(mapOf(
                                    "event" to "onMeetingStatusChanged",
                                    "meetingStatus" to meetingStatus.name,
                                    "errorCode" to errorCode,
                                    "internalErrorCode" to internalErrorCode
                                ))
                            }

                            override fun onMeetingParameterNotification(params: MeetingParameter) {

                            }
                        }

                        meetingService.addListener(meetingListener)

                        val opts = JoinMeetingOptions()

                        val params = JoinMeetingParams()
                        params.meetingNo = "3273588613"
                        params.password = "6SuCMB"
                        params.displayName = "Yong"

                        meetingService.joinMeetingWithParams(context, params, opts)
                    } else {
                        Log.e("ZoomInit", "Zoom SDK initialization failed!")
                    }
                }

                override fun onZoomAuthIdentityExpired() {
                    Log.w("ZoomInit", "Zoom SDK auth identity expired")
                }
            }



            sdk.initialize(context, listener, params)

            val response = StandardZoomMeetingResponse(
                success = true,
                message = "Initial Sent... Waiting Callback",
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

