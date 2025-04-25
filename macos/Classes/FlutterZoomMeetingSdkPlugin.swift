import Cocoa
import FlutterMacOS
import ZoomSDK

public class FlutterZoomMeetingSdkPlugin: NSObject, FlutterPlugin {
    private var eventSink: FlutterEventSink?

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "flutter_zoom_meeting_sdk",
            binaryMessenger: registrar.messenger
        )
        let instance = FlutterZoomMeetingSdkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)

        // Register event channels
        let eventChannel = FlutterEventChannel(
            name: "flutter_zoom_meeting_sdk/events",
            binaryMessenger: registrar.messenger
        )
        eventChannel.setStreamHandler(EventStreamHandler(plugin: instance))

    }

    // Event sink setters
    func setEventSink(_ eventSink: FlutterEventSink?) {
        self.eventSink = eventSink
    }

    public func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        let action = call.method

        switch action {
        case "initZoom":
            let zoomSdk = ZoomSDK.shared()
            let initParams = ZoomSDKInitParams()
            initParams.zoomDomain = "zoom.us"

            let initResult = zoomSdk.initSDK(with: initParams)
            let response = StandardZoomResponse(
                isSuccess: initResult == ZoomSDKError_Success,
                message: initResult == ZoomSDKError_Success
                    ? "MSG_INIT_SUCCESS"
                    : "MSG_INIT_FAILED",
                action: action,
                params: [
                    "status": initResult.rawValue,
                    "statusName": initResult.name,
                ]

            )

            result(response.toDictionary())

        case "authZoom":
            guard let args = call.arguments as? [String: String] else {

                let response = StandardZoomResponse(
                    isSuccess: false,
                    message: "MSG_NO_ARGS_PROVIDED",
                    action: action,
                    params: [:]

                )

                result(response.toDictionary())
                return
            }

            guard let jwtToken = args["jwtToken"] else {
                let response = StandardZoomResponse(
                    isSuccess: false,
                    message: "MSG_NO_JWT_TOKEN_PROVIDED",
                    action: action,
                    params: [:]
                )

                result(response.toDictionary())
                return
            }

            let zoomSdk = ZoomSDK.shared()
            let authService = zoomSdk.getAuthService()
            authService.delegate = self

            let authContext = ZoomSDKAuthContext()
            authContext.jwtToken = jwtToken

            let authResult = authService.sdkAuth(authContext)

            let response = StandardZoomResponse(
                isSuccess: authResult == ZoomSDKError_Success,
                message: authResult == ZoomSDKError_Success
                    ? "MSG_AUTH_SENT_SUCCESS"
                    : "MSG_AUTH_SENT_FAILED",
                action: action,
                params: [
                    "status": authResult.rawValue,
                    "statusName": authResult.name,
                ]
            )

            result(response.toDictionary())

        case "joinMeeting":
            guard let args = call.arguments as? [String: String] else {
                let response = StandardZoomResponse(
                    isSuccess: false,
                    message: "MSG_NO_ARGS_PROVIDED",
                    action: action,
                    params: [:]
                )

                result(response.toDictionary())
                return
            }

            guard let meetingService = ZoomSDK.shared().getMeetingService()
            else {
                let response = StandardZoomResponse(
                    isSuccess: false,
                    message: "MSG_MEETING_SERVICE_NOT_AVAILABLE",
                    action: action,
                    params: [:]
                )
                result(response.toDictionary())
                return
            }

            meetingService.delegate = self

            let joinParam = ZoomSDKJoinMeetingElements()
            joinParam.meetingNumber = Int64(args["meetingNumber"] ?? "") ?? 0
            joinParam.password = args["password"]
            joinParam.userType = ZoomSDKUserType_WithoutLogin
            joinParam.displayName = args["displayName"]
            joinParam.webinarToken = nil
            joinParam.customerKey = nil
            joinParam.isDirectShare = false
            joinParam.displayID = 0
            joinParam.isNoVideo = false
            joinParam.isNoAudio = false
            joinParam.vanityID = nil
            joinParam.zak = nil

            let joinResult = meetingService.joinMeeting(joinParam)

            let response = StandardZoomResponse(
                isSuccess: joinResult == ZoomSDKError_Success,
                message: joinResult == ZoomSDKError_Success
                    ? "MSG_AUTH_SENT_SUCCESS"
                    : "MSG_AUTH_SENT_FAILED",
                action: action,
                params: [
                    "status": joinResult.rawValue,
                    "statusName": joinResult.name,
                ]
            )

            result(response.toDictionary())

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

// Stream handlers for event channels
class EventStreamHandler: NSObject, FlutterStreamHandler {
    private let plugin: FlutterZoomMeetingSdkPlugin

    init(plugin: FlutterZoomMeetingSdkPlugin) {
        self.plugin = plugin
        super.init()
    }

    public func onListen(
        withArguments arguments: Any?,
        eventSink events: @escaping FlutterEventSink
    )
        -> FlutterError?
    {
        plugin.setEventSink(events)
        return nil
    }

    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        plugin.setEventSink(nil)
        return nil
    }
}

extension FlutterZoomMeetingSdkPlugin: ZoomSDKAuthDelegate {
    public func onZoomSDKAuthReturn(_ returnValue: ZoomSDKAuthError) {
        let response = StandardZoomEventResponse(
            event: "onAuthenticationReturn",
            oriEvent: "onZoomSDKAuthReturn",
            params: [
                "status": returnValue.rawValue,
                "statusName": returnValue.name,
            ]
        )

        self.eventSink?(response.toDictionary())
    }

    public func onZoomAuthIdentityExpired() {
        let response = StandardZoomEventResponse(
            event: "onZoomAuthIdentityExpired",
            oriEvent: "onZoomAuthIdentityExpired",
            params: [:]
        )

        self.eventSink?(response.toDictionary())
    }
}

extension FlutterZoomMeetingSdkPlugin: ZoomSDKMeetingServiceDelegate {
    public func onMeetingStatusChange(
        _ state: ZoomSDKMeetingStatus,
        meetingError error: ZoomSDKMeetingError,
        end reason: EndMeetingReason
    ) {

        let response = StandardZoomEventResponse(
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

        self.eventSink?(response.toDictionary())

    }
}
