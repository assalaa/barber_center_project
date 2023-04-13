import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessageError(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: openKeyboard() ? ToastGravity.CENTER : ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

bool openKeyboard() {
  return WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
}

String dateToId(DateTime dateTime) {
  return dateTime.toString().replaceAll(' ', '_').replaceAll('.', '_');
}
