import 'package:flutter/material.dart';
import 'package:pro1/Theme/app_themes.dart';

class NotificationsMainPage extends StatefulWidget {
  const NotificationsMainPage({Key? key}) : super(key: key);

  @override
  State<NotificationsMainPage> createState() => _NotificationsMainPageState();
}

class _NotificationsMainPageState extends State<NotificationsMainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: background4,
        drawer: Drawer(
          backgroundColor: background1,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: background2,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: 100,
                      color: fontColor1,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Username',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: fontColor1,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: fontColor1,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: fontColor1,
                  ),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(
                  Icons.dark_mode_outlined,
                  color: fontColor1,
                ),
                title: Text(
                  'Turn On/Off dark mode',
                  style: TextStyle(
                    color: fontColor1,
                  ),
                ),
                onTap: () => {},
              ),
              ListTile(
                leading: Icon(
                  Icons.translate_sharp,
                  color: fontColor1,
                ),
                title: Text(
                  'Change language',
                  style: TextStyle(
                    color: fontColor1,
                  ),
                ),
                onTap: () => {},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: background4,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: fontColor3,
                ),
              );
            },
          ),
        ),
        body: null,
      ),
    );
  }
}
