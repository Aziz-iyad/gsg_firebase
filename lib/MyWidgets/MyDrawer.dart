import 'package:flutter/material.dart';
import 'package:gsg_fire_base/AppScreens/ProfileScreen/ProfileScreen.dart';
import 'package:gsg_fire_base/Auth/Screens/Welcome/welcome_screen.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'package:provider/provider.dart';
import '../Auth/Helpers/auth_helper.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/constants.dart';

class MyDrawer extends StatelessWidget {
  String imgUrl;
  String userName;
  MyDrawer({this.userName, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: kPrimaryColor,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: imgUrl == null
                          ? AssetImage(
                              "assets/images/defaultProfile.png",
                            )
                          : NetworkImage(
                              imgUrl,
                            ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userName,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    RouteHelper.routeHelper
                        .goTOReplacement(ProfileScreen.routeName);
                  },
                  child: Text(
                    'My Profile',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await AuthHelper.authHelper.logout();
                    Provider.of<AuthProvider>(context, listen: false)
                        .resetController();
                    Provider.of<AuthProvider>(context, listen: false).file =
                        null;
                    RouteHelper.routeHelper
                        .goTOReplacement(WelcomeScreen.routeName);
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
