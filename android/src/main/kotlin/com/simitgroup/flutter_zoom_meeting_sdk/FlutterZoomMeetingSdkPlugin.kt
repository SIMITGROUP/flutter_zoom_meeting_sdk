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
                initZoom(call)

                val response = StandardZoomResponse(
                    isSuccess = true,
                    message = "MSG_AUTH_SENT_SUCCESS",
                    action = action,
                    params = mapOf(
                        "status" to 0,
                        "statusName" to "Success"
                    )
                )

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

    private fun joinZoomMeeting(call: MethodCall) : StandardZoomResponse{
        val action = "joinMeeting"

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

    private fun createZoomInitListener(): ZoomSDKInitializeListener {
        return object : ZoomSDKInitializeListener {
            override fun onZoomSDKInitializeResult(errorCode: Int, internalErrorCode: Int) {
                log("onZoomSDKInitializeResult", "Init Result: errorCode=$errorCode, internalErrorCode=$internalErrorCode")

                eventSink?.success(
                    mapOf(
                        "platform" to PLATFORM,
                        "event" to "onAuthenticationReturn",
                        "oriEvent" to "onZoomSDKInitializeResult",
                        "params" to mapOf(
                            "status" to errorCode,
                            "statusName" to ZoomErrorNameMapper.getErrorName(errorCode),
                            "internalErrorCode" to internalErrorCode
                        )
                    )
                )
            }

            override fun onZoomAuthIdentityExpired() {
                log("onZoomAuthIdentityExpired", "Zoom SDK auth identity expired")

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

object ZoomErrorNameMapper {
    private val errorNames = mapOf(
        ZoomError.ZOOM_ERROR_SUCCESS to "SUCCESS",
        ZoomError.ZOOM_ERROR_INVALID_ARGUMENTS to "INVALID_ARGUMENTS",
        ZoomError.ZOOM_ERROR_ILLEGAL_APP_KEY_OR_SECRET to "ILLEGAL_APP_KEY_OR_SECRET",
        ZoomError.ZOOM_ERROR_NETWORK_UNAVAILABLE to "NETWORK_UNAVAILABLE",
        ZoomError.ZOOM_ERROR_AUTHRET_CLIENT_INCOMPATIBLE to "AUTHRET_CLIENT_INCOMPATIBLE",
        ZoomError.ZOOM_ERROR_AUTHRET_TOKENWRONG to "AUTHRET_TOKENWRONG",
        ZoomError.ZOOM_ERROR_AUTHRET_KEY_OR_SECRET_ERROR to "AUTHRET_KEY_OR_SECRET_ERROR",
        ZoomError.ZOOM_ERROR_AUTHRET_ACCOUNT_NOT_SUPPORT to "AUTHRET_ACCOUNT_NOT_SUPPORT",
        ZoomError.ZOOM_ERROR_AUTHRET_ACCOUNT_NOT_ENABLE_SDK to "AUTHRET_ACCOUNT_NOT_ENABLE_SDK",
        ZoomError.ZOOM_ERROR_AUTHRET_LIMIT_EXCEEDED_EXCEPTION to "AUTHRET_LIMIT_EXCEEDED_EXCEPTION",
        ZoomError.ZOOM_ERROR_DEVICE_NOT_SUPPORTED to "DEVICE_NOT_SUPPORTED",
        ZoomError.ZOOM_ERROR_UNKNOWN to "UNKNOWN",
        ZoomError.ZOOM_ERROR_DOMAIN_DONT_SUPPORT to "DOMAIN_DONT_SUPPORT",
    )

    fun getErrorName(code: Int): String {
        return errorNames[code] ?: "UNDEFINED"
    }
}



