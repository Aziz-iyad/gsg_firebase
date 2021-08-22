import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Providers/authProvider.dart';

import 'Auth/Screens/Login/login_screen.dart';
import 'Auth/Screens/ResetPassword/ResetPassword.dart';
import 'Auth/Screens/Signup/signup_screen.dart';
import 'Auth/Screens/Welcome/welcome_screen.dart';
import 'HomeScreen.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<AuthProvider>(
      create: (context) => AuthProvider(),
      child: MaterialApp(
          routes: {
            WelcomeScreen.routeName: (context) => WelcomeScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
          },
          navigatorKey: RouteHelper.routeHelper.navKey,
          debugShowCheckedModeBanner: false,
          home: FirebaseConfiguration())));
}

class FirebaseConfiguration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot<FirebaseApp> snapshotData) {
          if (snapshotData.hasError) {
            return Scaffold(
              backgroundColor: Colors.red,
              body: Center(
                child: Text(snapshotData.error.toString()),
              ),
            );
          }
          if (snapshotData.connectionState == ConnectionState.done) {
            return WelcomeScreen();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}