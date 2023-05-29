import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    required this.onPressed,
    required this.text,
    this.textColor,
    this.buttonColor,
    super.key,
  });

  final Function() onPressed;
  final String text;
  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
      child: Text(text),
    );
  }
}
