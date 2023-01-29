import 'package:flutter/material.dart';
import 'package:pro1/Registration/signup.dart' as t;
import 'dart:async';

import 'package:pro1/Theme/app_themes.dart';
import 'package:pro1/splash.dart';

class Launch extends StatefulWidget {
  const Launch({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<Launch> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    Duration duration = const Duration(seconds: 2);
    return Timer(
      duration,
      route,
    );
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Splash(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: background1,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'media/images/TotalControl_Logo.png',
                width: 250,
                height: 250,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Total Control',
                style: TextStyle(
                  color: fontColor4,
                  fontWeight: FontWeight.w800,
                  fontSize: 55,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
