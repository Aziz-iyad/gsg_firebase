import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Screens/Login/login_screen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gsg_fire_base/Auth/Screens/Signup/background.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/constants.dart';
import 'package:gsg_fire_base/components/rounded_button.dart';
import 'package:gsg_fire_base/components/rounded_input_field.dart';
import 'package:gsg_fire_base/components/rounded_password_field.dart';
import 'package:provider/provider.dart';
import 'components/or_divider.dart';
import 'components/social_icon.dart';

class SignUpScreen extends StatelessWidget {
  static final routeName = 'signUp';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "SIGN UP",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.35,
                  ),
                  RoundedInputField(
                    hintText: "Your Email",
                    controller: provider.emailController,
                  ),
                  RoundedPasswordField(
                    controller: provider.passwordController,
                  ),
                  RoundedButton(
                    text: "SIGNUP",
                    press: () {
                      provider.register();
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already have an Account ? ",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          RouteHelper.routeHelper
                              .goTOReplacement(LoginScreen.routeName);
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        iconSrc: "assets/icons/facebook.svg",
                        press: () {},
                      ),
                      SocialIcon(
                        iconSrc: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                      SocialIcon(
                        iconSrc: "assets/icons/google-plus.svg",
                        press: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
