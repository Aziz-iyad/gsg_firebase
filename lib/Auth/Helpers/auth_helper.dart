import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsg_fire_base/Auth/Screens/GetStarted/GetStartedScreen.dart';
import '../../AppScreens/HomeScreen.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/Services/custom_dialoug.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  String getUserId() {
    return firebaseAuth.currentUser.uid;
  }

  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await RouteHelper.routeHelper.goTOReplacement(GetStartedScreen.routeName);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialog.customDialog.showCustomDialog(
            message: 'The password provided is too weak.',
            dialogType: DialogType.ERROR,
            function: null);
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.customDialog.showCustomDialog(
          message: 'The account already exists for that email.',
          dialogType: DialogType.QUESTION,
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      await RouteHelper.routeHelper.goTOReplacement(HomeScreen.routeName);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.customDialog.showCustomDialog(
          message: 'No user found for that email.',
          dialogType: DialogType.ERROR,
        );
      } else if (e.code == 'wrong-password') {
        CustomDialog.customDialog.showCustomDialog(
          message: 'Wrong password provided for that user.',
          dialogType: DialogType.ERROR,
        );
      }
    }
  }

  User getCurrentUser() {
    User user = firebaseAuth.currentUser;
    print(user.email);
    user.getIdToken().then((value) => print(value));
    return user;
  }

  String getCurrentUserEmail() {
    User user = firebaseAuth.currentUser;
    String email = user.email;

    return email;
  }

  verifyEmail() async {
    await firebaseAuth.currentUser.sendEmailVerification();
    CustomDialog.customDialog.showCustomDialog(
      message: 'verification email has been sent, please check your email',
      dialogType: DialogType.SUCCES,
    );
  }

  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    CustomDialog.customDialog.showCustomDialog(
      message: 'we have sent email for reset password, please check your email',
      dialogType: DialogType.SUCCES,
    );
  }

  bool checkEmailVerification() {
    return firebaseAuth.currentUser?.emailVerified ?? false;
  }

  logout() async {
    firebaseAuth.signOut();
  }

  myVerification() async {
    await firebaseAuth.currentUser.sendEmailVerification();
    CustomDialog.customDialog.showCustomDialog(
      message: 'verification email has been sent, please check your email',
      dialogType: DialogType.SUCCES,
    );
    firebaseAuth.signOut();
  }

  bool checkUserLogin() {
    if (firebaseAuth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }
}
