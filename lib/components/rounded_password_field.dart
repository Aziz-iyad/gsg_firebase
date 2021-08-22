import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedPasswordField extends StatefulWidget {
  TextEditingController controller;
  RoundedPasswordField({this.controller});

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool value = true;
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
        controller: widget.controller,
        obscureText: value,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.visibility),
            onPressed: () {
              setState(() {
                value = !value;
              });
            },
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
