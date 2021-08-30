import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/constants.dart';

class UserMessageBubble extends StatefulWidget {
  UserMessageBubble({this.text, this.sender, this.messageTime, this.dateTime});
  final text;
  final sender;
  final messageTime;
  final dateTime;
  bool isVis = false;
  @override
  _UserMessageBubbleState createState() => _UserMessageBubbleState();
}

class _UserMessageBubbleState extends State<UserMessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Text(
          //   widget.sender,
          //   style: TextStyle(color: kPrimaryColor, fontSize: 15),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 3),
            child: GestureDetector(
              onTap: () {
                widget.isVis = true;
                setState(() {});
              },
              child: Material(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  elevation: 5,
                  color: kPrimaryColor.withOpacity(0.9),
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      widget.text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Visibility(
            visible: widget.isVis,
            child: Text(
              widget.messageTime,
              style: TextStyle(color: kPrimaryColor, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
