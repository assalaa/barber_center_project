import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppLayout {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getScreenHeight() {
    return Get.height;
  }

  static double getScreenWidth() {
    return Get.width;
  }

  static dynamic getHeight(double pixels) {
    final double x = getScreenHeight() / pixels;
    return getScreenHeight() / x;
  }

  static dynamic getWidth(double pixels) {
    final double x = getScreenWidth() / pixels;
    return getScreenWidth() / x;
  }
}
