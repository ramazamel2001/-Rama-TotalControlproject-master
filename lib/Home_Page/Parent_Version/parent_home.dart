import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pro1/Home_Page/app_tab.dart';
import 'package:pro1/Home_Page/device_tab.dart';
import 'package:pro1/Home_Page/website_tab.dart';
import 'package:pro1/Profile/profile.dart';
import 'package:pro1/Registration/choose_mode.dart';
import 'package:pro1/Registration/login.dart';
import 'package:pro1/Theme/app_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ParentHomePage extends StatefulWidget {
  const ParentHomePage({super.key});

  @override
  State<ParentHomePage> createState() => _ParentHomePageState();
}

bool flag1 = false;
class _ParentHomePageState extends State<ParentHomePage> {

  int currentIndex = 0;
  final List<StatefulWidget> _pages = [
    const Device(),
    const App(),
    const Website(),
  ];

  getUser(){
    User? user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }

  @override
  void initState() {
    getUser();
    setState(() {
      flag1 = true;
    });
    super.initState();
  }

  double rating = 0;

  void showRating() => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Rate This App',
            textAlign: TextAlign.center,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please leave a 5 star rating.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              buildRating(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildRating() => RatingBar.builder(
        initialRating: rating,
        maxRating: 1,
        itemSize: 35,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        updateOnDrag: true,
        onRatingUpdate: (rating) => setState(() {
          this.rating = rating;
        }),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          backgroundColor: Theme.of(context).drawerTheme.backgroundColor,
          child: Column(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
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
                  color: Theme.of(context).shadowColor,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
              ListTile(
                leading: Icon(
                  Icons.swap_horiz_sharp,
                  color: Theme.of(context).shadowColor,
                ),
                title: Text(
                  'Switch user mode',
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChooseMode(),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.feedback,
                  color: Theme.of(context).shadowColor,
                ),
                title: Text(
                  'Send Feedback',
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                ),
                onTap: () => showRating(),
              ),
              ListTile(
                leading: Icon(
                  Icons.notification_important,
                  color: Theme.of(context).shadowColor,
                ),
                title: Text(
                  'Send Notification',
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                ),
                onTap: () {
                  // Get.snackbar(
                  //   'Hello!!!',
                  //   'You got A+!!',
                  //   duration: const Duration(seconds: 6),
                  //   icon: const Icon(
                  //     Icons.warning_amber,
                  //   ),
                  //   backgroundColor: background3.withOpacity(0.40),
                  //   titleText: Text(
                  //     'Hello!!!',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w900,
                  //       fontSize: 18,
                  //       color: fontColor3,
                  //     ),
                  //   ),
                  //   messageText: Text(
                  //     'You got A+!!',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.w500,
                  //       fontSize: 15,
                  //       color: fontColor3,
                  //     ),
                  //   ),
                  // );
                },
              ),
              Divider(
                color: fontColor1,
              ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).shadowColor,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Theme.of(context).shadowColor,
                  ),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  var user = FirebaseAuth.instance.currentUser;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Login(),
                    ),
                  );
                },
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
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) => const ProfilePage()),
                    ),
                  );
                },
                icon: Icon(
                  Icons.person,
                  color: fontColor3,
                ),
              ),
            ),
          ],
        ),
        body: _pages[currentIndex],
        bottomNavigationBar: GNav(
          onTabChange: (index) => setState(() => currentIndex = index),
          backgroundColor:
              Theme.of(context).navigationBarTheme.backgroundColor!,
          selectedIndex: currentIndex,
          rippleColor: background1,
          hoverColor: background1,
          gap: 16,
          activeColor: background2,
          iconSize: 24,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          duration: const Duration(milliseconds: 50),
          color: background4,
          tabBackgroundColor: background4,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          tabs: const [
            GButton(
              icon: Icons.devices_other,
              text: 'Device',
            ),
            GButton(
              icon: Icons.app_registration,
              text: 'App',
            ),
            GButton(
              icon: Icons.web,
              text: 'Website',
            ),
          ],
        ),
      ),
    );
  }
}
