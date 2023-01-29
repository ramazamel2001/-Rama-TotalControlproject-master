import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppsListScreen extends StatefulWidget {
  const AppsListScreen({super.key});

  @override
  _AppsListScreenState createState() => _AppsListScreenState();
}

class _AppsListScreenState extends State<AppsListScreen> {
  bool _showSystemApps = true;
  bool _onlyLaunchableApps = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your applications'),
      ),
      body: _AppsListScreenContent(
        includeSystemApps: true,
        onlyAppsWithLaunchIntent: false,
        key: GlobalKey(),
      ),
    );
  }
}

class _AppsListScreenContent extends StatelessWidget {
  final bool includeSystemApps;
  final bool onlyAppsWithLaunchIntent;

  const _AppsListScreenContent({
    Key? key,
    this.includeSystemApps = false,
    this.onlyAppsWithLaunchIntent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
          includeAppIcons: true,
          includeSystemApps: includeSystemApps,
          onlyAppsWithLaunchIntent: onlyAppsWithLaunchIntent),
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
                          onTap: () => onAppClicked(context, app),
                          title: Text(app.appName),
                          trailing: Text('Version:\n${app.versionName}'),
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
                itemCount: apps.length),
          );
        }
      },
    );
  }

  void onAppClicked(BuildContext context, Application app) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(app.appName),
            actions: <Widget>[
              _AppButtonAction(
                label: 'Open app',
                onPressed: () => app.openApp(),
              ),
              _AppButtonAction(
                label: 'Open app settings',
                onPressed: () => app.openSettingsScreen(),
              ),
              _AppButtonAction(
                label: 'Uninstall app',
                onPressed: () async => app.uninstallApp(),
              ),
            ],
          );
        });
  }
}

class _AppButtonAction extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _AppButtonAction({required this.label, this.onPressed});

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
