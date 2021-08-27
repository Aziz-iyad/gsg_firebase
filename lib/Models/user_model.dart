import 'package:flutter/material.dart';

class UserModel {
  String id;
  String email;
  String userName;
  String imageUrl;
  String bio;

  UserModel(
      {@required this.id,
      @required this.email,
      @required this.userName,
      @required this.bio,
      @required this.imageUrl});

  UserModel.fromMap(Map map) {
    this.id = map['id'];
    this.email = map['email'];
    this.userName = map['userName'];
    this.imageUrl = map['imageUrl'];
    this.bio = map['bio'];
  }
  toMap() {
    return {
      'id': this.id,
      'email': this.email,
      'userName': this.userName,
      'imageUrl': this.imageUrl,
      'bio': this.bio,
    };
  }
}
