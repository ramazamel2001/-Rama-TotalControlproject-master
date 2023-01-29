import 'package:flutter/material.dart';
import 'package:pro1/Theme/theme_const.dart';
import 'launch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      title: 'Total Control',
      locale: Get.deviceLocale,
      home: const SafeArea(
        child: Launch(),
      ),
    );
  }
}

/*
Data needed for device, apps and websites are just the
time spent + name of the app and the website
TODO: team tasks{

    TODO mine:{
      chart & search (in progress with ahmad)
      login
       }
}


  Project updates:
    some of the packages we used are not the ones we need: 
      - Apps Usage package is not needed
    - the DeviceApps package has it's uninstall feature
    - we don't need more than revealing what are the apps that the child has on their device and this shall be done in the apps tab
    - i have prepared some search results from chatGPT
    - there are other packages that we need to use in our app that sserve the functionalities we want to build in our app:
      - these are the expected features:
        1- Time limits and usage restrictions: Allow parents to set time limits for different activities
          such as screen time, internet usage, and app usage.
        2- Content filtering: Allow parents to block certain websites, apps, and content that they consider
          inappropriate for their children.
        3- Location tracking: Allow parents to track their children's location and set geofencing rules to
          alert them when their children leave or enter a certain area.
        4- Activity monitoring: Allow parents to monitor their children's activity on their devices, including
          the apps they use, the websites they visit, and the messages they send and receive.
        5- Task and schedule management: Allow parents and children to create and manage tasks and schedules to
          help them stay organized and on track.
        6- Rewards and incentives: Allow parents to set rewards and incentives for completing tasks and staying
          within usage limits.
        7- Reporting and analytics: Provide parents with detailed reports and analytics on their children's device
          usage and activity.
        8- Multi-user support: Allow multiple users (parents, kids) to use the app and set different settings and
          rules for each user.
        9- Remote management: Allow parents to control and manage their children's devices remotely from their own
          devices.
        10- Support for multiple platforms: Make the app available for multiple platforms such as Android and iOS
      - with the needed packages:
        1- Time limits and usage restrictions: You can use the flutter_screen_time library to set time limits for
          different activities such as screen time, internet usage, and app usage.
        2- Content filtering: You can use the url_launcher package to block certain websites and apps that you
          consider inappropriate for your children, and also you can use the firebase_database to store the blocked
            URLs and check the current URL against it.
        3- Location tracking: You can use the geolocator package to track the location of the device and set geofencing
          rules to alert parents when their children leave or enter a certain area.
        4- Activity monitoring: You can use the device_info package to monitor the activity on the device, including
          the apps they use, the websites they visit, and the messages they send and receive.
        5- Task and schedule management: You can use the flutter_calendar_carousel package to create and manage tasks
          and schedules for parents and children.
        6- Rewards and incentives: You can use the shared_preferences package to store the rewards and incentives for
          completing tasks and staying within usage limits.
        7- Reporting and analytics: You can use the firebase_analytics package to provide parents with detailed reports
          and analytics on their children's device usage and activity.
        8- Multi-user support: You can use the firebase_auth package to allow multiple users (parents, kids) to use the
          app and set different settings and rules for each user.
        9- Remote management: You can use the firebase_database package to allow parents to control and manage their
          children's devices remotely from their own devices.

 */
