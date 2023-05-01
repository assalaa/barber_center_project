import 'package:flutter/services.dart';

class TextInputFormatters {
  static List<TextInputFormatter> denySpaces = [
    FilteringTextInputFormatter.deny(RegExp(r'\s')),
  ];

  static List<TextInputFormatter> digitsOnly = [
    FilteringTextInputFormatter.deny(RegExp(r'\s')),
    FilteringTextInputFormatter.digitsOnly,
  ];
}
