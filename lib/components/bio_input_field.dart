import 'package:flutter/material.dart';
import '../constants.dart';

class BioInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  TextEditingController controller;

  BioInputField({this.controller, this.hintText, this.icon = Icons.chat});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        maxLines: 8,
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 130),
            child: Icon(
              icon,
              color: kPrimaryColor,
            ),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
