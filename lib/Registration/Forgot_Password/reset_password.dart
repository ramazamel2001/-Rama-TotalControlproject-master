import 'package:flutter/material.dart';
import 'package:pro1/Registration/login.dart';
import 'package:pro1/Theme/app_themes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // final GlobalKey<FormState> formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final TextEditingController _confirmedPasswordController =
      TextEditingController();
  final SnackBar successfulReset =
      const SnackBar(content: Text('Password Changed Successfully!'));
  final Map<String, String> _authData = {
    'email/username': '',
    'password': '',
  };
  bool allow = false;
  bool visible = false;

  String emailAddress = " ";

  void showReset() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('reset password'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'error occurred".',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      );

  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //GlobalMethods globalMethods = GlobalMethods();
  bool isloading = false;
  void submitForm() async {
    var formdata = formstate.currentState;
    FocusScope.of(context).unfocus();
    if (formdata!.validate()) {
      setState(() {
        isloading = true;
      });
      formdata.save();
      try {
        await _auth
            .sendPasswordResetEmail(email: emailAddress.trim().toLowerCase())
            .then((value) => Fluttertoast.showToast(
                msg: "An email has been sent",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0));

        Navigator.canPop(context) ? Navigator.pop(context) : null;
      } catch (error) {
        //globalMethods.authErrorHandle(erorr.message, context);
        showReset;
        print("error occured");
      } finally {
        setState(() {
          isloading = false;
        });
      }
    }
  }

  final Themes _themes = Themes();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formstate,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: appLogo(),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 775,
                  decoration: _themes.screenDecoration(context),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      _themes.title('Reset Password'),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'NOTE! Use the code provided in the verification email to reset your password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        // configure the comaparasion of the entered value and code given in the email and write it's code
                        keyboardType: TextInputType.number,
                        keyboardAppearance: Brightness.dark,
                        decoration: _themes
                            .textFormFieldDecoration('verification code'),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty || value.length != 6) {
                            setState(() {
                              allow = false;
                            });
                            if (value.isEmpty) {
                              return 'This field is required!';
                            } else {
                              return 'Invalid code';
                            }
                          } else {
                            setState(() {
                              allow = true;
                            });
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //new password text field
                        keyboardAppearance: Brightness.dark,
                        keyboardType: TextInputType.visiblePassword,
                        enabled: allow,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            if (value.isEmpty) {
                              return 'This field is required!';
                            } else {
                              return 'Short password';
                            }
                          }
                          return null;
                        },
                        controller: _passwordController,
                        onSaved: (newValue) {
                          setState(() {
                            _authData['password'] = newValue!;
                            _passwordController.text = newValue;
                          });
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
                            icon: Icon(
                              visible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: fontColor4,
                            ),
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                          ),
                        ),
                        obscureText: visible,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //Confirm password text field
                        keyboardAppearance: Brightness.dark,
                        enabled: allow,
                        controller: _confirmedPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(
                            color: fontColor4,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              visible
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: fontColor4,
                            ),
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                          ),
                        ),
                        obscureText: visible,
                        validator: (value) {
                          if (value!.isEmpty ||
                              value != _passwordController.text) {
                            if (value.isEmpty) {
                              return 'This field is required!';
                            } else {
                              return 'Password doesn\'t match';
                            }
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          setState(
                            () {
                              _authData['password'] = newValue!;
                              _confirmedPasswordController.text = newValue;
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        /**reset button */
                        onPressed: () {
                          final isValid = formstate.currentState!.validate();
                          if (isValid) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_passwordController.text != '')
                                    ? (context) => const Login()
                                    : ((context) => const ResetPassword()),
                              ),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(successfulReset);
                          }
                        },
                        child: _themes
                            .textButtonStyle(allow ? 'RESET' : 'VERIFY CODE'),
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
