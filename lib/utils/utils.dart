import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessageError(String message, {Color bgColor = Colors.red}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: openKeyboard() ? ToastGravity.CENTER : ToastGravity.BOTTOM,
    backgroundColor: bgColor,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showMessageSuccessful(String message) {
  showMessageError(message, bgColor: Colors.green);
}

bool openKeyboard() {
  return WidgetsBinding.instance.window.viewInsets.bottom > 0.0;
}

String dateToId(DateTime dateTime) {
  return dateTime.toString().replaceAll(' ', '_').replaceAll('.', '_');
}

String minutesToHours(int time, {int max = 120}) {
  final Duration duration = Duration(minutes: time);

  final int hours = duration.inHours;
  final int minutes = duration.inMinutes - (hours * 60);

  return (hours > 0 ? '$hours hours ' : '') +
      (minutes > 0 ? '$minutes minutes' : '') +
      (time == max ? '+' : '');
}
