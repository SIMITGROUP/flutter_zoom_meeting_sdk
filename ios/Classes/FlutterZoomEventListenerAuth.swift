import MobileRTC
extension FlutterZoomMeetingSdkPlugin: MobileRTCAuthDelegate {
    public func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
        self.eventSink?(
            makeEventResponse(
                event: "onAuthenticationReturn",
                oriEvent: "onMobileRTCAuthReturn",
                params: [
                    "status": returnValue.rawValue,
                    "statusName": returnValue.name,
                ]
            )
        )
    }

    public func onZoomAuthIdentityExpired() {
        self.eventSink?(
            makeEventResponse(
                event: "onZoomAuthIdentityExpired",
                oriEvent: "onZoomAuthIdentityExpired",
                params: [:]
            )
        )
    }
}
