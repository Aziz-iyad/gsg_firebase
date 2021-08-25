import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Screens/Login/login_screen.dart';
import 'package:gsg_fire_base/Services/Router.dart';

class CustomDialog {
  CustomDialog._();
  static CustomDialog customDialog = CustomDialog._();
  showCustomDialog(String message, [Function function]) {
    showDialog(
        context: RouteHelper.routeHelper.navKey.currentContext,
        builder: (context) {
          return AlertDialog(
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    if (function == null) {
                      RouteHelper.routeHelper.back();
                    } else {
                      function();
                      RouteHelper.routeHelper
                          .goTOReplacement(LoginScreen.routeName);
                    }
                  },
                  child: Text('ok'))
            ],
          );
        });
  }
}
