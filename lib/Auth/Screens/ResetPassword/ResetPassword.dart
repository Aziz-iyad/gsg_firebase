import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Screens/ResetPassword/background.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/constants.dart';
import 'package:gsg_fire_base/components/rounded_button.dart';
import 'package:gsg_fire_base/components/rounded_input_field.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatelessWidget {
  static final routeName = 'resetPassword';
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
                    "Reset Your Password",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    "assets/images/customer service illustration2.jpg",
                    width: size.width * 0.90,
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    controller: provider.emailController,
                    hintText: "Your Email",
                  ),
                  RoundedButton(
                    text: "Send Reset Email",
                    press: () {
                      provider.resetPassword();
                      RouteHelper.routeHelper.back();
                    },
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
