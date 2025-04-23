package com.simitgroup.flutter_zoom_meeting_sdk

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