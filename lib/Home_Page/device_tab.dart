import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as fb_db;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro1/Home_Page/report/report-making-app-main/addnote.dart';
import 'package:pro1/Home_Page/report/report-making-app-main/editnote.dart';
import 'package:pro1/Theme/app_themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Device extends StatefulWidget {
  const Device({super.key});

  @override
  State<Device> createState() => _DeviceState();
}

var appsData = {};

class _DeviceState extends State<Device> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('report').snapshots();

  final Themes _themes = Themes();
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  Map data = {};

  //Map<String, List> data = {};
  x() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final uid = user?.uid;
    //z fb_db.Query ref2 =
    // fb_db. FirebaseDatabase.instance.ref().child("Users/$uid/Children");
    // fb_db.DataSnapshot e = await ref2.get();

    // Map data = e.value as Map<dynamic,dynamic>;
    // data.forEach((key, value) async {});
    fb_db.Query ref2 = fb_db.FirebaseDatabase.instance
        .ref()
        .child("Users/$uid/Children/${id.text.isNotEmpty ? id.text : '6956'}");
    fb_db.DataSnapshot e = await ref2.get();
    data = e.value as Map<dynamic, dynamic>;
    appsData = data;
    log('New Data:' + data.toString());
    setState(() {});
  }

  @override
  void initState() {
    x();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      body: StreamBuilder(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("something is wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          editnote(),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 3,
                          right: 3,
                        ),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          title: Text(
                            "${data['Child Name']}",
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text("${data['Brand']['brand']}"),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(
              "Child ID",
              style: TextStyle(
                color: fontColor1,
              ),
              textAlign: TextAlign.center,
            ),
            content: TextFormField(
              //ID text field
              style: TextStyle(
                color: fontColor4,
              ),
              controller: id,
              keyboardType: TextInputType.number,
              decoration: _themes.textFormFieldDecoration(''),
              obscureText: false,
            ),
            contentPadding: const EdgeInsets.all(20.0),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      x();
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: fontColor1,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: fontColor1,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            elevation: 30,
          ),
        ),
        backgroundColor: background1,
        child: Icon(
          CupertinoIcons.person_add_solid,
          color: fontColor1,
        ),
      ),
    );
  }
}

///chart
/*
Center(
                heightFactor: 1.2,
                child: PieChart(
                  dataMap: (userMode.isNotEmpty && userMode == 'family')
                      ? childDataMap
                      : childDeviceDataMap,
                  colorList: colorList,
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  chartValuesOptions: ChartValuesOptions(
                    chartValueStyle: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: fontColor1,
                    ),
                    showChartValues: true,
                    showChartValuesOutside: true,
                    showChartValuesInPercentage: true,
                    showChartValueBackground: false,
                  ),
                  legendOptions: LegendOptions(
                    showLegends: true,
                    legendPosition: LegendPosition.left,
                    legendTextStyle: TextStyle(
                      color: fontColor1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              )




                // final FirebaseAuth auth = FirebaseAuth.instance;
    // final User? user = auth.currentUser;
    // final uid = user?.uid;
    //
    // DatabaseReference ref2 =
    //     FirebaseDatabase.instance.ref().child("Users/$uid/Children");
    // ref2.child(id.text).child('Brand');
    //
    // var brand = ref2
    //     .child("Users/$uid/Children")
    //     .child('98')
    //     .child('AppCategory')
    //     .get();
    // var snapshot = ref2.child("${id.text}/brand").once();
    // var test = snapshot.then((value) => value.toString());
    // String value = ref2.once().then((snapshot) => snapshot).toString();
 */

/*showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "Time Limit",
                style: TextStyle(
                  color: fontColor6,
                ),
                textAlign: TextAlign.center,
              ),
              content: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shadowColor: shadowColor1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      color: background4,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Select App:'),
                            DropdownButton<String>(
                              value: selectedItem,
                              items: _items
                                  .map(
                                    (item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(item),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (item) =>
                                  setState(() => selectedItem = item),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      shadowColor: shadowColor1,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      color: background4,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Set Limit:'),
                            CounterButton(
                              loading: false,
                              onChange: (int val) {
                                setState(() {
                                  _counterValue = val;
                                });
                              },
                              count: _counterValue,
                              countColor: fontColor4,
                              buttonColor: fontColor2,
                              progressColor: fontColor3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: fontColor6,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: fontColor6,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
              elevation: 30,
            ),
          );*/

/*Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        decoration: _themes.screenDecoration(context),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                'Connected Devices',
                style: TextStyle(
                  color: fontColor1,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              trailing: IconButton(
                onPressed: null,
                icon: Icon(
                  CupertinoIcons.square_fill,
                  color: fontColor1,
                  size: 35,
                ),
              ),
              subtitle: Divider(
                color: fontColor1,
                thickness: 6,
              ),
            ),

          ],
        ),
      ),*/
