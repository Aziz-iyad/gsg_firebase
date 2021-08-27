import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/MyWidgets/MyDrawer.dart';
import 'package:provider/provider.dart';
import 'Auth/Helpers/firesStore_helper.dart';
import 'Providers/authProvider.dart';
import 'constants.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthProvider>(context, listen: false).getUserFromFireStore();
    print(FirebaseAuth.instance.currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, x) {
        return Scaffold(
          drawer: MyDrawer(
            imgUrl: provider.userModel.imageUrl,
            userName: provider.userModel.userName,
          ),
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
      },
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
