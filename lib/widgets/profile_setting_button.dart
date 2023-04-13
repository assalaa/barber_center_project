import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ProfileSettingButton extends StatelessWidget {
  const ProfileSettingButton({
    required this.icon,
    required this.text,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.shade200,
                radius: 24,
                child: Icon(
                  icon,
                  color: Styles.primaryColor,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
