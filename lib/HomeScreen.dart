import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Helpers/auth_helper.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'Auth/Screens/Welcome/welcome_screen.dart';
import 'constants.dart';

class HomeScreen extends StatelessWidget {
  static final routeName = 'homeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                      Image.asset(
                        "assets/images/avatar.png",
                        height: 80,
                        width: 80,
                        fit: BoxFit.fill,
                      ),
                      Text(
                        AuthHelper.authHelper.getCurrentUserEmail(),
                        style: TextStyle(
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
                    onTap: () async {
                      await AuthHelper.authHelper.logout();
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
      ),
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Text('main page'),
      ),
    );
  }
}
