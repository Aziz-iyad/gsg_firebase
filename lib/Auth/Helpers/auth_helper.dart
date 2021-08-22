import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsg_fire_base/HomeScreen.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/Services/custom_dialoug.dart';

class AuthHelper {
  AuthHelper._();

  static AuthHelper authHelper = AuthHelper._();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  signUp(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await verifyEmail();
      logout();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomDialog.customDialog
            .showCustomDialog('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomDialog.customDialog
            .showCustomDialog('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  signIn(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomDialog.customDialog
            .showCustomDialog('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CustomDialog.customDialog
            .showCustomDialog('Wrong password provided for that user.');
      }
    }
    bool isVerifiedEmail = AuthHelper.authHelper.checkEmailVerification();
    if (isVerifiedEmail) {
      RouteHelper.routeHelper.goTOReplacement(HomeScreen.routeName);
    } else {
      CustomDialog.customDialog.showCustomDialog(
          'You have to verify your email, press ok to send a Verification email',
          myVerification());
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
      'verification email has been sent, please check your email',
    );
  }

  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
    CustomDialog.customDialog.showCustomDialog(
        'we have sent email for reset password, please check your email');
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
      'verification email has been sent, please check your email',
    );
    firebaseAuth.signOut();
  }
}