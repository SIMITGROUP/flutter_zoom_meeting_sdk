import MobileRTC
extension FlutterZoomMeetingSdkPlugin: MobileRTCMeetingServiceDelegate {
    public func onMeetingStateChange(
        _ state: MobileRTCMeetingState
    ) {
        self.eventSink?(
            makeEventResponse(
                event: "onMeetingStatusChanged",
                oriEvent: "onMeetingStateChange",
                params: [
                    "status": state.rawValue,
                    "statusName": state.name,
                    "failReason": 0,
                    "failReasonName": "None",
                    "endReason": 0,
                    "endReasonName": "None",
                ]
            )
        )
    }
}
