import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Helpers/auth_helper.dart';
import 'package:gsg_fire_base/Auth/Screens/Login/login_screen.dart';
import '../../HomeScreen.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/Services/custom_dialoug.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  resetController() {
    emailController.clear();
    passwordController.clear();
  }

  register() async {
    try {
      await AuthHelper.authHelper
          .signUp(emailController.text, passwordController.text);
      await sendVerification();
      await RouteHelper.routeHelper.goTOReplacement(LoginScreen.routeName);
    } on Exception catch (e) {
      // TODO
    }
    resetController();
  }

  login() async {
    await AuthHelper.authHelper
        .signIn(emailController.text, passwordController.text);

    resetController();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetController();
  }

  sendVerification() {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logout();
  }
}
