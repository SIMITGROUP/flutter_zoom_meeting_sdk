package com.simitgroup.flutter_zoom_meeting_sdk

import com.simitgroup.flutter_zoom_meeting_sdk.FlutterZoomMeetingSdkPlugin.Companion.PLATFORM
import io.flutter.plugin.common.EventChannel
import us.zoom.sdk.MeetingParameter
import us.zoom.sdk.MeetingServiceListener
import us.zoom.sdk.MeetingStatus

class FlutterZoomEventListenerMeeting(private val eventSink: EventChannel.EventSink?):
    MeetingServiceListener {
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
                    "statusCode" to meetingStatus.ordinal,
                    "statusLabel" to MapperMeetingStatus.getErrorName(meetingStatus),
                    "errorCode" to errorCode,
                    "errorLabel" to MapperMeetingError.getErrorName(errorCode),
                    "endReasonCode" to -99,
                    "endReasonLabel" to "NO_PROVIDED",
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