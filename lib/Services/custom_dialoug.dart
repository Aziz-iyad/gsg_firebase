import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Screens/Login/login_screen.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/constants.dart';

class CustomDialog {
  CustomDialog._();
  static CustomDialog customDialog = CustomDialog._();
  AwesomeDialog showCustomDialog(
      {String message, DialogType dialogType, Function function}) {
    return AwesomeDialog(
      context: RouteHelper.routeHelper.navKey.currentContext,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Text(
          message,
          style: TextStyle(fontSize: 18),
        ),
      ),
      animType: AnimType.SCALE,
      dialogType: dialogType,
      btnOkColor: kPrimaryColor,
      btnOkOnPress: () {
        // if (function == null) {
        //   RouteHelper.routeHelper.back();
        // } else {
        //   function();
        //   RouteHelper.routeHelper.goTOReplacement(LoginScreen.routeName);
        // }
      },
    )..show();
  }
}
// showDialog(
//     context: RouteHelper.routeHelper.navKey.currentContext,
//     builder: (context) {
//       return AlertDialog(
//         content: Text(message),
//         actions: [
//           TextButton(
//               onPressed: () {
//                 if (function == null) {
//                   RouteHelper.routeHelper.back();
//                 } else {
//                   function();
//                   RouteHelper.routeHelper
//                       .goTOReplacement(LoginScreen.routeName);
//                 }
//               },
//               child: Text('ok'))
//         ],
//       );
//     });
