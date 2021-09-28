import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gsg_fire_base/Auth/Helpers/auth_helper.dart';
import 'package:gsg_fire_base/Auth/Screens/Login/background.dart';
import 'package:gsg_fire_base/Auth/Screens/ResetPassword/ResetPassword.dart';
import 'package:gsg_fire_base/Auth/Screens/Signup/signup_screen.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/components/rounded_button.dart';
import 'package:gsg_fire_base/components/rounded_input_field.dart';
import 'package:gsg_fire_base/components/rounded_password_field.dart';
import 'package:gsg_fire_base/constants.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static final routeName = 'login';
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
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    controller: provider.emailController,
                    hintText: "Your Email",
                  ),
                  RoundedPasswordField(
                    controller: provider.passwordController,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            RouteHelper.routeHelper
                                .goTO(ResetPasswordScreen.routeName);
                          },
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              fontSize: 13,
                              color: kPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  RoundedButton(
                    text: "LOGIN",
                    press: () {
                      AuthHelper.authHelper.getCurrentUser();
                      provider.login();
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don’t have an Account ? ",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                      GestureDetector(
                        onTap: () {
                          RouteHelper.routeHelper
                              .goTOReplacement(SignUpScreen.routeName);
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
