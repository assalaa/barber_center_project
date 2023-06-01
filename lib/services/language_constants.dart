// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LANGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String ARABIC = 'ar';

Future<Locale> setLocale(String languageCode) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String languageCode = prefs.getString(LANGUAGE_CODE) ?? ENGLISH;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return const Locale(ENGLISH, '');
    case ARABIC:
      return const Locale(ARABIC, '');
    default:
      return const Locale(ENGLISH, '');
  }
}
