import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pro1/Home_Page/Parent_Version/parent_home.dart';
import 'package:pro1/Home_Page/Single_User_Version/single_user_home.dart';
import 'package:pro1/Registration/login.dart';
import 'package:pro1/Theme/app_themes.dart';

class ChooseMode extends StatefulWidget {
  const ChooseMode({super.key});

  @override
  State<ChooseMode> createState() => _ChooseModeState();
}

// in this variable the user role/mode will be saved
String userMode = '';
int userIndex = -1;

class _ChooseModeState extends State<ChooseMode> {
  final Themes _themes = Themes();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appLogo(),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.all(30),
                  height: 775,
                  width: double.infinity,
                  decoration: _themes.screenDecoration(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _themes.title('CHOOSE MODE'),
                      _themes.trailing(
                        'Please choose your default user type',
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      IconButton(
                        /*
                        when ever the user clicks
                        the image of the user mode -for easier use-
                        the user will be redirected to the home page
                        of the app according to user mode chosen
                        */
                        onPressed: () {
                          setState(() {
                            userIndex = 0;
                            userMode = 'family';
                            assiginModeToDatabase(userMode);
                          });
                          //use this statement to check if the value is stored
                          //print(userMode);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const Login(),
                            ),
                          );
                        },
                        icon: Image.asset(
                          'media/images/parents_portrait_transparent.png',
                        ),
                        iconSize: 250,
                      ),
                      Text(
                        'Parent (Family)',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      IconButton(
                        /*
                        when ever the user clicks
                        the image of the user mode -for easier use-
                        the user will be redirected to the home page
                        of the app according to user mode chosen
                        */
                        onPressed: () {
                          setState(() {
                            userIndex = 1;
                            userMode = 'personal';
                            assiginModeToDatabase(userMode);
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        icon: Image.asset('media/images/User.png'),
                        iconSize: 250,
                      ),
                      Text(
                        'Personal',
                        style: TextStyle(
                          color: Colors.orange[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
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

void assiginModeToDatabase<Widget>(userMode) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child("Users");
  await ref.child("$uid/User_Mode").set(userMode);
}
