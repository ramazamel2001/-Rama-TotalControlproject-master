import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:pro1/Home_Page/Parent_Version/parent_home.dart';
import 'package:pro1/Home_Page/device_tab.dart';
import 'package:pro1/Home_Page/report/report-making-app-main/report.dart';
import 'package:pro1/Theme/app_themes.dart';

class editnote extends StatefulWidget {
  editnote();

  @override
  _editnoteState createState() => _editnoteState();
}

class _editnoteState extends State<editnote> {
  @override
  void initState() {
    super.initState();
  }

  var appsExctracted = [];
  var usages = [];
  void extractData() {
    for (int i = 0; i < appsData['Apps Names'].length; i++) {
      ///print("${appsData['Apps Names'][i]}");
      appsExctracted[i] = appsData['Apps Names'][i];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background4,
        title: const Text('Apps'),
      ),
      body: FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: true,
          onlyAppsWithLaunchIntent: false,
        ),
        builder: (BuildContext context, AsyncSnapshot<List<Application>> data) {
          if (data.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            List<Application> apps = data.data!;

            return Scrollbar(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int position) {
                  Application app = apps[position];
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: app is ApplicationWithIcon
                              ? CircleAvatar(
                                  backgroundImage: MemoryImage(app.icon),
                                  backgroundColor: Colors.black12,
                                )
                              : null,
                          onTap: () {
                            print("${appsData['Child Name']}");
                            ///appsData.values.length
                            for (int i = 0; i < appsExctracted.length; i++) {
                              print("${appsExctracted[i]}");
                            }
                            onAppClicked(context, app);
                          },
                          title: Text("${appsData['Apps Names'][position]}"),
                          trailing: Text("${appsData['Apps Usages'][position]} seconds"),
                          subtitle: Text(
                            'System app: ${app.systemApp}',
                          ),
                        ),
                      ),
                      const Divider(
                        height: 3.0,
                        thickness: 2,
                      )
                    ],
                  );
                },
                itemCount: appsData['Apps Usages'].length,
              ),
            );
          }
        },
      ),
    );
  }

  void onAppClicked(BuildContext context, Application app) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(app.appName),
            actions: <Widget>[
              _AppButtonAction2(
                label: 'Open app',
                onPressed: () => app.openApp(),
              ),
              _AppButtonAction2(
                label: 'Open app settings',
                onPressed: () => app.openSettingsScreen(),
              ),
              _AppButtonAction2(
                label: 'Uninstall app',
                onPressed: () async => app.uninstallApp(),
              ),
            ],
          );
        });
  }
}

class _AppButtonAction2 extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _AppButtonAction2({required this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onPressed?.call();
        Navigator.of(context).maybePop();
      },
      child: Text(label),
    );
  }
}
