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
        code: initResult.rawValue
      )

      result(response.toDictionary())

    case "authZoom":
      guard let args = call.arguments as? [String: String] else {
        let response = StandardZoomMeetingResponse(
          success: false,
          message: "No arguments provided",
          code: 200
        )
        result(response.toDictionary())
        return
      }
      guard let jwtToken = args["jwtToken"] else {
        let response = StandardZoomMeetingResponse(
          success: false,
          message: "No JWT token provided",
          code: 200
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
        code: authResult.rawValue
      )

      result(response.toDictionary())

    case "joinMeeting":

      guard let args = call.arguments as? [String: String] else {
        let response = StandardZoomMeetingResponse(
          success: false,
          message: "No arguments provided",
          code: 200
        )
        result(response.toDictionary())
        return
      }

      guard let meetingService = ZoomSDK.shared().getMeetingService() else {
        let response = StandardZoomMeetingResponse(
          success: false,
          message: "No meeting service available",
          code: 200
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
        code: joinResult.rawValue
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
    DispatchQueue.main.async {
      print("================================================")
      print("Enter onZoomSDKAuthReturn")
      print("Zoom SDK Auth returned: \(returnValue.rawValue)")

      // Send event to Flutter
      let eventData: [String: Any] = [
        "event": "onZoomSDKAuthReturn",
        "returnCode": returnValue.rawValue,
        "success": returnValue == ZoomSDKAuthError_Success,
      ]
      self.authEventSink?(eventData)

      switch returnValue {
      case ZoomSDKAuthError_Success:
        print("✅ Authentication successful")

      default:
        print("❌ Authentication failed with code: \(returnValue.rawValue)")
      }

      print("================================================")
      fflush(stdout)
    }
  }

  public func onZoomAuthIdentityExpired() {
    DispatchQueue.main.async {
      print("⚠️ Zoom Auth Identity Expired")

      // Send event to Flutter
      let eventData: [String: Any] = [
        "event": "onZoomAuthIdentityExpired"
      ]
      self.authEventSink?(eventData)

      fflush(stdout)
    }
  }
}

extension FlutterZoomMeetingSdkPlugin: ZoomSDKMeetingServiceDelegate {
  public func onMeetingStatusChange(
    _ state: ZoomSDKMeetingStatus, meetingError error: ZoomSDKMeetingError,
    end reason: EndMeetingReason
  ) {
    DispatchQueue.main.async {
      print("Meeting status changed: \(state.rawValue)")

      // Send event to Flutter
      let eventData: [String: Any] = [
        "event": "onMeetingStatusChange",
        "status": state.rawValue,
        "errorCode": error.rawValue,
        "reason": reason.rawValue,
      ]
      self.meetingEventSink?(eventData)

      fflush(stdout)
    }
  }
}
