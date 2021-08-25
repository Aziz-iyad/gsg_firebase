import 'package:flutter/material.dart';

class CustomTextFiled extends StatelessWidget {
  String label;
  TextEditingController controller;
  CustomTextFiled({this.label, this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextField(
        controller: this.controller,
        decoration: InputDecoration(
            labelText: this.label,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}
