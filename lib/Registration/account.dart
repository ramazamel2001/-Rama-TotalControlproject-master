import 'package:flutter/material.dart';
import 'package:pro1/Registration/choose_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pro1/Registration/login.dart';
import 'package:pro1/Theme/app_themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_database/firebase_database.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final Themes _themes = Themes();
  DatabaseReference userRef = FirebaseDatabase.instance.ref();

  bool hidden = true;

//Capture user inputs
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  var musername, mpassword, memail, cpassword;

  signUp() async {
    await Firebase.initializeApp();
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: memail,
          password: mpassword,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          AwesomeDialog(
                  context: context,
                  title: "Erorr",
                  body: const Text("The password provided is too weak."))
              .show();
        } else if (e.code == 'email-already-in-use') {
          AwesomeDialog(
                  context: context,
                  title: "Error",
                  body:
                      const Text("The account already exists for that email."))
              .show();
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formstate,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        height: 20,
                      ),
                      _themes.title('SIGN UP'),
                      _themes.trailing('Welcome to On Time'),
                      const SizedBox(
                        height: 70,
                      ),
                      TextFormField(
                        //username text field
                        controller: _usernameController,
                        decoration: _themes.textFormFieldDecoration('Username'),
                        obscureText: false,
                        validator: (value) {
                          if (value!.length < 4) {
                            return 'Invalid username';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          musername = val;
                        },
                        //onSaved: (newValue) {
                        // _authData['username'] = newValue!;
                        //_usernameController.text = newValue;
                        // },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        //email text field
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _themes.textFormFieldDecoration('Email'),
                        obscureText: false,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !value.contains('@') ||
                              !value.contains('.com') ||
                              value.length < 12) {
                            return 'Invalid email';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          memail = val;
                        },
                        //onSaved: (newValue) {
                        // setState(() {
                        //_authData['email'] = newValue!;
                        //  _emailController.text = newValue;});
                        // },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        //password text field
                        validator: (value) {
                          if (value!.length < 6) {
                            return 'Short password';
                          }
                          return null;
                        },
                        controller: _passwordController,
                        onSaved: (val) {
                          mpassword = val;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: fontColor4,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        //Confirm password text field
                        controller: _confirmedPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            color: fontColor4,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
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
                          if (value != _passwordController.text) {
                            return 'Password doesn\'t match';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          cpassword = val;
                        },
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      TextButton(
                        /**Sign up button */
                        onPressed: () async {
                          UserCredential? response = await signUp();
                          FirebaseDatabase database = FirebaseDatabase.instance;
                          DatabaseReference ref =
                              FirebaseDatabase.instance.ref().child('Users');
                          String? uid = response?.user?.uid;
                          ref.child(uid!).set({
                            "Name": musername,
                            "User_Type": "Normal",
                            "User_Mode": "0"
                          });
                          if (response != null) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_emailController.text != '' &&
                                        _passwordController.text != '' &&
                                        _usernameController.text != '')
                                    ? (context) => const ChooseMode()
                                    : ((context) => const Account()),
                              ),
                            );
                          } else {
                            print("signup is field");
                          }
                        },
                        child: _themes.textButtonStyle('SIGN UP'),
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _themes.linkText1('ALREADY A MEMBER?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ),
                                  );
                                  getData;
                                },
                                child: _themes.linkText2('LOGIN'),
                              ),
                            ],
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

//Getter method to save sign-up user data/input
  get getData async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', _usernameController.text);
    prefs.setString('user', _emailController.text);
    prefs.setString('password', _passwordController.text);
  }
}
