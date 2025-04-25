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
                    "failReason": -99,
                    "failReasonName": "NoProvide",
                    "endReason": -99,
                    "endReasonName": "NoProvide",
                ]
            )
        )
    }
    
    public func onMeetingError(_ error: MobileRTCMeetError, message: String?) {
        self.eventSink?(
            makeEventResponse(
                event: "onMeetingError",
                oriEvent: "onMeetingError",
                params: [
                    "failReason": error.rawValue,
                    "failReasonName": error.name,
                    "message": message ?? "",
                ]
            )
        )
    }
    
    public func onMeetingEndedReason(_ reason: MobileRTCMeetingEndReason) {
        self.eventSink?(
            makeEventResponse(
                event: "onMeetingEndedReason",
                oriEvent: "onMeetingEndedReason",
                params: [
                    "endReason": reason.rawValue,
                    "endReasonName": reason.name,
                ]
            )
        )
    }
}
