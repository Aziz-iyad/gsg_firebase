import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Helpers/auth_helper.dart';
import 'package:gsg_fire_base/Helpers/firesStore_helper.dart';
import 'package:gsg_fire_base/MyWidgets/MyDrawer.dart';
import 'constants.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Home Screen'),
      ),
      body: Center(
        child: RaisedButton(onPressed: () {
          FirestoreHelper.firestoreHelper.getAllUsersFromFirestore();
        }),
      ),
    );
  }
}
// body: StreamBuilder(
// stream: FirebaseFirestore.instance
//     .collection('Users')
// .doc(AuthHelper.authHelper.getCurrentUser().uid)
// .snapshots(),
// builder: (context, snapshot) {
// if (snapshot.connectionState == ConnectionState.done) {
// final data = snapshot.requireData;
// return Center(
// child: Text(''),
// );
// } else if (snapshot.hasError) {
// return Center(child: Text('error'));
// } else {
// return Center(child: CircularProgressIndicator());
// }
// },
// ),
