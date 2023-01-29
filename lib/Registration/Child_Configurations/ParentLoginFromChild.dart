import 'package:flutter/material.dart';
import 'package:pro1/Registration/Forgot_Password/verify_email.dart';
import 'package:pro1/Registration/account.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pro1/Theme/app_themes.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../Home_Page/Parent_Version/parent_home.dart';
import '../../Home_Page/Single_User_Version/single_user_home.dart';
import 'child_info.dart';


class LoginFromChild extends StatefulWidget {
  const LoginFromChild({Key? key}) : super(key: key);

  @override
  State<LoginFromChild> createState() => _LoginState();
}

class _LoginState extends State<LoginFromChild> {
// user input stored for comparison with the data stored in the database
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();

  bool hidden = true;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  var mpassword, memail;
  final Themes _themes = Themes();

  signIn() async {
    await Firebase.initializeApp();
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: memail, password: mpassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          AwesomeDialog(
            context: context,
            title: "Erorr",
            body: const Text("No user found for that email."),
          ).show();
        } else if (e.code == 'wrong-password') {
          AwesomeDialog(
            context: context,
            title: "Erorr",
            body: const Text("Wrong password provided for that user."),
          ).show();
        }
      }
    } else {
      print("Not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: background1,
        body: Form(
          key: formstate,
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
                  decoration: _themes.screenLightDecoration(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      _themes.title('Parent Sing in'),
                      _themes.trailing('Sign in as a Parent to Continue'),
                      const SizedBox(
                        height: 70,
                      ),
                      TextFormField(
                        //email/username text field
                        style: TextStyle(
                          color: fontColor4,
                        ),
                        controller: _emailInput,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                        _themes.textFormFieldDecoration('Email/Username'),
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !value.contains('@') ||
                              !value.contains('.com') ||
                              value.length < 12) {
                            return 'Invalid email/username';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          memail = val;
                        },
                        // onSaved: (newValue) {
                        //_authData['email/username'] = newValue!;
                        // _emailInput.text = newValue;
                        //  },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        //password text field
                        controller: _passwordInput,
                        style: TextStyle(
                          color: fontColor4,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          // labelStyle: TextStyle(
                          //   color: fontColor4,
                          // ),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(30),
                          // ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hidden = !hidden;
                              });
                            },
                            color: background5,
                            icon: hidden
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off_outlined),
                          ),
                        ),
                        obscureText: hidden,
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Short password / Invalid password';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          mpassword = val;
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const VerifyEmail()),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.orange[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        /**Login button */
                        onPressed: () async {
                          UserCredential response = await signIn();
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final User? user = auth.currentUser;
                          final uid = user?.uid;
                          final ref = FirebaseDatabase.instance.ref();
                          final snapshot =
                          await ref.child('Users/$uid/User_Mode').get();
                          if (response != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_emailInput.text != '' &&
                                    _passwordInput.text != '')
                                    ? ((context) => const AppsListScreen())
                                    : ((context) => const LoginFromChild()),
                              ),
                            );
                          }
                          // final isValid = formKey.currentState!.validate();
                          //  if (isValid) {
                          //Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //  builder: (_emailInput.text != '' &&
                          //     _passwordInput.text != '')
                          //  ? (context) => const MyHomePage()
                          // : ((context) => const Login()),
                          // ),
                          //  );
                          //  getData;
                          //}
                        },
                        child: _themes.textButtonStyle('LOGIN'),
                      ),
                      Row(
                        /*Switch to Sign up */
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _themes.linkText1('New User?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => const Account()),
                                ),
                              );
                            },
                            child: _themes.linkText2('SIGN UP'),
                          ),
                        ],
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

//getter method to save the login user data/input
  }

