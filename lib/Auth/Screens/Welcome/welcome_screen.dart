import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gsg_fire_base/Auth/Screens/Login/login_screen.dart';
import 'package:gsg_fire_base/Auth/Screens/Signup/signup_screen.dart';
import 'package:gsg_fire_base/Auth/Screens/Welcome/background.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/components/rounded_button.dart';
import 'package:gsg_fire_base/constants.dart';

class WelcomeScreen extends StatelessWidget {
  static final routeName = 'welcome';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "WELCOME TO Azizko",
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.45,
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  RouteHelper.routeHelper.goTO(LoginScreen.routeName);
                },
              ),
              RoundedButton(
                text: "SIGN UP",
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {
                  RouteHelper.routeHelper.goTO(SignUpScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
