import 'package:flutter/services.dart';

class TextInputFormatters {
  static List<TextInputFormatter> denySpaces = [
    FilteringTextInputFormatter.deny(RegExp(r'\s')),
  ];
}
