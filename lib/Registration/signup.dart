import 'package:flutter/material.dart';
import 'package:pro1/Registration/Child_Configurations//child_info.dart';
import 'package:pro1/Registration/account.dart';
import 'package:pro1/Theme/app_themes.dart';
import 'package:pro1/Theme/theme_const.dart';
import 'Child_Configurations/ParentLoginFromChild.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: background1,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Image.asset(
                    'media/images/TotalControl_Logo.png',
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Total Control',
                    style: TextStyle(
                        color: fontColor4,
                        fontWeight: FontWeight.w800,
                        fontSize: 55),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Account(),
                  ),
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginFromChild(),
                    ),
                  );
                },
                child: Text(
                  'Is this the child device?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: fontColor4,
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
