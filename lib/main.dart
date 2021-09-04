import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/AppScreens/ChatScreen.dart';
import 'package:gsg_fire_base/Providers/user_provider.dart';
import 'AppScreens/AllUsersScreen.dart';
import 'package:gsg_fire_base/Auth/Screens/GetStarted/GetStartedScreen.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'AppScreens/GroupChat_Screen.dart';
import 'AppScreens/EditProfile/EditProfile.dart';
import 'AppScreens/ProfileScreen/ProfileScreen.dart';
import 'AppScreens/SplashScreen/splachScreen.dart';
import 'Auth/Screens/Login/login_screen.dart';
import 'Auth/Screens/ResetPassword/ResetPassword.dart';
import 'Auth/Screens/Signup/signup_screen.dart';
import 'Auth/Screens/Welcome/welcome_screen.dart';
import 'AppScreens/HomeScreen.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
          routes: {
            WelcomeScreen.routeName: (context) => WelcomeScreen(),
            LoginScreen.routeName: (context) => LoginScreen(),
            SignUpScreen.routeName: (context) => SignUpScreen(),
            ResetPasswordScreen.routeName: (context) => ResetPasswordScreen(),
            HomeScreen.routeName: (context) => HomeScreen(),
            GetStartedScreen.routeName: (context) => GetStartedScreen(),
            ProfileScreen.routeName: (context) => ProfileScreen(),
            SplachScreen.routeName: (context) => SplachScreen(),
            EditProfileScreen.routeName: (context) => EditProfileScreen(),
            AllUsersScreen.routeName: (context) => AllUsersScreen(),
            GroupChatScreen.routeName: (_) => GroupChatScreen(),
            ChatScreen.routeName: (context) => ChatScreen(),
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
              body: Center(
                child: Text(snapshotData.error.toString()),
              ),
            );
          }
          if (snapshotData.connectionState == ConnectionState.done) {
            return SplachScreen();
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
