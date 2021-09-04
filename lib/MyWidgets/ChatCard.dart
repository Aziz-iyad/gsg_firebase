import 'package:flutter/material.dart';
import 'package:gsg_fire_base/AppScreens/GroupChat_Screen.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/constants.dart';

class ChatCard extends StatelessWidget {
  String title;
  String img;
  Function function;
  ChatCard({this.title, this.img, this.function});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(0xFFF3F4F9),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 15,
              offset: Offset(1, 1), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: function,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(img),
                    radius: 35,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    title,
                    style: TextStyle(color: kPrimaryColor, fontSize: 20),
                  ),
                  SizedBox(
                    width: 95,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
