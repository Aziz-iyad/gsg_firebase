import 'package:flutter/material.dart';
import 'package:gsg_fire_base/AppScreens/AllUsersScreen.dart';
import 'package:gsg_fire_base/AppScreens/GroupChat_Screen.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/constants.dart';

class GroupChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F9),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            // color: Color(0xff651CE5).withOpacity(0.3),
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 15,
            offset: Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              RouteHelper.routeHelper.goTO(GroupChatScreen.routeName);
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
              RouteHelper.routeHelper.goTOReplacement(AllUsersScreen.routeName);
            },
            icon: Icon(
              Icons.person_search,
              color: kPrimaryColor,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
