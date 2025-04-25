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

    public func onZoomSDKLoginResult(
        _ loginStatus: ZoomSDKLoginStatus,
        failReason: ZoomSDKLoginFailReason
    ) {
        self.eventSink?(
            makeEventResponse(
                event: "onLoginReturnWithReason",
                oriEvent: "onZoomSDKLoginResult",
                params: [
                    "status": loginStatus.rawValue,
                    "statusName": loginStatus.name,
                    "failReason": failReason.rawValue,
                    "failReasonName": failReason.name,
                ]
            )
        )
    }

    public func onZoomSDKLogout() {
        self.eventSink?(
            makeEventResponse(
                event: "onLogout",
                oriEvent: "onZoomSDKLogout",
                params: [:]
            )
        )
    }

    public func onZoomIdentityExpired() {
        self.eventSink?(
            makeEventResponse(
                event: "onZoomIdentityExpired",
                oriEvent: "onZoomIdentityExpired",
                params: [:]
            )
        )
    }

    public func onNotificationServiceStatus(
        _ status: ZoomSDKNotificationServiceStatus,
        error: ZoomSDKNotificationServiceError
    ) {
        self.eventSink?(
            makeEventResponse(
                event: "onNotificationServiceStatus",
                oriEvent: "onNotificationServiceStatus",
                params: [
                    "status": status.rawValue,
                    "statusName": status.name,
                    "error": error.rawValue,
                    "errorName": error.name,
                ]
            )
        )
    }
}
