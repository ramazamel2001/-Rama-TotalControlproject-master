/*import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseMessaging  _fcm = FirebaseMessaging.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // Send lock message to child device
              await _fcm.subscribeToTopic('Child-Device');
                _fcm.sendMessage("Child"{
                  'data': {
                    'action': 'lock',
                  },
                },
              );
            },
            child: Text('Lock Child Device'),
          ),
        ),
      ),
    );
  }
}

 */