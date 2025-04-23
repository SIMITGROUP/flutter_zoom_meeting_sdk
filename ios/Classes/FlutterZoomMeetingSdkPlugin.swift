import Flutter
import MobileRTC
import UIKit

public class FlutterZoomMeetingSdkPlugin: NSObject, FlutterPlugin {
  private var authEventSink: FlutterEventSink?
  private var meetingEventSink: FlutterEventSink?

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_zoom_meeting_sdk", binaryMessenger: registrar.messenger())
    let instance = FlutterZoomMeetingSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    // Register event channels
    let authEventChannel = FlutterEventChannel(
      name: "flutter_zoom_meeting_sdk/auth_events", binaryMessenger: registrar.messenger())
    authEventChannel.setStreamHandler(AuthStreamHandler(plugin: instance))

    let meetingEventChannel = FlutterEventChannel(
      name: "flutter_zoom_meeting_sdk/meeting_events", binaryMessenger: registrar.messenger())
    meetingEventChannel.setStreamHandler(MeetingStreamHandler(plugin: instance))

    let eventChannel = FlutterEventChannel(
      name: "flutter_zoom_meeting_sdk/events", binaryMessenger: registrar.messenger())
    eventChannel.setStreamHandler(MeetingStreamHandler(plugin: instance))
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
      result("iOS " + UIDevice.current.systemVersion)

    case "initZoom":
      let context = MobileRTCSDKInitContext()
      context.domain = "zoom.us"

      let sdkInitializedSuccessfully = MobileRTC.shared().initialize(context)
      let response = StandardZoomMeetingResponse(
        success: sdkInitializedSuccessfully,
        message: sdkInitializedSuccessfully
          ? "Initialized successfully" : "Failed to initialize",
        statusCode: sdkInitializedSuccessfully ? 0 : 1,
        statusText: sdkInitializedSuccessfully ? "Success" : "Failed",
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

      let authorizationService = MobileRTC.shared().getAuthService()
      if let authService = authorizationService {
        authService.delegate = self
        authService.jwtToken = jwtToken
        authService.sdkAuth()

        let response = StandardZoomMeetingResponse(
          success: true,
          message: "Successfully sent auth request",
          statusCode: 0,
          statusText: "Success"
        )
        result(response.toDictionary())
      } else {
        let response = StandardZoomMeetingResponse(
          success: false,
          message: "Failed to get auth service",
          statusCode: 1,
          statusText: "Failed"
        )
        result(response.toDictionary())
      }

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

      guard let meetingService = MobileRTC.shared().getMeetingService() else {
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

      let joinMeetingParameters = MobileRTCMeetingJoinParam()
      

      joinMeetingParameters.meetingNumber = args["meetingNumber"]
      joinMeetingParameters.password = args["password"]
      joinMeetingParameters.userName = args["displayName"]
      joinMeetingParameters.noVideo = true
      joinMeetingParameters.noAudio = true

      let joinResult = meetingService.joinMeeting(with: joinMeetingParameters)

      let response = StandardZoomMeetingResponse(
        success: joinResult == .success,
        message: joinResult == .success
          ? "Successfully joined meeting" : "Failed to join meeting",
        statusCode: UInt32(joinResult.rawValue),
        statusText: joinResult.name
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

extension FlutterZoomMeetingSdkPlugin: MobileRTCAuthDelegate {
  public func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
    let response = StandardZoomMeetingEventResponse(
      event: "onZoomSDKAuthReturn",
      success: returnValue == MobileRTCAuthError.success,
      message: returnValue == MobileRTCAuthError.success
        ? "Successfully authenticated" : "Failed to authenticate",
      statusCode: UInt32(returnValue.rawValue),
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

extension FlutterZoomMeetingSdkPlugin: MobileRTCMeetingServiceDelegate {
  public func onMeetingStateChange(
    _ state: MobileRTCMeetingState
  ) {

    let response = ZoomMeetingStatusChangeEventResponse(
      event: "onMeetingStatusChange",
      meetingStatus: UInt32(state.rawValue),
      meetingStatusText: state.name,
      meetingError: 0,
      meetingErrorText: "No provided",
      endMeetingReason: 0,
      endMeetingReasonText: "No provided"
    )

    self.meetingEventSink?(response.toDictionary())
  }
}
