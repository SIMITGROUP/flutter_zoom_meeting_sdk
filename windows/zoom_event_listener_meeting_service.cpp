#include "zoom_event_listener_meeting_service.h"
#include <iostream>
#include "helper_enum.h"
#include "helper.h"

// Constructor: Calls the base class constructor
ZoomSDKEventListenerMeetingService::ZoomSDKEventListenerMeetingService()
    : ZoomSDKEventListenerBase() // Call the base class constructor
{
}

// Destructor: Calls the base class destructor
ZoomSDKEventListenerMeetingService::~ZoomSDKEventListenerMeetingService() {}

/// \param iResult Detailed reasons for special meeting status.
/// If the status is MEETING_STATUS_FAILED, the value of iResult is one of those listed in MeetingFailCode enum.
/// If the status is MEETING_STATUS_ENDED, the value of iResult is one of those listed in MeetingEndReason.
void ZoomSDKEventListenerMeetingService::onMeetingStatusChanged(ZOOM_SDK_NAMESPACE::MeetingStatus status, int iResult)
{
    const std::string tag = "onMeetingStatusChanged";
    sLog(tag, L"Status: " + std::to_wstring(status) + L", iResult: " + std::to_wstring(iResult));

    flutter::EncodableMap params;

    int failReason = 0;
    std::string failReasonName = "None";
    int endReason = 0;
    std::string endReasonName = "None";
    if (status == ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_FAILED)
    {
        failReason = iResult;
        failReasonName = EnumToString(static_cast<ZOOM_SDK_NAMESPACE::MeetingFailCode>(iResult));
    }
    else if (status == ZOOM_SDK_NAMESPACE::MeetingStatus::MEETING_STATUS_ENDED)
    {
        endReason = iResult;
        endReasonName = EnumToString(static_cast<ZOOM_SDK_NAMESPACE::MeetingEndReason>(iResult));
    }

    params[flutter::EncodableValue("status")] = flutter::EncodableValue(static_cast<int>(status));
    params[flutter::EncodableValue("statusName")] = flutter::EncodableValue(EnumToString(status));

    params[flutter::EncodableValue("failReason")] = flutter::EncodableValue(failReason);
    params[flutter::EncodableValue("failReasonName")] = flutter::EncodableValue(failReasonName);

    params[flutter::EncodableValue("endReason")] = flutter::EncodableValue(endReason);
    params[flutter::EncodableValue("endReasonName")] = flutter::EncodableValue(endReasonName);

    SendEvent(tag, params);
}

void ZoomSDKEventListenerMeetingService::onMeetingStatisticsWarningNotification(ZOOM_SDK_NAMESPACE::StatisticsWarningType type)
{
    const std::string tag = "onMeetingStatisticsWarningNotification";
    sLog(tag, L"StatisticsWarningType: " + std::to_wstring(type));

    flutter::EncodableMap params;

    params[flutter::EncodableValue("type")] = flutter::EncodableValue(static_cast<int>(type));
    params[flutter::EncodableValue("typeName")] = flutter::EncodableValue(EnumToString(type));

    SendEvent(tag, params);
}

void ZoomSDKEventListenerMeetingService::onMeetingParameterNotification(const ZOOM_SDK_NAMESPACE::MeetingParameter *meeting_param)
{
    const std::string tag = "onMeetingParameterNotification";
    sLog(tag, L"");

    flutter::EncodableMap params;

    SendEvent(tag, params);
}

void ZoomSDKEventListenerMeetingService::onSuspendParticipantsActivities()
{
    const std::string tag = "onSuspendParticipantsActivities";
    sLog(tag, L"");

    flutter::EncodableMap params;

    SendEvent(tag, params);
}

void ZoomSDKEventListenerMeetingService::onAICompanionActiveChangeNotice(bool bActive)
{
    const std::string tag = "onAICompanionActiveChangeNotice";
    sLog(tag, L"");

    flutter::EncodableMap params;

    SendEvent(tag, params);
}

void ZoomSDKEventListenerMeetingService::onMeetingTopicChanged(const zchar_t *sTopic)
{
    const std::string tag = "onMeetingTopicChanged";
    sLog(tag, L"");

    flutter::EncodableMap params;

    SendEvent(tag, params);
}

void ZoomSDKEventListenerMeetingService::onMeetingFullToWatchLiveStream(const zchar_t *sLiveStreamUrl)
{
    const std::string tag = "onMeetingFullToWatchLiveStream";
    sLog(tag, L"");

    flutter::EncodableMap params;

    SendEvent(tag, params);
}
