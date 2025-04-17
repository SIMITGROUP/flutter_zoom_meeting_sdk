struct StandardZoomMeetingResponse {
    let success: Bool
    let message: String
    let code: UInt32

    func toDictionary() -> [String: Any] {
        return [
            "success": success,
            "message": message,
            "code": code
        ]
    }
}