import ZoomSDK

extension FlutterZoomMeetingSdkPlugin: ZoomSDKMeetingServiceDelegate {
    public func onMeetingStatusChange(
        _ state: ZoomSDKMeetingStatus,
        meetingError error: ZoomSDKMeetingError,
        end reason: EndMeetingReason
    ) {
        self.eventSink?(
            makeEventResponse(
                event: "onMeetingStatusChanged",
                oriEvent: "onMeetingStatusChange",
                params: [
                    "statusCode": state.rawValue,
                    "statusLabel": state.name,
                    "errorCode": error.rawValue,
                    "errorLabel": error.name,
                    "endReasonCode": reason.rawValue,
                    "endReasonLabel": reason.name,
                ]
            )
        )
    }
}
