import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Screens/GetStarted/background.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'package:gsg_fire_base/components/bio_input_field.dart';
import 'package:gsg_fire_base/components/rounded_button.dart';
import 'package:gsg_fire_base/components/rounded_input_field.dart';
import 'package:gsg_fire_base/constants.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class EditProfileScreen extends StatefulWidget {
  static final routeName = 'EditProfile';

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, provider, x) {
          return Background(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Edit your profile!",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.transparent,
                        backgroundImage: provider.updatedFile == null
                            ? NetworkImage(provider.userModel.imageUrl)
                            : FileImage(provider.updatedFile),
                        child: Visibility(
                          visible: provider.userModel.imageUrl == null,
                          child: CircleAvatar(
                            radius: 90,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(
                              "assets/images/defaultProfile.png",
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 130,
                        left: 110,
                        child: RawMaterialButton(
                            padding: EdgeInsets.all(10),
                            fillColor: kPrimaryColor,
                            elevation: 10,
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              provider.captureUpdateProfileImage();

                              setState(() {});
                            }),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "User name:",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  RoundedInputField(
                    controller: provider.userNameController,
                    hintText: "User name",
                    icon: Icons.alternate_email,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Profile Bio:",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BioInputField(
                    controller: provider.bioController,
                    hintText: "Bio",
                  ),
                  SizedBox(height: size.height * 0.01),
                  RoundedButton(
                    text: "Done",
                    press: () {
                      provider.updateProfile();
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
