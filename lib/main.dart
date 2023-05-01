import 'package:barber_center/firebase_options.dart';
import 'package:barber_center/services/language_constants.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: constant_identifier_names
enum KindOfUser { CUSTOMER, BARBER, SALON, ADMIN }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.backgroundColor,
        primaryColor: Styles.primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Styles.backgroundColor,
          foregroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Styles.greyColor),
          ),
          filled: true,
          fillColor: Styles.brightTextColor,
          hintStyle: const TextStyle(fontSize: 20.0, color: Styles.greyColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Styles.greyColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
            borderSide: const BorderSide(color: Styles.primaryColor, width: 2),
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
          ),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      onGenerateRoute: Routes.generateRoute,
      navigatorKey: Routes.navigator,
      initialRoute: Routes.splashRoute,
      title: 'El-Mezayen',
    );
  }
}
