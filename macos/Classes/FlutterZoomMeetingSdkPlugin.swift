import Cocoa
import FlutterMacOS
import ZoomSDK

public class FlutterZoomMeetingSdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_zoom_meeting_sdk", binaryMessenger: registrar.messenger)
    let instance = FlutterZoomMeetingSdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
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
      print("Initialized Zoom SDK: \(initResult)")
      result("Initialized Zoom SDK: \(initResult)")

    case "authZoom":
      let zoomSdk = ZoomSDK.shared()
      let authService = zoomSdk.getAuthService()
      // authService.delegate = self

      let authContext = ZoomSDKAuthContext()
      authContext.jwtToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBLZXkiOiJBYlhXS2VDTFJ5Q1pyUURRWEVtMVEiLCJzZGtLZXkiOiJBYlhXS2VDTFJ5Q1pyUURRWEVtMVEiLCJtbiI6IjMyNzM1ODg2MTMiLCJyb2xlIjowLCJ0b2tlbkV4cCI6MTc0NDgxNjYxNywiaWF0IjoxNzQ0ODEzMDE3LCJleHAiOjE3NDQ4MTY2MTd9.Fj3TpAQ1jSdEFS71TJzyME2pYVDCRMx8JyEFY0e932Y"
      let authResult = authService.sdkAuth(authContext)
      print("Auth result: \(authResult)")
      result("Auth result: \(authResult)")

    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
