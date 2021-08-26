import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedReadField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  TextEditingController controller;

  RoundedReadField({this.controller, this.labelText, this.icon = Icons.person});

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
      child: ListTile(
        leading: Icon(
          icon,
          color: kPrimaryColor,
        ),
        title: Text(labelText),
      ),
    );
  }
}
