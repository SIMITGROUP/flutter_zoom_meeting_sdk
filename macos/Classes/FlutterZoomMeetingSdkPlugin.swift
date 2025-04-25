import Cocoa
import FlutterMacOS
import ZoomSDK

public class FlutterZoomMeetingSdkPlugin: NSObject, FlutterPlugin {
    var eventSink: FlutterEventSink?

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
        eventChannel.setStreamHandler(FlutterZoomEventStreamHandler(plugin: instance))

    }

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

            result(
                makeActionResponse(
                    action: action,
                    isSuccess: initResult == ZoomSDKError_Success,
                    message: initResult == ZoomSDKError_Success
                        ? "MSG_INIT_SUCCESS"
                        : "MSG_INIT_FAILED",
                    params: [
                        "status": initResult.rawValue,
                        "statusName": initResult.name,
                    ]
                )
            )

        case "authZoom":
            guard let args = call.arguments as? [String: String] else {
                result(
                    makeActionResponse(
                        action: action,
                        isSuccess: false,
                        message: "MSG_NO_ARGS_PROVIDED",
                    )
                )
                return
            }

            guard let jwtToken = args["jwtToken"] else {
                result(
                    makeActionResponse(
                        action: action,
                        isSuccess: false,
                        message: "MSG_NO_JWT_TOKEN_PROVIDED",
                    )
                )
                return
            }

            let zoomSdk = ZoomSDK.shared()
            let authService = zoomSdk.getAuthService()
            authService.delegate = self

            let authContext = ZoomSDKAuthContext()
            authContext.jwtToken = jwtToken

            let authResult = authService.sdkAuth(authContext)

            result(
                makeActionResponse(
                    action: action,
                    isSuccess: authResult == ZoomSDKError_Success,
                    message: authResult == ZoomSDKError_Success
                        ? "MSG_AUTH_SENT_SUCCESS"
                        : "MSG_AUTH_SENT_FAILED",
                    params: [
                        "status": authResult.rawValue,
                        "statusName": authResult.name,
                    ]
                )
            )

        case "joinMeeting":
            guard let args = call.arguments as? [String: String] else {
                result(
                    makeActionResponse(
                        action: action,
                        isSuccess: false,
                        message: "MSG_NO_ARGS_PROVIDED",
                    )
                )
                return
            }

            guard let meetingService = ZoomSDK.shared().getMeetingService()
            else {
                result(
                    makeActionResponse(
                        action: action,
                        isSuccess: false,
                        message: "MSG_MEETING_SERVICE_NOT_AVAILABLE",
                    )
                )
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

            result(
                makeActionResponse(
                    action: action,
                    isSuccess: joinResult == ZoomSDKError_Success,
                    message: joinResult == ZoomSDKError_Success
                        ? "MSG_JOIN_SENT_SUCCESS"
                        : "MSG_JOIN_SENT_FAILED",
                    params: [
                        "status": joinResult.rawValue,
                        "statusName": joinResult.name,
                    ]
                )
            )

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
