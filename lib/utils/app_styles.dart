import 'package:flutter/material.dart';

import 'app_layout.dart';

class Styles {
  static Color primaryColor = const Color(0xFFFCB320);
  static Color darkblueColor = const Color(0xFF302D48);
  static Color backgroundColor = const Color(0xFFF7F7F7);
  static Color greyColor = const Color(0xFFA7A6AF);
  static Color darktextColor = const Color(0xFF000000);
  static Color brighttextColor = const Color(0xFFFFFFFF);
  //static Color greytextColor = const Color(0xFFFFFFFF);

  //TEXT STYLES
  static TextStyle textStyle = TextStyle(fontSize: AppLayout.getHeight(16), color: brighttextColor, fontWeight: FontWeight.w500);
  static TextStyle headLineStyle1 = TextStyle(fontSize: AppLayout.getHeight(26), color: darktextColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle2 = TextStyle(fontSize: AppLayout.getHeight(25), color: darktextColor, fontWeight: FontWeight.bold);
  static TextStyle headLineStyle3 = TextStyle(fontSize: AppLayout.getHeight(20), color: greyColor, fontWeight: FontWeight.w400);
  static TextStyle headLineStyle4 = TextStyle(fontSize: 14, color: Colors.grey.shade500, fontWeight: FontWeight.w500);
}
