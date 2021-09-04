import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gsg_fire_base/constants.dart';

class CustomProgress {
  CustomProgress._();
  static CustomProgress customProgress = CustomProgress._();
  SpinKitDoubleBounce showProgressIndicator() {
    return SpinKitDoubleBounce(
      color: Colors.white,
      size: 50.0,
    );
  }

  SpinKitRipple spinKitRipple() {
    return SpinKitRipple(
      color: kPrimaryColor,
      size: 50,
    );
  }

  SpinKitHourGlass spinKitHourGlass() {
    return SpinKitHourGlass(
      color: Colors.white,
      size: 50.0,
    );
  }
}
