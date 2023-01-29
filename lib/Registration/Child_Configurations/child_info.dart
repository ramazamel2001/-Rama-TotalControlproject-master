import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pro1/Home_Page/Child_Version/Child_Widgets/Code_Config/code_generator.dart';
import 'package:pro1/Theme//app_themes.dart';
import 'package:device_apps/device_apps.dart';
import 'package:app_usage/app_usage.dart';
import 'package:device_info_plus/device_info_plus.dart';

final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

class AppsListScreen extends StatefulWidget {
  const AppsListScreen({super.key});

  @override
  _AppsListScreenState createState() => _AppsListScreenState();
}

class _AppsListScreenState extends State<AppsListScreen> {
  bool _showSystemApps = true;
  bool _onlyLaunchableApps = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _AppsListScreenContent(
        includeSystemApps: _showSystemApps,
        onlyAppsWithLaunchIntent: _onlyLaunchableApps,
        key: GlobalKey(),
      ),
    );
  }
}

class _AppsListScreenContent extends StatefulWidget {
  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;

  _AppsListScreenContent({
    Key? key,
    this.includeSystemApps = true,
    this.onlyAppsWithLaunchIntent = false,
  }) : super(key: key);

  @override
  State<_AppsListScreenContent> createState() => _AppsListScreenContentState();
}

List<AppUsageInfo>? chartData;
List<AppUsageInfo> UsageInfo = [];
List<Application> Applications = [];

class _AppsListScreenContentState extends State<_AppsListScreenContent> {
  List<AppUsageInfo> infos = [];

  @override
  void initState() {
    getUsageStats();
    super.initState();
  }

  void getUsageStats() async {
    try {
      DateTime endDate = DateTime.now();
      DateTime startDate = endDate.subtract(
        const Duration(
          hours: 1,
        ),
      );
      List<AppUsageInfo> infoList = await AppUsage().getAppUsage(
        startDate,
        endDate,
      );
      setState(
        () {
          infos = infoList;
          UsageInfo = infoList;
        },
      );
      for (var info in infoList) {
        print(
          info.toString(),
        );
      }
    } on AppUsageException catch (exception) {
      print(
        exception,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String timeSet(
      int hrs,
      int mins,
      int seconds,
      List<AppUsageInfo> list,
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

    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: widget.includeSystemApps,
          onlyAppsWithLaunchIntent: widget.onlyAppsWithLaunchIntent),
      builder: (BuildContext context, data) {
        if (data.data == null) {
          return const Center(child: CircularProgressIndicator());
        } else {
          List<Application> apps = data.data!;
          Applications = data.data!;
          return ChildInformation(apps);
        }
      },
    );
  }
}

class ChildInformation extends StatefulWidget {
  final List<Application>? appsSata;
  const ChildInformation(
    this.appsSata, {
    Key? key,
  }) : super(key: key);
  @override
  State<ChildInformation> createState() => _ChildInformationState();

  final String Code = '';
}

String code = '';

class _ChildInformationState extends State<ChildInformation> {
  final GlobalKey<FormState> formkey = GlobalKey();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _age = TextEditingController();

  final Themes _themes = Themes();
  //final ChildInformation obj = new ChildInformation();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: appLogo(),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 775,
                  decoration: _themes.screenDecoration(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 30,
                      ),
                      _themes.title('Enter the Child Information'),
                      const SizedBox(
                        height: 70,
                      ),
                      TextFormField(
                        /*name text field*/
                        controller: _name,
                        keyboardType: TextInputType.name,
                        keyboardAppearance: Brightness.dark,
                        decoration:
                            _themes.textFormFieldDecoration('Child Name'),
                        obscureText: false,
                        validator: (value) {
                          var childn = value;
                          if (value!.isEmpty || value.length < 3) {
                            return 'Invalid name';
                          }
                          return null;
                        },
                        onSaved: (newValue) =>
                            setState(() => _name.text = newValue!),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        /*age field*/
                        controller: _age,
                        keyboardType: TextInputType.number,
                        keyboardAppearance: Brightness.dark,
                        decoration:
                            _themes.textFormFieldDecoration(' Child Age'),
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty || value.length >= 3) {
                            return 'Invalid age';
                          }
                          return null;
                        },
                        onSaved: (newValue) =>
                            setState(() => _age.text = newValue!),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        /**save button */
                        onPressed: () async {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final User? user = auth.currentUser;
                          final uid = user?.uid;

                          var Model = await deviceInfoPlugin.androidInfo;
                          var ModelIOS = await deviceInfoPlugin.iosInfo;
                          var brand = Model.brand;
                          var physical = Model.isPhysicalDevice;
                          var hardware = Model.hardware;
                          var model = Model.model;
                          var features = Model.systemFeatures;
                          var type = Model.type;
                          var androidV = Model.version;

                          FirebaseDatabase database = FirebaseDatabase.instance;
                          DatabaseReference ref = FirebaseDatabase.instance
                              .ref()
                              .child("Users/$uid/Children");

                          Random random = new Random();
                          int randomNumber = random.nextInt(10000);
                          String randID = randomNumber.toString();
                          ref.child(randID).set({
                            "Child Name": _name.text,
                          });

                          setState(() {
                            code = randID;
                          });

                          DatabaseReference ref2 = FirebaseDatabase.instance
                              .ref()
                              .child("Users/$uid/Children");
                          ref2
                              .child(randID)
                              .child('Brand')
                              .set({'brand': brand});

                          DatabaseReference ref6 = FirebaseDatabase.instance
                              .ref()
                              .child("Users/$uid/Children");
                          ref6
                              .child(randID)
                              .child('AndroidVersion')
                              .set({'android': androidV.release});

                          DatabaseReference ref7 = FirebaseDatabase.instance
                              .ref()
                              .child("Users/$uid/Children");
                          ref7
                              .child(randID)
                              .child('Model')
                              .set({'model': model});

                          DatabaseReference ref3 = FirebaseDatabase.instance
                              .ref()
                              .child("Users/$uid/Children");
                          ref3
                              .child(randID)
                              .child('Apps Names')
                              .set(Applications.map((e) => e.appName).toList());

                          DatabaseReference ref4 = FirebaseDatabase.instance
                              .ref()
                              .child("Users/$uid/Children");
                          ref4.child(randID).child('System App').set(
                              Applications.map((e) => e.systemApp).toList());

                          DatabaseReference ref5 = FirebaseDatabase.instance
                              .ref()
                              .child("Users/$uid/Children");
                          ref5.child(randID).child('Apps Usages').set(
                              UsageInfo.map((e) => e.usage.inSeconds).toList());

                          final isValid = formkey.currentState!.validate();
                          if (isValid) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_name.text != '' && _age.text != '')
                                    ? (context) => CodeGenerator()
                                    : ((context) =>
                                        const ChildInformation(null)),
                              ),
                            );
                          }
                        },
                        child: _themes.textButtonStyle('SAVE'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*appBar: AppBar(
        title: const Text('Apps List'),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<String>>[
                const PopupMenuItem<String>(
                  value: 'system_apps',
                  child: Text('Toggle system apps'),
                ),
                const PopupMenuItem<String>(
                  value: 'launchable_apps',
                  child: Text('Toggle launchable apps only'),
                )
              ];
            },
            onSelected: (String key) {
              if (key == 'system_apps') {
                setState(
                  () {
                    _showSystemApps = !_showSystemApps;
                  },
                );
              }
              if (key == 'launchable_apps') {
                setState(
                  () {
                    _onlyLaunchableApps = !_onlyLaunchableApps;
                  },
                );
              }
            },
          )
        ],
      ),*/
/*
  setState(() {
            Applications = apps;
          });
   */

/*
Scrollbar(/*UI part*/
            child: ListView.builder(
                itemBuilder: (BuildContext context, int position) {
                  Application app = apps[position];
                  return Column(
                    children: <Widget>[
                      ListTile(
                        leading: app is ApplicationWithIcon
                            ? CircleAvatar(
                                backgroundImage: MemoryImage(app.icon),
                                backgroundColor: Colors.transparent,
                              )
                            : null,
                        onTap: () => onAppClicked(context, app),
                        title: Text(app.appName),
                        subtitle: position >= infos.length
                            ? null
                            : LinearPercentIndicator(
                                width: 140.0,
                                lineHeight: 20.0,
                                percent: position >= infos.length
                                    ? 0.0
                                    : infos[position].appName.toLowerCase() ==
                                            app.appName
                                        ? calulateTimeConsumedPercentage(
                                            infos[position].usage.inSeconds,
                                          )
                                        : 0.0,
                                center: Text(
                                  position >= infos.length &&
                                          infos[position].toString().isEmpty
                                      ? ""
                                      : "${(calulateTimeConsumedPercentage(infos[position].usage.inSeconds) * 100).toInt()}%",
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    color: fontColor3,
                                  ),
                                ),
                                barRadius: const Radius.circular(25),
                                backgroundColor: Colors.grey,
                                progressColor: Colors.blue,
                                animation: true,
                                animationDuration: 1000,
                              ),
                        trailing: position >= infos.length
                            ? null
                            : Text(
                                position >= infos.length
                                    ? ' '
                                    : timeSet(
                                        infos[position].usage.inHours,
                                        infos[position].usage.inMinutes,
                                        infos[position].usage.inSeconds,
                                        UsageInfo = infos,
                                      ),
                              ),
                      ),
                      const Divider(
                        thickness: 2.0,
                        indent: 10,
                        endIndent: 10,
                      )
                    ],
                  );
                },
                itemCount: apps.length),
          )
 */
/*UI part*/
// void onAppClicked(BuildContext context, Application app) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(app.appName),
//           actions: <Widget>[
//             _AppButtonAction(
//               label: 'Open app',
//               onPressed: () => app.openApp(),
//             ),
//             _AppButtonAction(
//               label: 'Open app settings',
//               onPressed: () => app.openSettingsScreen(),
//             ),
//             _AppButtonAction(
//               label: 'Uninstall app',
//               onPressed: () async => app.uninstallApp(),
//             ),
//           ],
//         );
//       });
// }
/*UI part*/
// class _AppButtonAction extends StatelessWidget {
//   final String label;
//   final VoidCallback? onPressed;
//
//   const _AppButtonAction({required this.label, this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: () {
//         onPressed?.call();
//         Navigator.of(context).maybePop();
//       },
//       child: Text(label),
//     );
//   }
// }
