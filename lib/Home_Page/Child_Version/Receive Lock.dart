import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_lock_screen/flutter_lock_screen.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    // Set up FCM
    //_fcm.requestNotificationPermissions();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.data['data']['action'] == 'lock') {
        return;
      }

      screenLock(
        context: context,
        correctString: '1234',
      );

    });

    // Subscribe to the child-device topic
    _fcm.subscribeToTopic('child-device');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Child Device'),
        ),
      ),
    );
  }
}
/*
firebase_messaging: any
  flutter_lock_screen: any
  flutter_screen_lock: any
 */