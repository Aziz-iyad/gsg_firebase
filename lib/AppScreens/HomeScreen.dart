import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/AppScreens/ChatScreen.dart';
import 'package:gsg_fire_base/MyWidgets/ChatCard.dart';
import 'package:gsg_fire_base/MyWidgets/GroupChat.dart';
import 'package:gsg_fire_base/Providers/user_provider.dart';
import 'package:gsg_fire_base/Services/custom_progress.dart';
import 'AllUsersScreen.dart';
import 'package:gsg_fire_base/AppScreens/GroupChat_Screen.dart';
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
  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, UserProvider>(
      builder: (context, authProvider, userProvider, x) {
        return Scaffold(
          drawer: MyDrawer(
            imgUrl: authProvider.userModel.imageUrl,
            userName: authProvider.userModel.userName,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: kPrimaryColor,
            child: Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text('Azizko chatapp'),
          ),
          body: Column(
            children: [
              GroupChat(),
              Expanded(
                  child: ListView.builder(
                      itemCount: authProvider.users.length,
                      itemBuilder: (context, index) {
                        if (authProvider.users == null) {
                          print(authProvider.users.last);
                          return Center(
                            child:
                                CustomProgress.customProgress.spinKitRipple(),
                          );
                        } else {
                          return ChatCard(
                            title: authProvider.users[index].userName,
                            img: authProvider.users[index].imageUrl,
                            function: () {
                              userProvider.friend.update('imageUrl', (value) {
                                value =
                                    authProvider.users[index].imageUrl ?? "";
                                return value;
                              });
                              userProvider.friend.update('userName', (value) {
                                value =
                                    authProvider.users[index].userName ?? "";
                                return value;
                              });
                              userProvider.friend.update('id', (value) {
                                value = authProvider.users[index].id ?? "";
                                return value;
                              });

                              /// the code below to compute the uid of two users
                              /// you can't just say myUid then the uid of my friend
                              /// because if you loged the collection will be uid + uidFriend
                              /// and if the friend logged the the collection will be uidFriend + uid
                              /// and that's wrong :) meow
                              int p1 = 0;
                              int p2 = 0;
                              final String myUid = userProvider.myId;
                              final String friendUid =
                                  userProvider.friend['id'];

                              while (
                                  p1 < friendUid.length && p2 < myUid.length) {
                                if (friendUid.codeUnitAt(p1) >
                                    myUid.codeUnitAt(p2)) {
                                  userProvider.changeChat(friendUid + myUid);
                                  break;
                                } else if (friendUid.codeUnitAt(p1) <
                                    myUid.codeUnitAt(p2)) {
                                  userProvider.changeChat(myUid + friendUid);
                                  break;
                                }
                                p1++;
                                p2++;
                              }
                              userProvider.getCurrentUserFromFireStore();
                              RouteHelper.routeHelper
                                  .goTO(ChatScreen.routeName);
                            },
                          );
                        }
                      }))
            ],
          ),
        );
      },
    );
  }
}
