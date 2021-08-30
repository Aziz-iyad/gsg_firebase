import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'AllUsersScreen.dart';
import 'package:gsg_fire_base/AppScreens/Chat_Screen.dart';
import 'package:gsg_fire_base/MyWidgets/MyDrawer.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:provider/provider.dart';
import '../Auth/Helpers/firesStore_helper.dart';
import '../Providers/authProvider.dart';
import '../constants.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = 'homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthProvider>(context, listen: false)
        .getCurrentUserFromFireStore();
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text('Home Screen'),
          ),
          body: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color(0xFFF3F4F9),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  // color: Color(0xff651CE5).withOpacity(0.3),
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 12,
                  offset: Offset(1, 4), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    RouteHelper.routeHelper.goTO(ChatScreen.routeName);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/icons/1.jpg'),
                        radius: 35,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'My Group Chat',
                        style: TextStyle(color: kPrimaryColor, fontSize: 25),
                      ),
                      SizedBox(
                        width: 95,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    RouteHelper.routeHelper
                        .goTOReplacement(AllUsersScreen.routeName);
                  },
                  icon: Icon(
                    Icons.person_search,
                    color: kPrimaryColor,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
