import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Helpers/firesStore_helper.dart';
import 'package:gsg_fire_base/Auth/Screens/GetStarted/GetStartedScreen.dart';
import 'package:gsg_fire_base/Auth/Screens/Welcome/welcome_screen.dart';
import '../Auth/Helpers/auth_helper.dart';
import '../Auth/Helpers/firestorage_helper.dart';
import 'package:gsg_fire_base/HomeScreen.dart';
import 'package:gsg_fire_base/Models/register_request.dart';
import 'package:gsg_fire_base/Models/user_model.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  resetController() {
    emailController.clear();
    passwordController.clear();
    userNameController.clear();
    bioController.clear();
  }

  ////////////////////
  //upload image
  File file;
  selectFile() async {
    XFile imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }

  ///////////////////
  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signUp(emailController.text, passwordController.text);
      // await AuthHelper.authHelper.verifyEmail();
      // await AuthHelper.authHelper.logout();

    } on Exception catch (e) {
      // TODO
    }
  }

  gdtStarted() async {
    try {
      String imageUrl =
          await FireStorageHelper.fireStorageHelper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
        id: AuthHelper.authHelper.getCurrentUser().uid,
        email: emailController.text,
        userName: userNameController.text,
        bio: bioController.text,
        imageUrl:
            imageUrl == null ? "assets/images/defaultProfile.png" : imageUrl,
      );
      await FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
    } on Exception catch (e) {
      // TODO
    }
    await RouteHelper.routeHelper.goTOReplacement(HomeScreen.routeName);
    resetController();
  }

  login() async {
    UserCredential userCredential = await AuthHelper.authHelper
        .signIn(emailController.text, passwordController.text);
    FirestoreHelper.firestoreHelper
        .getUserFromFirestore(userCredential.user.uid);

    // bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    // if (isVerifiedEmail) {
    //   RouteHelper.routeHelper.goTOReplacement(HomeScreen.routeName);
    // } else {
    //   CustomDialog.customDialog.showCustomDialog(
    //       'You have to verify your email, press ok to send a Verification email',
    //       await AuthHelper.authHelper.myVerification());
    // }
    resetController();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetController();
  }

  sendVerification() async {
    await AuthHelper.authHelper.verifyEmail();
    await AuthHelper.authHelper.logout();
  }

  checkLogin() {
    bool isLoggedIn = AuthHelper.authHelper.checkUserLogin();
    print(FirebaseAuth.instance.currentUser);
    if (isLoggedIn) {
      RouteHelper.routeHelper.goTOReplacement(HomeScreen.routeName);
    } else {
      RouteHelper.routeHelper.goTOReplacement(WelcomeScreen.routeName);
    }
  }

  File updatedFile;
  captureUpdateProfileImage() async {
    XFile file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.updatedFile = File(file.path);
    notifyListeners();
  }

////**CRUD**////
  UserModel userModel;
  getUserFromFireStore() async {
    String userId = AuthHelper.authHelper.getUserId();
    userModel =
        await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
    notifyListeners();
  }

  fillControllers() {
    userNameController.text = userModel.userName;
    bioController.text = userModel.bio;
  }

  updateProfile() async {
    String imageUrl;
    if (updatedFile != null) {
      imageUrl =
          await FireStorageHelper.fireStorageHelper.uploadImage(updatedFile);
    }
    UserModel myUserModel = imageUrl == null
        ? UserModel(
            email: userModel.email,
            userName: userNameController.text,
            bio: bioController.text,
            id: userModel.id,
            imageUrl: userModel.imageUrl)
        : UserModel(
            email: userModel.email,
            userName: userNameController.text,
            bio: bioController.text,
            id: userModel.id,
            imageUrl: imageUrl);

    await FirestoreHelper.firestoreHelper.updateProfile(myUserModel);
    getUserFromFireStore();
    Navigator.of(RouteHelper.routeHelper.navKey.currentContext).pop();
  }
}
