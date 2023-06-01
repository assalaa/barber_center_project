import 'package:barber_center/main.dart';
import 'package:barber_center/models/language.dart';
import 'package:barber_center/services/language_constants.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class WelcomeScreenProvider with ChangeNotifier {
  late Locale _myLocale;

  WelcomeScreenProvider() {
    _init();
  }

  void _init() {
    _myLocale = Localizations.localeOf(Routes.navigator.currentContext!);
    debugPrint('my locale $_myLocale');
    notifyListeners();
  }

  Locale get myLocale => _myLocale;

  bool get isEnglish => _myLocale == const Locale(ENGLISH, '');

  Future<void> changeLanguage(Language? language) async {
    if (language != null) {
      _myLocale = await setLocale(language.languageCode);
      MyApp.setLocale(Routes.navigator.currentContext!, _myLocale);
    }
  }
}
