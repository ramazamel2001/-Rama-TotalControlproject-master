/*import 'package:flutter/material.dart';
import 'package:flutter_screen_time/flutter_screen_time.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _screenTime = 0;

  @override
  void initState() {
    super.initState();
    // Load the screen time
    _loadScreenTime();
  }

  // Load the screen time
  Future<void> _loadScreenTime() async {
    final int screenTime = await FlutterScreenTime.getTotalScreenTime;
    setState(() {
      _screenTime = screenTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Screen time: $_screenTime seconds'),
        ),
      ),
    );
  }
}

 */