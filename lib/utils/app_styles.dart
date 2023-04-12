import 'package:barber_center/utils/app_layout.dart';
import 'package:flutter/material.dart';

class Styles {
  static Color primaryColor = const Color(0xFFFCB320);
  static Color darkBlueColor = const Color(0xFF302D48);
  static Color backgroundColor = const Color(0xFFF7F7F7);
  static Color greyColor = const Color(0xFFA7A6AF);
  static Color darkTextColor = const Color(0xFF000000);
  static Color pinkColor = const Color(0xFFFA7172);
  static Color blueColor = const Color(0xFF6F45F1);
  static Color orangeColor = const Color(0xFFFA7C07);
  static Color violetColor = const Color(0xFFB72DFE);
  static Color greenColor = const Color(0xFF16D391);
  static Color brightTextColor = const Color(0xFFFFFFFF);

  //TEXT STYLES
  static TextStyle textStyle = TextStyle(fontSize: AppLayout.getHeight(16), color: brightTextColor, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle1 = TextStyle(fontSize: AppLayout.getHeight(26), color: darkTextColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 = TextStyle(fontSize: AppLayout.getHeight(25), color: darkTextColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle3 = TextStyle(fontSize: AppLayout.getHeight(20), color: greyColor, fontWeight: FontWeight.w400);
  static TextStyle headLineStyle4 = TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
}
