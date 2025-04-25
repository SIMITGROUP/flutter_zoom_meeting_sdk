import ZoomSDK

extension FlutterZoomMeetingSdkPlugin: ZoomSDKAuthDelegate {
    public func onZoomSDKAuthReturn(_ returnValue: ZoomSDKAuthError) {
        self.eventSink?(
            makeEventResponse(
                event: "onAuthenticationReturn",
                oriEvent: "onZoomSDKAuthReturn",
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
