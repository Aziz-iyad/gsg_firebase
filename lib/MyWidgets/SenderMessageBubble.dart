import 'package:flutter/material.dart';
import 'package:gsg_fire_base/constants.dart';

class SenderMessageBubble extends StatefulWidget {
  SenderMessageBubble(
      {this.text,
      this.sender,
      this.messageTime,
      this.imgMessage,
      this.imgUrl,
      this.dateTime});
  final text;
  final sender;
  final messageTime;
  final dateTime;
  final imgUrl;
  final imgMessage;
  bool isVis = false;
  @override
  _SenderMessageBubbleState createState() => _SenderMessageBubbleState();
}

class _SenderMessageBubbleState extends State<SenderMessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              widget.imgMessage == null
                  ? CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(widget.imgUrl),
                    )
                  : SizedBox(
                      width: 1,
                    ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.sender,
                    style: TextStyle(color: kPrimaryColor, fontSize: 15),
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.isVis = true;
                      setState(() {});
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 3),
                      child: Material(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          elevation: 5,
                          color: Colors.white54,
                          child: Padding(
                            padding: EdgeInsets.all(15.0),
                            child: widget.imgMessage == null
                                ? Text(
                                    widget.text,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  )
                                : Image.network(
                                    widget.imgMessage,
                                    fit: BoxFit.fill,
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
            ],
          ),
        ],
      ),
    );
  }
}
