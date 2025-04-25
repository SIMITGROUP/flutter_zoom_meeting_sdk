import 'package:flutter/material.dart';
import 'package:flutter_zoom_meeting_sdk_example/meeting_card_list.dart';
import 'package:flutter_zoom_meeting_sdk_example/zoom_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ZoomService _zoomService = ZoomService();

  @override
  void initState() {
    super.initState();
    _zoomService.initZoom();
    _zoomService.initEventListeners();
  }

  @override
  void dispose() {
    _zoomService.dispose();
    super.dispose();
  }

  final List<Map<String, String>> meetingData = [
    {
      'meetingNumber': '3273588613',
      'password': '6SuCMB',
      'displayName': 'John Doe',
    },
    {
      'meetingNumber': '98667185101',
      'password': 'QI8xbfyBFqt5h2lqrOYJf3e7JXNFjY.1',
      'displayName': 'John Doe',
      'webinarToken':
          '3U-fmkgKTk9AdPczv7AstfKsFNHRlmbEI_3gdKSe6kE.DQcAAAAW-QXDzRYtYV9tZEFMUlJjLTFrUm82Wmo2RjlnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
    },
    {
      'meetingNumber': '81905298441',
      'password': 'PAJyyCw8jrnftFASg9IAzJ2WFSHz7Q.1',
      'displayName': 'Yong JH',
      'webinarToken':
          'u9D6MKUReBvGBPIkjfVSIPHLvXHStOvtrgDHqafw0gM.DQcAAAATEe-sCRZBbmExR0taWlRrbTJ5V2J0eXQ5d2dnAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
    },
  ];

  void joinMeeting(Map<String, String> meeting) {
    _zoomService.setMeetingNumber(meeting['meetingNumber'] ?? '');
    _zoomService.setPassCode(meeting['password'] ?? '');
    _zoomService.setUserName(meeting['displayName'] ?? '');
    _zoomService.setWebinarToken(meeting['webinarToken']);

    _zoomService.authZoom();
    // Trigger join meeting in event listener
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: MeetingCardList(data: meetingData, onJoinPressed: joinMeeting),
      ),
    );
  }
}
