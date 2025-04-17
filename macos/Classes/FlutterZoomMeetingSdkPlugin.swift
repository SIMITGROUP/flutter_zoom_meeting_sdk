import Cocoa
import FlutterMacOS
import ZoomSDK

public class FlutterZoomMeetingSdkPlugin: NSObject, FlutterPlugin {
  private var authEventSink: FlutterEventSink?
  private var meetingEventSink: FlutterEventSink?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_zoom_meeting_sdk", binaryMessenger: registrar.messenger)
    let instance = FlutterZoomMeetingSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    // Register event channels
    let authEventChannel = FlutterEventChannel(
      name: "flutter_zoom_meeting_sdk/auth_events", binaryMessenger: registrar.messenger)
    authEventChannel.setStreamHandler(AuthStreamHandler(plugin: instance))

    let meetingEventChannel = FlutterEventChannel(
      name: "flutter_zoom_meeting_sdk/meeting_events", binaryMessenger: registrar.messenger)
    meetingEventChannel.setStreamHandler(MeetingStreamHandler(plugin: instance))
  }

  // Event sink setters
  func setAuthEventSink(_ eventSink: FlutterEventSink?) {
    self.authEventSink = eventSink
  }

  func setMeetingEventSink(_ eventSink: FlutterEventSink?) {
    self.meetingEventSink = eventSink
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)

    case "initZoom":
      let zoomSdk = ZoomSDK.shared()
      let initParams = ZoomSDKInitParams()
      initParams.zoomDomain = "zoom.us"

      let initResult = zoomSdk.initSDK(with: initParams)
      let response = StandardZoomMeetingResponse(
        success: initResult == ZoomSDKError_Success,
        message: initResult == ZoomSDKError_Success
          ? "Initialized successfully" : "Failed to initialize",
        statusCode: initResult.rawValue,
        statusText: initResult.name,
      )

      result(response.toDictionary())

    case "authZoom":
      guard let args = call.arguments as? [String: String] else {
        let response = StandardZoomMeetingResponse(
          success: false,
          message: "No arguments provided",
          statusCode: 200,
          statusText: ""
        )
        result(response.toDictionary())
        return
      }
      guard let jwtToken = args["jwtToken"] else {
        let response = StandardZoomMeetingResponse(
          success: false,
          message: "No JWT token provided",
          statusCode: 200,
          statusText: ""
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

      let response = StandardZoomMeetingResponse(
        success: authResult == ZoomSDKError_Success,
        message: authResult == ZoomSDKError_Success
          ? "Successfully sent auth request" : "Failed to send auth request",
        statusCode: authResult.rawValue,
        statusText: authResult.name,
      )

      result(response.toDictionary())

    case "joinMeeting":

      guard let args = call.arguments as? [String: String] else {
        let response = StandardZoomMeetingResponse(
          success: false,
          message: "No arguments provided",
          statusCode: 200,
          statusText: ""
        )
        result(response.toDictionary())
        return
      }

      guard let meetingService = ZoomSDK.shared().getMeetingService() else {
        let response = StandardZoomMeetingResponse(
          success: false,
          message: "No meeting service available",
          statusCode: 200,
          statusText: ""
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

      let response = StandardZoomMeetingResponse(
        success: joinResult == ZoomSDKError_Success,
        message: joinResult == ZoomSDKError_Success
          ? "Successfully joined meeting" : "Failed to join meeting",
        statusCode: joinResult.rawValue,
        statusText: joinResult.name,
      )

      result(response.toDictionary())

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}

// Stream handlers for event channels
class AuthStreamHandler: NSObject, FlutterStreamHandler {
  private let plugin: FlutterZoomMeetingSdkPlugin

  init(plugin: FlutterZoomMeetingSdkPlugin) {
    self.plugin = plugin
    super.init()
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink)
    -> FlutterError?
  {
    plugin.setAuthEventSink(events)
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    plugin.setAuthEventSink(nil)
    return nil
  }
}

class MeetingStreamHandler: NSObject, FlutterStreamHandler {
  private let plugin: FlutterZoomMeetingSdkPlugin

  init(plugin: FlutterZoomMeetingSdkPlugin) {
    self.plugin = plugin
    super.init()
  }

  public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink)
    -> FlutterError?
  {
    plugin.setMeetingEventSink(events)
    return nil
  }

  public func onCancel(withArguments arguments: Any?) -> FlutterError? {
    plugin.setMeetingEventSink(nil)
    return nil
  }
}

extension FlutterZoomMeetingSdkPlugin: ZoomSDKAuthDelegate {
  public func onZoomSDKAuthReturn(_ returnValue: ZoomSDKAuthError) {
    let response = StandardZoomMeetingEventResponse(
      event: "onZoomSDKAuthReturn",
      success: returnValue == ZoomSDKAuthError_Success,
      message: returnValue == ZoomSDKAuthError_Success
        ? "Successfully authenticated" : "Failed to authenticate",
      statusCode: returnValue.rawValue,
      statusText: returnValue.name,
    )

    // Send event to Flutter
    self.authEventSink?(response.toDictionary())
  }

  public func onZoomAuthIdentityExpired() {
    let response = StandardZoomMeetingEventResponse(
      event: "onZoomAuthIdentityExpired",
      success: true,
      message: "Zoom Auth Identity Expired",
      statusCode: 0,
      statusText: "",
    )

    self.authEventSink?(response.toDictionary())
  }
}

extension FlutterZoomMeetingSdkPlugin: ZoomSDKMeetingServiceDelegate {
  public func onMeetingStatusChange(
    _ state: ZoomSDKMeetingStatus, meetingError error: ZoomSDKMeetingError,
    end reason: EndMeetingReason
  ) {

    let response = ZoomMeetingStatusChangeEventResponse(
      event: "onMeetingStatusChange",
      meetingStatus: state.rawValue,
      meetingStatusText: state.name,
      meetingError: error.rawValue,
      meetingErrorText: error.name,
      endMeetingReason: reason.rawValue,
      endMeetingReasonText: reason.name,
    )

    self.meetingEventSink?(response.toDictionary())

  }
}
