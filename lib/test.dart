// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.initializeApp();
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Firebase'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             const Image(
//               width: 300,
//               height: 300,
//               image: NetworkImage(
//                   'https://seeklogo.com/images/F/firebase-logo-402F407EE0-seeklogo.com.png'),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             const Text(
//               'Firebase Realtime Database Series in Flutter 2022',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             MaterialButton(
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const InsertData()));
//               },
//               child: const Text('Insert Data'),
//               color: Colors.blue,
//               textColor: Colors.white,
//               minWidth: 300,
//               height: 40,
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             MaterialButton(
//               onPressed: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const FetchData()));
//               },
//               child: const Text('Fetch Data'),
//               color: Colors.blue,
//               textColor: Colors.white,
//               minWidth: 300,
//               height: 40,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class InsertData extends StatefulWidget {
//   const InsertData({Key? key}) : super(key: key);
//
//   @override
//   State<InsertData> createState() => _InsertDataState();
// }
//
// class _InsertDataState extends State<InsertData> {
//   final userNameController = TextEditingController();
//   final userAgeController = TextEditingController();
//   final userSalaryController = TextEditingController();
//
//   late DatabaseReference dbRef;
//
//   @override
//   void initState() {
//     super.initState();
//     dbRef = FirebaseDatabase.instance.ref().child('Students');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Inserting data'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               const Text(
//                 'Inserting data in Firebase Realtime Database',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userNameController,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Name',
//                   hintText: 'Enter Your Name',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userAgeController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Age',
//                   hintText: 'Enter Your Age',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userSalaryController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Salary',
//                   hintText: 'Enter Your Salary',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               MaterialButton(
//                 onPressed: () {
//                   Map<String, String> students = {
//                     'name': userNameController.text,
//                     'age': userAgeController.text,
//                     'salary': userSalaryController.text
//                   };
//
//                   dbRef.push().set(students);
//                 },
//                 child: const Text('Insert Data'),
//                 color: Colors.blue,
//                 textColor: Colors.white,
//                 minWidth: 300,
//                 height: 40,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FetchData extends StatefulWidget {
//   const FetchData({Key? key}) : super(key: key);
//
//   @override
//   State<FetchData> createState() => _FetchDataState();
// }
//
// class _FetchDataState extends State<FetchData> {
//   Query dbRef = FirebaseDatabase.instance.ref().child('Users');
//   DatabaseReference reference = FirebaseDatabase.instance.ref().child('Users');
//
//   Widget listItem({required Map User}) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       height: 110,
//       color: Colors.amberAccent,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             User['name'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             User['age'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             User['salary'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => UpdateRecord(
//                         studentKey: User['key'],
//                       ),
//                     ),
//                   );
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.edit,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 6,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   reference.child(User['key']).remove();
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.delete,
//                       color: Colors.red[700],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetching data'),
//         ),
//         body: Container(
//           height: double.infinity,
//           child: FirebaseAnimatedList(
//             query: dbRef,
//             itemBuilder: (BuildContext context, DataSnapshot snapshot,
//                 Animation<double> animation, int index) {
//               Map student = snapshot.value as Map;
//               student['key'] = snapshot.key;
//
//               return listItem(student: student);
//             },
//           ),
//         ));
//   }
// }
//
// class UpdateRecord extends StatefulWidget {
//   const UpdateRecord({Key? key, required this.studentKey}) : super(key: key);
//
//   final String studentKey;
//
//   @override
//   State<UpdateRecord> createState() => _UpdateRecordState();
// }
//
// class _UpdateRecordState extends State<UpdateRecord> {
//   final userNameController = TextEditingController();
//   final userAgeController = TextEditingController();
//   final userSalaryController = TextEditingController();
//
//   late DatabaseReference dbRef;
//
//   @override
//   void initState() {
//     super.initState();
//     dbRef = FirebaseDatabase.instance.ref().child('Students');
//     getStudentData();
//   }
//
//   void getStudentData() async {
//     DataSnapshot snapshot = await dbRef.child(widget.studentKey).get();
//
//     Map student = snapshot.value as Map;
//
//     userNameController.text = student['name'];
//     userAgeController.text = student['age'];
//     userSalaryController.text = student['salary'];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Updating record'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 50,
//               ),
//               const Text(
//                 'Updating data in Firebase Realtime Database',
//                 style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.w500,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userNameController,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Name',
//                   hintText: 'Enter Your Name',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userAgeController,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Age',
//                   hintText: 'Enter Your Age',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               TextField(
//                 controller: userSalaryController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(),
//                   labelText: 'Salary',
//                   hintText: 'Enter Your Salary',
//                 ),
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               MaterialButton(
//                 onPressed: () {
//                   Map<String, String> students = {
//                     'name': userNameController.text,
//                     'age': userAgeController.text,
//                     'salary': userSalaryController.text
//                   };
//
//                   dbRef
//                       .child(widget.studentKey)
//                       .update(students)
//                       .then((value) => {Navigator.pop(context)});
//                 },
//                 child: const Text('Update Data'),
//                 color: Colors.blue,
//                 textColor: Colors.white,
//                 minWidth: 300,
//                 height: 40,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
