import 'dart:ui';

import 'package:flutter/foundation.dart';

class GlobalProvider with ChangeNotifier {
  Locale locale = const Locale.fromSubtags(languageCode: 'en');
  void setLocale(Locale value) {
    locale = value;
    notifyListeners();
  }
}
