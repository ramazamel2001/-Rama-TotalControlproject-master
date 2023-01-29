import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro1/Theme/app_themes.dart';

class ChildHomePage extends StatefulWidget {
  const ChildHomePage({Key? key}) : super(key: key);

  @override
  State<ChildHomePage> createState() => _ChildHomePageState();
}

class _ChildHomePageState extends State<ChildHomePage> {
  final Themes _themes = Themes();

  @override
  void initState() {
    super.initState();
  }

  bool notify = false;

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
                    Text(
                      'Username',
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
                  setState(() {
                    notify = true;
                  });
                  Get.snackbar(
                    'BedTime!',
                    'Time to go to sleep!',
                    duration: const Duration(seconds: 6),
                    icon: const Icon(
                      Icons.warning_amber,
                    ),
                    backgroundColor: background3.withOpacity(0.40),
                    titleText: Text(
                      'Hello!!!',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: fontColor3,
                      ),
                    ),
                    messageText: Text(
                      'You got A+!!',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: fontColor3,
                      ),
                    ),
                  );
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
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: _themes.screenDecoration(context),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: ListView(
            children: [
              const SizedBox(
                height: 60,
              ),
              InkWell(
                onTap: () {},
                child: Card(
                  elevation: 30,
                  shadowColor: shadowColor1,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40)),
                  ),
                  color: background4,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Daily Reminders',
                          style: TextStyle(
                            color: fontColor3,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Bed Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '8:00 PM',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Break Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '5:00 PM - 5:30 PM',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Do your homeworks',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '2:00 PM - 5:00 PM',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Play Time',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '5:30 PM',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

