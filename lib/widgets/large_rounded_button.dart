import 'package:barber_center/utils/app_layout.dart';
import 'package:flutter/material.dart';

class LargeRoundedButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  final Color buttonTextColor;
  final Function onPressed;

  const LargeRoundedButton({
    Key? key,
    required this.buttonName,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppLayout.getWidth(250),
      height: AppLayout.getHeight(70),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: buttonTextColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          backgroundColor: buttonColor,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed(),
        child: Text(buttonName),
      ),
    );
  }
}
