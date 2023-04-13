import 'package:barber_center/utils/app_layout.dart';
import 'package:flutter/material.dart';

class Styles {
  static const Color primaryColor = Color(0xFFFCB320);
  static const Color darkBlueColor = Color(0xFF302D48);
  static const Color backgroundColor = Color(0xFFF7F7F7);
  static const Color greyColor = Color(0xFFA7A6AF);
  static const Color darkTextColor = Color(0xFF000000);
  static const Color pinkColor = Color(0xFFFA7172);
  static const Color blueColor = Color(0xFF6F45F1);
  static const Color orangeColor = Color(0xFFFA7C07);
  static const Color violetColor = Color(0xFFB72DFE);
  static const Color greenColor = Color(0xFF16D391);
  static const Color brightTextColor = Color(0xFFFFFFFF);

  //TEXT STYLES
  static TextStyle textStyle = TextStyle(fontSize: AppLayout.getHeight(16), color: brightTextColor, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle1 = TextStyle(fontSize: AppLayout.getHeight(26), color: darkTextColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 = TextStyle(fontSize: AppLayout.getHeight(25), color: darkTextColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle3 = TextStyle(fontSize: AppLayout.getHeight(20), color: greyColor, fontWeight: FontWeight.w400);
  static TextStyle headLineStyle4 = TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
}
