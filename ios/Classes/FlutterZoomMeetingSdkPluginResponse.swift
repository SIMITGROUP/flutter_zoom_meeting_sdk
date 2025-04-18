struct StandardZoomMeetingResponse {
  let success: Bool
  let message: String
  let statusCode: UInt32
  let statusText: String

  func toDictionary() -> [String: Any] {
    return [
      "success": success,
      "message": message,
      "statusCode": statusCode,
      "statusText": statusText,
    ]
  }
}

struct StandardZoomMeetingEventResponse {
  let event: String
  let success: Bool
  let message: String
  let statusCode: UInt32
  let statusText: String

  func toDictionary() -> [String: Any] {
    return [
      "event": event,
      "success": success,
      "message": message,
      "statusCode": statusCode,
      "statusText": statusText,
    ]
  }
}

struct ZoomMeetingStatusChangeEventResponse {
  let event: String
  let meetingStatus: UInt32
  let meetingStatusText: String
  let meetingError: UInt32
  let meetingErrorText: String
  let endMeetingReason: UInt32
  let endMeetingReasonText: String

  func toDictionary() -> [String: Any] {
    return [
      "event": event,
      "meetingStatus": meetingStatus,
      "meetingStatusText": meetingStatusText,
      "meetingError": meetingError,
      "meetingErrorText": meetingErrorText,
      "endMeetingReason": endMeetingReason,
      "endMeetingReasonText": endMeetingReasonText,
    ]
  }
}
