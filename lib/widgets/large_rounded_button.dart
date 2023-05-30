import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LargeRoundedButton extends StatelessWidget {
  const LargeRoundedButton({
    required this.buttonName,
    required this.onTap,
    this.enabled = true,
    this.buttonColor = Styles.primaryColor,
    this.buttonTextColor = Styles.brightTextColor,
    this.loading = false,
    this.iconData,
    Key? key,
  }) : super(key: key);

  final String buttonName;
  final Color buttonColor;
  final Color buttonTextColor;
  final IconData? iconData;
  final bool loading;
  final bool enabled;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled ? onTap : null,
      style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
          minimumSize: const Size(double.infinity, 56),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(22))),
      child: Visibility(
        visible: !loading,
        replacement: const CupertinoActivityIndicator(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null) ...[
              Icon(
                iconData,
                color: buttonTextColor,
              ),
              const SizedBox(width: 6),
            ],
            Flexible(
              child: Text(
                buttonName,
                style: TextStyle(
                  fontSize: 18,
                  color: buttonTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
