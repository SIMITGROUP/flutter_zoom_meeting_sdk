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
                    "status": state.rawValue,
                    "statusName": state.name,
                    "failReason": error.rawValue,
                    "failReasonName": error.name,
                    "endReason": reason.rawValue,
                    "endReasonName": reason.name,
                ]
            )
        )

    }
}
