enum StatusZoomError {
  success,
  invalidArguments,
  illegalAppKeyOrSecret,
  networkIssue,
  clientIncompatible,
  jwtTokenWrong,
  keyOrSecretError,
  accountNotSupport,
  accountNotEnableSdk,
  limitExceededException,
  deviceNotSupported,
  unknown,
  domainDontSupport,
  timeout,
  keyOrSecretWrong,
  keyOrSecretEmpty,
  serviceBusy,
  none,
  undefined,
}

const Map<String, StatusZoomError> statusMap = {
  // android, mac, ios, windows
  'SUCCESS': StatusZoomError.success,
  // android, mac, ios, windows
  'NETWORK_ISSUE': StatusZoomError.networkIssue,
  // android, mac, ios, windows
  'CLIENT_INCOMPATIBLE': StatusZoomError.clientIncompatible,
  // android, mac, ios, windows
  'JWT_TOKEN_WRONG': StatusZoomError.jwtTokenWrong,
  // android, mac, ios, windows
  'ACCOUNT_NOT_SUPPORT': StatusZoomError.accountNotSupport,
  // android, mac, ios, windows
  'ACCOUNT_NOT_ENABLE_SDK': StatusZoomError.accountNotEnableSdk,
  // android, mac, ios, windows
  'LIMIT_EXCEEDED_EXCEPTION': StatusZoomError.limitExceededException,
  // android, mac, ios, windows
  'UNKNOWN': StatusZoomError.unknown,
  // android, mac, ios, windows
  'UNDEFINED': StatusZoomError.undefined,
  // android
  'ILLEGAL_APP_KEY_OR_SECRET': StatusZoomError.illegalAppKeyOrSecret,
  // android
  'KEY_OR_SECRET_ERROR': StatusZoomError.keyOrSecretError,
  // android
  'INVALID_ARGUMENTS': StatusZoomError.invalidArguments,
  // android
  'DEVICE_NOT_SUPPORTED': StatusZoomError.deviceNotSupported,
  // android
  'DOMAIN_DONT_SUPPORT': StatusZoomError.domainDontSupport,
  // mac, ios, windows
  'TIMEOUT': StatusZoomError.timeout,
  // mac, ios, windows
  'KEY_OR_SECRET_WRONG': StatusZoomError.keyOrSecretWrong,
  // mac, ios, windows
  'KEY_OR_SECRET_EMPTY': StatusZoomError.keyOrSecretEmpty,
  // ios, windows
  'SERVICE_BUSY': StatusZoomError.serviceBusy,
  // ios, windows
  'NONE': StatusZoomError.none,
};

extension StatusZoomErrorMapper on StatusZoomError {
  static StatusZoomError fromString(String status) {
    return statusMap[status.toUpperCase()] ?? StatusZoomError.undefined;
  }
}
