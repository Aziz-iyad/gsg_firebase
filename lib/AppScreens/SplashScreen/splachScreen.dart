import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gsg_fire_base/AppScreens/SplashScreen/background.dart';
import 'package:gsg_fire_base/Auth/Helpers/auth_helper.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'package:provider/provider.dart';

class SplachScreen extends StatelessWidget {
  static final routeName = 'SplachScreen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Provider.of<AuthProvider>(context, listen: false)
        .getCurrentUserFromFireStore();
    Future.delayed(Duration(seconds: 2)).then((value) =>
        Provider.of<AuthProvider>(context, listen: false).checkLogin());
    return Scaffold(
        body: Background(
      child: Center(
          child: Image.asset(
        "assets/icons/1.jpg",
        width: size.width * 0.50,
      )),
    ));
  }
}
