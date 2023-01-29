import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UsageSummaryScreen extends StatefulWidget {
  const UsageSummaryScreen({Key? key}) : super(key: key);

  @override
  State<UsageSummaryScreen> createState() => _UsageSummaryScreenState();
}

class _UsageSummaryScreenState extends State<UsageSummaryScreen> {
  List<AppUsageInfo> _infos = [];

  @override
  void initState() {
    getUsageStats();
    super.initState();
  }

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(const Duration(hours: 1));
      List<AppUsageInfo> infoList =
          await AppUsage().getAppUsage(startDate, endDate);
      setState(
        () => _infos = infoList,
      );

      for (var info in infoList) {
        print(info.toString());
      }
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    String timeSet(
      int hrs,
      int mins,
      int seconds,
    ) {
      String set = "${hrs != 0 ? '$hrs hrs : ' : ''}"
          "${mins % 60 != 0 ? '${mins % 60} m : ' : ''}"
          "${seconds % 60 != 0 ? '${seconds % 60} s' : ''}";
      return set;
    }

    double calulateTimeConsumedPercentage(int timeSpent) {
      final double timeConsumedPercentage =
          ((timeSpent / (60 * 60 * 16)) * 100).roundToDouble() / 100;
      return timeConsumedPercentage;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Summary'),
          actions: [
            IconButton(
              onPressed: () => setState(
                () => getUsageStats,
              ),
              icon: const Icon(
                Icons.refresh,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: _infos.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_infos[index].appName),
                trailing: Text(
                  timeSet(
                    _infos[index].usage.inHours,
                    _infos[index].usage.inMinutes,
                    _infos[index].usage.inSeconds,
                  ),
                ),
                subtitle: LinearPercentIndicator(
                  width: 180.0,
                  lineHeight: 15.0,
                  percent: calulateTimeConsumedPercentage(
                    _infos[index].usage.inSeconds,
                  ),
                  center: Text(
                    "${(calulateTimeConsumedPercentage(_infos[index].usage.inSeconds) * 100).toInt()} %",
                    style: new TextStyle(fontSize: 12.0),
                  ),
                  barRadius: const Radius.circular(25),
                  backgroundColor: Colors.grey,
                  progressColor: Colors.blue,
                  animation: true,
                  animationDuration: 1000,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
