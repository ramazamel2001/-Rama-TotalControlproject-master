import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pro1/Home_Page/app_tab.dart';
import 'package:pro1/Home_Page/website_tab.dart';
import 'package:pro1/Profile/profile.dart';
import 'package:pro1/Registration/choose_mode.dart';
import 'package:pro1/Registration/login.dart';
import 'package:pro1/Theme/app_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SingleUserHomePage extends StatefulWidget {
  const SingleUserHomePage({super.key});

  @override
  State<SingleUserHomePage> createState() => _SingleUserHomePageState();
}

bool flag2 = false;
class _SingleUserHomePageState extends State<SingleUserHomePage> {

  getUser(){
    User? user = FirebaseAuth.instance.currentUser;
    print(user!.email);
  }
  @override
  void initState() {
    getUser();
    setState(() {
      flag2 = true;
    });
    super.initState();
  }

  int currentIndex = 0;
  final List<StatefulWidget> _pages = [
    const App(),
    const Website(),
  ];

  double rating = 0;

  void showRating() => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            'Rate This App',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Please leave a 5 star rating.',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              buildRating(),
            ],
          ),
          actions: [
            ElevatedButton(
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
        itemSize: 46,
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
                onTap: () => Navigator.pushReplacement(
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
                  print(user!.email);
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          duration: const Duration(milliseconds: 50),
          color: background4,
          tabBackgroundColor: background4,
          tabs: const [
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
