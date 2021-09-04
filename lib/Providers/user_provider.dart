import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Helpers/auth_helper.dart';
import 'package:gsg_fire_base/Auth/Helpers/firesStore_helper.dart';
import 'package:gsg_fire_base/Auth/Helpers/firestorage_helper.dart';
import 'package:gsg_fire_base/Models/user_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UserProvider with ChangeNotifier {
  TextEditingController messageController = TextEditingController();

  resetController() {
    messageController.clear();
  }

  String myId = AuthHelper.authHelper.getUserId();
  UserModel userModel;
  List<UserModel> users;
  Map<String, dynamic> friend = <String, dynamic>{
    'imageUrl': "",
    'userName': "",
    'id': "",
  };

  String uidOfUserAndFriend = "";

  void changeChat(String newChat) {
    // new chat mean new uid for me and friend
    uidOfUserAndFriend = newChat;
    notifyListeners();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFromFirStore(String uid) {
    return FirestoreHelper.firestoreHelper.getFireStoreDmStream(uid);
  }

  getCurrentUserFromFireStore() async {
    String userId = AuthHelper.authHelper.getUserId();
    userModel =
        await FirestoreHelper.firestoreHelper.getUserFromFireStore(userId);
    notifyListeners();
  }

  sendToFireStore() async {
    FirestoreHelper.firestoreHelper
        .addMessageDmToFireStore(uidOfUserAndFriend, <String, dynamic>{
      'message': messageController.text,
      'dateTime': DateTime.now(),
      'messageTime': DateFormat.jm().format(new DateTime.now()).toString(),
      'userName': userModel.userName,
      'imgUrl': userModel.imageUrl,
      'imgMessage': null,
    });
  }

  sendImageToChat([String message]) async {
    XFile img = await ImagePicker().pickImage(source: ImageSource.gallery);
    File file = File(img.path);
    String imageUrl =
        await FireStorageHelper.fireStorageHelper.uploadImage(file, 'chats');
    FirestoreHelper.firestoreHelper
        .addMessageDmToFireStore(uidOfUserAndFriend, <String, dynamic>{
      'message': messageController.text,
      'dateTime': DateTime.now(),
      'messageTime': DateFormat.jm().format(new DateTime.now()).toString(),
      'userName': userModel.userName,
      'imgUrl': userModel.imageUrl,
      'imgMessage': imageUrl,
    });
  }
}
