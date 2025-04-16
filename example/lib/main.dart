import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_zoom_meeting_sdk/flutter_zoom_meeting_sdk.dart';

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

  @override
  void initState() {
    super.initState();
    initPlatformState();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            children: [
              Text('Running on: $_platformVersion\n'),
              Text(_log),
              ElevatedButton(
                onPressed: () => _initZoom(),
                child: const Text('Init Zoom'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _authZoom(),
                child: const Text('Auth Zoom'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
