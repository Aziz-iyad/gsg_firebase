import 'package:flutter/material.dart';
import 'package:gsg_fire_base/Providers/user_provider.dart';
import 'package:gsg_fire_base/constants.dart';

class WelcomeFirstTime extends StatelessWidget {
  final UserProvider provider;
  WelcomeFirstTime({this.provider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 100,
          width: 100,
          child: Image.asset(
            'assets/icons/1.jpg',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Start chatting with ${provider.friend['userName']} now!',
          style: TextStyle(
            fontSize: 23,
            color: kPrimaryColor.withOpacity(0.6),
          ),
        )
      ],
    );
  }
}
