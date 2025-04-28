const Map<String, String> actionMessages = {
  'MSG_INITIALIZED': 'Zoom SDK is initialized.',
  'MSG_INIT_SUCCESS': 'Zoom SDK initialization succeeded.',
  'MSG_INIT_FAILED': 'Zoom SDK initialization failed.',
  'MSG_NO_ARGS_PROVIDED': 'No arguments provided.',
  'MSG_NO_JWT_TOKEN_PROVIDED': 'No JWT token provided.',
  'MSG_AUTH_SENT_SUCCESS':
      'Authentication request sent successfully, listen onAuthenticationReturn for further action.',
  'MSG_AUTH_SENT_FAILED': 'Authentication request failed to send.',
  'MSG_MEETING_SERVICE_NOT_AVAILABLE': 'Meeting service is not available.',
  'MSG_JOIN_SENT_SUCCESS':
      'Join meeting request sent successfully, listen onMeetingStatusChanged for further action.',
  'MSG_JOIN_SENT_FAILED': 'Join meeting request failed to send.',
};

String getActionMessage(String code) {
  return actionMessages[code] ?? 'Unknown message: $code';
}
