import 'package:flutter/material.dart';
import 'package:gsg_fire_base/constants.dart';

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
      width: size.width * 0.8,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Color(0xFFD9D9D9),
              thickness: 2.0,
              height: 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "OR",
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Color(0xFFD9D9D9),
              thickness: 2.0,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
