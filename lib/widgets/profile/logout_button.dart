import 'package:flutter/material.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/screens/profile_screen/profile_screen_provider.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    required this.provider,
    super.key,
  });

  final ProfileScreenProvider provider;

  @override
  Widget build(BuildContext context) {
    const String logoutText = 'Logout';

    return TextButton(
      onPressed: () {
        provider.logout();
      },
      child: const Text(
        logoutText,
        style: TextStyle(
          color: Styles.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
