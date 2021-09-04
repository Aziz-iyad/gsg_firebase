import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Auth/Helpers/auth_helper.dart';
import 'package:gsg_fire_base/Auth/Helpers/firesStore_helper.dart';
import 'HomeScreen.dart';
import 'package:gsg_fire_base/MyWidgets/SenderMessageBubble.dart';
import 'package:gsg_fire_base/MyWidgets/UserMessageBubble.dart';
import 'package:gsg_fire_base/Providers/authProvider.dart';
import 'package:gsg_fire_base/Services/Router.dart';
import 'package:gsg_fire_base/constants.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GroupChatScreen extends StatelessWidget {
  static final routeName = 'GroupChatScreen';
  ScrollController scrollController = ScrollController();
  String currentId = AuthHelper.authHelper.getUserId();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 115,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  // color: Color(0xff651CE5).withOpacity(0.3),
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: Offset(1, 2), // changes position of shadow
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 0.9],
                colors: [
                  Color(0xffA524C8),
                  // Color(0xFF8D15D1),
                  Color(0xff7203DB),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 14,
                left: 25,
                right: 25,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                      onPressed: () {
                        RouteHelper.routeHelper.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      iconSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      width: 296,
                      height: 45,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          stops: [0.1, 0.9],
                          colors: [
                            Color(0xffA524C8),
                            // Color(0xFF8D15D1),
                            Color(0xff7203DB),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            // color: Color(0xff651CE5).withOpacity(0.3),
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 12,
                            offset: Offset(1, 10), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              'Search...',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<AuthProvider>(
              builder: (context, provider, x) {
                return Column(
                  children: [
                    Expanded(
                      child: Container(
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirestoreHelper.firestoreHelper
                              .getFireStoreStream(),
                          builder: (context, snapshot) {
                            Future.delayed(Duration(milliseconds: 100))
                                .then((value) {
                              scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeInOut);
                            });
                            QuerySnapshot<Map<dynamic, dynamic>> querySnapshot;
                            List<Map<dynamic, dynamic>> messages;
                            if (snapshot.hasData) {
                              querySnapshot = snapshot.data;
                              messages = querySnapshot.docs
                                  .map((QueryDocumentSnapshot<
                                              Map<dynamic, dynamic>>
                                          e) =>
                                      e.data())
                                  .toList();
                            }

                            return querySnapshot == null
                                ? CircularProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    color: Colors.black,
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    controller: scrollController,
                                    reverse: false,
                                    itemCount: messages.length,
                                    itemBuilder: (context, index) {
                                      String user = messages[index]['userId'];

                                      // print(currentId);
                                      // print(provider.myId);
                                      // print(user);
                                      return currentId == user
                                          ? UserMessageBubble(
                                              text: messages[index]['message'],
                                              imgMessage: messages[index]
                                                  ['imgMessage'],
                                              sender: messages[index]
                                                  ['userName'],
                                              messageTime: messages[index]
                                                  ['messageTime'],
                                              dateTime: messages[index]
                                                  ['dateTime'],
                                            )
                                          : SenderMessageBubble(
                                              text: messages[index]['message'],
                                              imgMessage: messages[index]
                                                  ['imgMessage'],
                                              sender: messages[index]
                                                  ['userName'],
                                              imgUrl: messages[index]['imgUrl'],
                                              messageTime: messages[index]
                                                  ['messageTime'],
                                              dateTime: messages[index]
                                                  ['dateTime'],
                                            );
                                    });
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            // color: Color(0xff651CE5).withOpacity(0.3),
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 12,
                            offset: Offset(1, 5), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  provider.sendImageToChat();
                                },
                                icon: Icon(
                                  Icons.attach_file,
                                  color: Color(0xFF64297B),
                                )),
                            // IconButton(
                            //     onPressed: () {
                            //       provider.sendVoiceToChat();
                            //     },
                            //     icon: Icon(
                            //       Icons.keyboard_voice,
                            //       color: Color(0xFF64297B),
                            //     )),
                            Image.asset(
                              'assets/icons/emoji.png',
                              color: Color(0xFF64297B),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: TextField(
                              controller: provider.messageController,
                              cursorColor: kPrimaryColor,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Type Something',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF64297B),
                                  )),
                            )),
                            IconButton(
                                onPressed: () {
                                  provider.sendToFireStore();
                                  provider.resetController();
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: kPrimaryColor,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
    ;
  }
}
