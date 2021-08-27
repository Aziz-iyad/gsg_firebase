import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/AppScreens/EditProfile/EditProfile.dart';
import 'package:gsg_fire_base/Auth/Screens/GetStarted/background.dart';
import 'package:gsg_fire_base/HomeScreen.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/components/RoundedReadField.dart';
import 'package:gsg_fire_base/components/bio_input_field.dart';
import 'package:gsg_fire_base/components/rounded_button.dart';
import 'package:gsg_fire_base/components/rounded_input_field.dart';
import 'package:gsg_fire_base/constants.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class ProfileScreen extends StatefulWidget {
  static final routeName = 'AppScreens.ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool test = false;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<AuthProvider>(context, listen: false).getUserFromFireStore();
    print(FirebaseAuth.instance.currentUser.uid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return provider.userModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Background(
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Text(
                              "My profile!",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            IconButton(
                              onPressed: () {
                                Provider.of<AuthProvider>(context,
                                        listen: false)
                                    .fillControllers();
                                RouteHelper.routeHelper
                                    .goTO(EditProfileScreen.routeName);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: kPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: size.height * 0.03),
                        CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.transparent,
                            backgroundImage: provider.userModel.imageUrl == null
                                ? AssetImage(
                                    "assets/images/defaultProfile.png",
                                  )
                                : NetworkImage(provider.userModel.imageUrl)),
                        SizedBox(height: size.height * 0.03),
                        RoundedReadField(
                          labelText: provider.userModel.email,
                          icon: Icons.email,
                        ),
                        RoundedReadField(
                          labelText: provider.userModel.userName,
                          icon: Icons.alternate_email,
                        ),
                        RoundedReadField(
                          labelText: provider.userModel.bio,
                          icon: Icons.chat,
                        ),
                        SizedBox(height: size.height * 0.01),
                        RoundedButton(
                          text: "Done",
                          press: () {
                            RouteHelper.routeHelper
                                .goTOReplacement(HomeScreen.routeName);
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
