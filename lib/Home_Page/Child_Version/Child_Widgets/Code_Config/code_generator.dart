import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro1/Home_Page/Child_Version/Child_Home.dart';
import 'package:pro1/Registration/Child_Configurations/child_info.dart';
import 'package:pro1/Theme/app_themes.dart';

class CodeGenerator extends StatefulWidget {
  CodeGenerator({
    super.key,
  });

  @override
  State<CodeGenerator> createState() => _CodeGeneratorState();
}

class _CodeGeneratorState extends State<CodeGenerator> {
  final Themes _themes = Themes();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'media/images/TotalControl_Logo.png',
                      width: 75,
                      height: 75,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Total Control',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                height: 775,
                decoration: _themes.screenDecoration(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),
                    _themes.title('Connection Code'),
                    const SizedBox(
                      height: 10,
                    ),
                    _themes.trailing(
                        'Use the code below to connect your child\'s device'),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      /*
                      connection code text field
                      */
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.name,
                      keyboardAppearance: Brightness.dark,
                      /**
                       * TODO: here you need to enter the generated code to be revealed for the user ( child & parent)
                       */
                      decoration: _themes.textFormFieldDecoration(code),
                      obscureText: false,
                      enabled: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: background1,
          onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ChildHomePage(),
            ),
          ),
          child: Icon(
            CupertinoIcons.home,
            color: fontColor1,
          ),
        ),
      ),
    );
  }
}
