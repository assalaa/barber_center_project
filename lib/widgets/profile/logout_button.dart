import 'package:flutter/material.dart';
import 'package:barber_center/utils/app_styles.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    required this.onPressed,
    super.key,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    const String logoutText = 'Logout';

    return TextButton(
      onPressed: onPressed,
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
