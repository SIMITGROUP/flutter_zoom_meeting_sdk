import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';
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
  String _platformVersion = 'Unknown';
  final _flutterZoomMeetingSdkPlugin = FlutterZoomMeetingSdk();

  final ZoomService _zoomService = ZoomService();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _zoomService.initEventListeners();
    _zoomService.getJWTToken();
  }

  @override
  void dispose() {
    _zoomService.dispose();
    super.dispose();
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
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _zoomService.getJWTToken(),
                  child: const Text('Fetch Custom Signature'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _zoomService.initZoom(),
                  child: const Text('Init Zoom'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _zoomService.authZoom(),
                  child: const Text('Auth Zoom'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _zoomService.joinMeeting(),
                  child: const Text('Join Meeting'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
