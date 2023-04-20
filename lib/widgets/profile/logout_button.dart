import 'package:flutter/material.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/screens/profile_screen/profile_screen_provider.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    required this.onPressed,
    super.key,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    var logoutText = AppLocalizations.of(context)!.logout;

    return TextButton(
      onPressed: onPressed,
      child: const Text(
        logoutText,
        style: const TextStyle(
          color: Styles.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
