import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterZoomMeetingSdkPlugin = FlutterZoomMeetingSdk();
  String _log = '';
  String _authEvents = '';
  String _meetingEvents = '';
  StreamSubscription? _authSubscription;
  StreamSubscription? _meetingSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _initEventListeners();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    _meetingSubscription?.cancel();
    super.dispose();
  }

  void _initEventListeners() {
    // Listen to auth events
    _authSubscription = _flutterZoomMeetingSdkPlugin.onAuthEvent.listen((
      event,
    ) {
      setState(() {
        _authEvents += '\n${DateTime.now()}: $event';
      });
      print('Auth event: $event');

      _joinMeeting();
    });

    // Listen to meeting events
    _meetingSubscription = _flutterZoomMeetingSdkPlugin.onMeetingEvent.listen((
      event,
    ) {
      setState(() {
        _meetingEvents += '\n${DateTime.now()}: $event';
      });
      print('Meeting event: $event');
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await _flutterZoomMeetingSdkPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _initZoom() async {
    String? log = await _flutterZoomMeetingSdkPlugin.initZoom();
    setState(() {
      _log = log ?? '';
    });
  }

  Future<void> _authZoom() async {
    String? log = await _flutterZoomMeetingSdkPlugin.authZoom(
      jwtToken:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcHBLZXkiOiJBYlhXS2VDTFJ5Q1pyUURRWEVtMVEiLCJzZGtLZXkiOiJBYlhXS2VDTFJ5Q1pyUURRWEVtMVEiLCJtbiI6IjMyNzM1ODg2MTMiLCJyb2xlIjowLCJ0b2tlbkV4cCI6MTc0NDgxMzM2NywiaWF0IjoxNzQ0ODA5NzY3LCJleHAiOjE3NDQ4MTMzNjd9.AlbAETpb69ql83cRa9hEksAn7Ktn8Ec61N3NdY_swkI',
    );

    setState(() {
      _log = log ?? '';
    });
  }

  Future<void> _joinMeeting() async {
    String? log = await _flutterZoomMeetingSdkPlugin.joinMeeting();
    setState(() {
      _log = log ?? '';
    });
  }

  // Use the plugin's fetchZoomSignature function
  Future<void> _fetchSignature() async {
    const endpoint = "http://localhost:4000";
    const meetingNumber = "3273588613";
    const role = 0;

    final result = await _flutterZoomMeetingSdkPlugin.getJWTToken(
      authEndpoint: endpoint,
      meetingNumber: meetingNumber,
      role: role,
    );

    final signature = result?.token;

    if (signature != null) {
      print("Received signature: $signature");
      setState(() {
        _log = "Signature: $signature";
      });
    } else {
      print("Failed to get signature.");
      setState(() {
        _log = "Failed to get signature.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Running on: $_platformVersion\n'),
                Text(_log),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _fetchSignature(),
                  child: const Text('Fetch Custom Signature'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _initZoom(),
                  child: const Text('Init Zoom'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _authZoom(),
                  child: const Text('Auth Zoom'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _joinMeeting(),
                  child: const Text('Join Meeting'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Auth Events:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(child: Text(_authEvents)),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Meeting Events:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(child: Text(_meetingEvents)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
