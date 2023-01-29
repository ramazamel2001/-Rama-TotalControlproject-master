import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'dart:core';

import 'package:pro1/Home_Page/apps_config/apps_data/apps_list.dart';


/*
Note: TODO
    To represent user statistics through the chart we need 6 charts to represent data:
  A- child: (do it with ahmad)
    2. apps chart
  B- single user:
    2. apps

    So make sure you create the needed data maps and add dynamic functionality for updating the content of each map
 */

class ChartData {
  // List<int> durationInSecondsFilter() {
  //   List<int> rawData = rawData.map((e) => e.usage.inSeconds).toList();
  //   return rawData;
  //}
  //List<int> duration = rawData!.map((e) => e.usage.inSeconds).toList();
  Map<String, double> appData = {
    'top1': 10,
    'top2': 10,
    'top3': 10,
    'top4': 10,
    'top5': 10,
    'others': 50,
  };

  Map<String, double> websitesDataMap = {
    'top1': 16,
    'top2': 10,
    'top3': 13,
    'top4': 13,
    'top5': 13,
    'others': 35,
  };

  ///child data
  Map<String, double> childDeviceDataMap = {
    'Solo Learn': 5,
    'Lego Land': 25,
    'others': 70,
  };

  Map<String, double> childWebData = {
    'Youtube': 5,
    'E-Learning': 35,
    'SoloLearn': 20,
    'others': 40,
  };

  List<Color> colorList = [
    const Color.fromRGBO(150, 240, 125, 1),
    const Color.fromRGBO(60, 133, 150, 1),
    const Color.fromRGBO(220, 170, 198, 1),
    const Color.fromRGBO(190, 110, 28, 1),
    const Color.fromRGBO(20, 110, 28, 1),
  ];
}

///single user data
// List<AppUsageInfo>? rawData = chartData;
//
// ///here i will extract the top 5 apps from the list
// List<int> topFiveAppsUsagesList = [];
// List<int> appsUsagesList = [];
// List<String> topFiveAppsNamesList = [];
//
// ///List<String> appsNamesList = [];
// void topFiveAppsFilter() {
//   for (int i = 0; i < topFiveAppsUsagesList.length; i++) {
//     if (topFiveAppsUsagesList[i] == rawData![i].usage.inSeconds) {
//       topFiveAppsNamesList[i] = rawData![i].appName;
//     }
//   for (int i = 0; i < rawData!.length; i++) {
//     appsUsagesList[i] = rawData![i].usage.inSeconds;
//   }
//   appsUsagesList.sort((a, b) => b - a);
//   topFiveAppsUsagesList = appsUsagesList..take(5);
//   }
// }
//
// List<int> calculateUsageSummary(List<int> raw) {
//   for (int i = 0; i < raw.length; i++) {
//     raw[i] = (raw[i] * 60 * 60 / 18 * 100).toInt();
//   }
//   return raw;
// }
//
// Map<String, double> getAppChartData() {
//   topFiveAppsUsagesList = calculateUsageSummary(topFiveAppsUsagesList);
//   Map<String, double> data = {
//     topFiveAppsNamesList[0]: topFiveAppsUsagesList[0].toDouble(),
//     topFiveAppsNamesList[1]: topFiveAppsUsagesList[1].toDouble(),
//     topFiveAppsNamesList[2]: topFiveAppsUsagesList[2].toDouble(),
//     topFiveAppsNamesList[3]: topFiveAppsUsagesList[3].toDouble(),
//     topFiveAppsNamesList[4]: topFiveAppsUsagesList[4].toDouble(),
//     'others': 60,
//   };
//   return data;
// }
