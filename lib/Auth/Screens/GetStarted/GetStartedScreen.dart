import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Providers/authProvider.dart';
import 'package:gsg_fire_base/Auth/Screens/GetStarted/background.dart';
import 'package:gsg_fire_base/components/bio_input_field.dart';
import 'package:gsg_fire_base/components/rounded_button.dart';
import 'package:gsg_fire_base/components/rounded_input_field.dart';
import 'package:gsg_fire_base/constants.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';

class GetStartedScreen extends StatefulWidget {
  static final routeName = 'GetStarted';

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  bool isVisible = false;
  bool isVisible2 = true;

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
                    "Set up your profile!",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 90,
                        backgroundColor: Colors.transparent,
                        child: ClipOval(
                          child: provider.file == null
                              ? Image.asset(
                                  "assets/images/defaultProfile.png",
                                  width: size.width * 0.90,
                                )
                              : Image.file(
                                  provider.file,
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                      Visibility(
                        visible: isVisible2,
                        child: Positioned(
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
                              provider.selectFile();
                              isVisible = true;
                              isVisible2 = false;
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Positioned(
                          bottom: 130,
                          left: 115,
                          child: RawMaterialButton(
                            fillColor: Colors.red,
                            elevation: 5,
                            shape: CircleBorder(),
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {
                              provider.file = null;
                              isVisible = false;
                              isVisible2 = true;
                              setState(() {});
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    controller: provider.userNameController,
                    hintText: "User name",
                    icon: Icons.alternate_email,
                  ),
                  BioInputField(
                    controller: provider.bioController,
                    hintText: "Bio",
                  ),
                  SizedBox(height: size.height * 0.01),
                  RoundedButton(
                    text: "Done",
                    press: () {
                      provider.gdtStarted();
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
