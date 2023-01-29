import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pro1/Home_Page/Parent_Version/parent_home.dart';
import 'package:pro1/Theme/app_themes.dart';

class addnote extends StatelessWidget {
  //TextEditingController name = TextEditingController();
  TextEditingController subject1 = TextEditingController();
  //TextEditingController subject2 = TextEditingController();
  //TextEditingController subject3 = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection('report');
  final Themes _themes = Themes();

  String getID(){
    String id = subject1.text;
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            onPressed: () {
              // ref.add({
              //   'name': name.text,
              //   'Maths': subject1.text,
              //   'Science': subject2.text,
              //   'History': subject3.text,
              // }).whenComplete(() { Navigator goes here });
              getID;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const ParentHomePage(),
                ),
              );
            },
            child: const Text(
              "save",
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 251, 251, 251),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(''),

            ///TODO: Add a hint
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: subject1,
                keyboardType: TextInputType.number,
                decoration: _themes.textFormFieldDecoration('Child Id'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
