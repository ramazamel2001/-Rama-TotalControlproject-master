import 'package:flutter/material.dart';
import 'package:pro1/Registration/Child_Configurations/get_child_info.dart';
import 'package:pro1/Theme/app_themes.dart';

class ChildRegistrationCode extends StatefulWidget {
  const ChildRegistrationCode({Key? key}) : super(key: key);

  @override
  State<ChildRegistrationCode> createState() => _ChildRegistrationCodeState();
}

class _ChildRegistrationCodeState extends State<ChildRegistrationCode> {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController connectionCodeController = TextEditingController();
  final Themes _themes = Themes();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
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
                  decoration: _themes.screenDecoration(context),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _themes.title('Connection Code'),
                      const SizedBox(
                        height: 20,
                      ),
                      _themes.trailing(
                        'One last step!, a code will be generated on your child device, enter the code to proceed',
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        keyboardAppearance: Brightness.dark,
                        style: TextStyle(
                          color: fontColor4,
                        ),
                        decoration: _themes.textFormFieldDecoration(
                            'Enter a connection code'),
                        validator: (value) {
                          if (value!.isEmpty || value.length > 25) {
                            if (value.isEmpty) {
                              return 'This field is required!';
                            } else if (value.length > 25) {
                              return 'Invalid code';
                            }
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          connectionCodeController.text = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextButton(
                        onPressed: () {
                          final isValid = formKey.currentState!.validate();
                          if (isValid) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: connectionCodeController.text != ''
                                    ? (context) =>
                                        const ChildRegistrationCode()
                                    : (context) => const GetChildInfo(),
                              ),
                            );
                          }
                        },
                        child: _themes.textButtonStyle('Add'),
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
