import 'dart:async';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pro1/Registration/login.dart';
import 'package:pro1/Theme/app_themes.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _emailInput = TextEditingController();
  final Map<String, String> _authData = {
    'email/username': '',
    'password': '',
  };
  final Themes _themes = Themes();
  final GlobalKey<FormState> formKey = GlobalKey();

  late Timer _timer;
  bool canResendEmail = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final user = FirebaseAuth.instance.currentUser;
        if (user?.emailVerified ?? false) {
          timer.cancel();
          Navigator.pop(context, true);
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _emailInput.dispose();

    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      // Utils.showSnackBar(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailInput.text.trim());
      //Utils.showSnackBar('Password Reset Email Sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password Reset Email Sent'),
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
      // مؤقتا خليها هيك
    } on FirebaseAuthException catch (e) {
      print(e);
      //Utils.showSnackBar('e.message');
      // برضه مؤقتا خليها هيك...
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Form(
            key: formKey,
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
                        Row(
                          /* Close button */
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.close_outlined,
                                color: background4,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          /* white space */
                          height: 30,
                        ),
                        Column(
                          /* Header */
                          children: [
                            _themes.title('Reset Password'),
                            _themes.trailing(
                                'Enter your email to receive a message and reset your password'),
                          ],
                        ),
                        const SizedBox(
                          /* white space */
                          height: 70,
                        ),
                        TextFormField(
                          /* Email text field to enter the verification email used to reset the password */
                          controller: _emailInput,
                          keyboardType: TextInputType.emailAddress,
                          keyboardAppearance: Brightness.dark,
                          decoration: _themes.textFormFieldDecoration('Email'),
                          obscureText: false,
                          validator: (email) =>
                              email != null && !EmailValidator.validate(email)
                                  ? 'Enter a valid email'
                                  : null,
                          onSaved: (newValue) {
                            _authData['email/username'] = newValue!;
                            _emailInput.text = newValue;
                          },
                        ),
                        const SizedBox(
                          /* white space */
                          height: 30,
                        ),
                        TextButton(
                          /* send verification message button */
                          onPressed: () {
                            canResendEmail ? sendVerificationEmail() : null;
                            final isValid = formKey.currentState!.validate();
                            if (isValid) {
                              resetPassword();
                              /*ScaffoldMessenger.of(context).showSnackBar(verificationMessage);*/
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_emailInput.text != '')
                                      ? (context) => const Login()
                                      : (context) => const VerifyEmail(),
                                ),
                              );
                            }
                          },
                          child: _themes.textButtonStyle('Send message'),
                        ),
                        /*

                         */
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

/*
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../app_themes.dart';                                                                               
import 'package:email_validator/email_validator.dart';
import 'package:basic_utils/basic_utils.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  // final GlobalKey<FormState> formKey = GlobalKey();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

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

  //String emailAddress = " ";

  /* void showReset() => showDialog(
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
  );*/
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  /* GlobalKey<FormState> formstate = GlobalKey<FormState>();
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
  }*/
  final Themes _themes = Themes();

  Future verifyEmail() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      //Utils.showSnackBar('Password Reset Email Sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password Reset Email Sent'),
        ),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
      // مؤقتا خليها هيك
    } on FirebaseAuthException catch (e) {
      print(e);
      //Utils.showSnackBar('e.message');
      // برضه مؤقتا خليها هيك...
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

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
                  decoration: _themes.screenDecoration(),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      _themes.title('Reset Password'),
                      const SizedBox(
                        height: 50,
                      ),

                      //'NOTE! Use the code provided in the verification email to reset your password',
                      Text(
                        ' Receive an email to reset your password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange[700],
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      /*TextFormField(
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
                      ),*/
                      /* const SizedBox(
                        height: 20,
                      ),*/
                      /*TextFormField(
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
                      ),*/
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        //Confirm password text field
                        keyboardType: TextInputType.emailAddress,
                        keyboardAppearance: Brightness.dark,
                        obscureText: false,
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            color: fontColor4,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          /* suffixIcon: IconButton(
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
                          ),*/
                        ),
                        onSaved: (newValue) {
                          _authData['email/username'] = newValue!;
                          _emailController.text = newValue;
                        },
                        validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? 'Enter a valid email'
                                : null,

                        /* validator: (value) {
                          if (value!.isEmpty ||
                              value != _passwordController.text) {
                            if (value.isEmpty) {
                              return 'This field is required!';
                            } else {
                              return 'Password doesn\'t match';
                            }
                          }
                          return null;
                        },*/
                        /*  onSaved: (newValue) {
                          setState(
                                () {
                              _authData['password'] = newValue!;
                              _confirmedPasswordController.text = newValue;
                            },
                          );
                        },*/
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          icon: const Icon(
                            Icons.email_outlined,
                            size: 32,
                          ),
                          label: const Text(
                            "Resent Password",
                            style: TextStyle(fontSize: 24),
                          ),
                          onPressed: () {}),

                      /* TextButton(
                        /**reset button */
                        onPressed: () {
                         // final isValid = formstate.currentState!.validate();
                        /*  if (isValid) {
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
                          }*/
                        },
                        child: _themes
                            .textButtonStyle(allow ? 'RESET' : 'VERIFY CODE'),
                      ),*/
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
* */

/*
* SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Verify Email'),
            ),
          ),
        );
*/

// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';
// import 'package:pro1/Registration/Forgot_Password/reset_password.dart'; //  مش مستخدم؟
// import 'package:pro1/Theme/app_themes.dart';
// //import 'package:basic_utils/basic_utils.dart';
//
// class VerifyEmail extends StatefulWidget {
//   const VerifyEmail({super.key});
//
//   @override
//   State<VerifyEmail> createState() => _VerifyEmailState();
// }
//
// class _VerifyEmailState extends State<VerifyEmail> {
//   final _emailInput = TextEditingController(); //لازم تنشال
//   final Map<String, String> _authData = {
//     'email/username': '',
//     'password': '',
//   };
//   final Themes _themes = Themes();
//   final GlobalKey<FormState> formKey = GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Form(
//           key: formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: appLogo(),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(15),
//                   height: 775,
//                   decoration: _themes.screenDecoration(context),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           IconButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                             },
//                             icon: Icon(
//                               Icons.close_outlined,
//                               color: background4,
//                             ),
//                           )
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       Column(
//                         children: [
//                           _themes.title('Verify Email'),
//                           _themes.trailing(
//                               'Verify your email address to reset your password'),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 70,
//                       ),
//                       /*TextFormField(
//                         // ليش أشيلهم؟؟؟؟
//                         //  هاي لازم تنشال كلهاا
//                         keyboardType: TextInputType.emailAddress,
//                         keyboardAppearance: Brightness.dark,
//                         decoration: _themes.textFormFieldDecoration('Email'),
//                         obscureText: false,
//                         validator: (value) {
//                           if (value!.isEmpty ||
//                               !value.contains('@') ||
//                               !value.contains('.com') ||
//                               value.length < 12) {
//                             if (value.isEmpty) {
//                               return 'This field is required!';
//                             } else {
//                               return 'Invalid email/username';
//                             }
//                           }
//                           return null;
//                         },
//                         onSaved: (newValue) {
//                           _authData['email/username'] = newValue!;
//                           _emailInput.text = newValue;
//                         },
//                       ),*/
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size.fromHeight(50),
//                         ),
//                         icon: const Icon(
//                           Icons.email,
//                           size: 32,
//                         ),
//                         label: const Text(
//                           "Send Email",
//                           style: TextStyle(fontSize: 24),
//                         ),
//                         onPressed:
//                         canResendEmail ? sendVerificationEmail : null,
//                         /* onPressed: () {
//                           SnackBar verificationMessage = const SnackBar(
//                             content: Text(
//                               'Verification message is sent to your email',
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                             ),
//                             duration: Duration(seconds: 4),
//                           );
//                           final isValid = formKey.currentState!.validate();
//                           if (isValid) {
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(verificationMessage);
//                             Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_emailInput.text != '')
//                                     ? (context) => const VerifyEmail()
//                                     : (context) =>
//                                         const ResetPassword(), // fix it
//                               ),
//                             );
//                           }
//                         },*/
//                         // child: _themes.textButtonStyle('VERIFY'),
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       TextButton(
//                         style: TextButton.styleFrom(
//                           minimumSize: const Size.fromHeight(50),
//                         ),
//                         child: const Text(
//                           "Cancel",
//                           style: TextStyle(fontSize: 24),
//                         ),
//                         onPressed: () => FirebaseAuth.instance.signOut(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

/*
*
*
* fluttertoast: ^8.1.1
  alert_dialog: ^1.0.1
  email_validator: ^2.1.17
  basic_utils: ^5.4.2
*
* */
