import 'package:flutter/material.dart';

class RegisterRequest {
  String id;
  String email;
  String userName;
  String imageUrl;
  String bio;
  RegisterRequest(
      {this.id,
      @required this.email,
      @required this.userName,
      @required this.bio,
      @required this.imageUrl});

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
