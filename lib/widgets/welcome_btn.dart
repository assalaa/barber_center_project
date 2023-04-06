import 'package:flutter/cupertino.dart';

import '../utils/app_layout.dart';

class WelcomeButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  final Color buttonTextColor;
  const WelcomeButton({Key? key, required this.buttonName, required this.buttonColor, required this.buttonTextColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppLayout.getWidth(250),
      height: AppLayout.getHeight(70),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: buttonColor),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
            color: buttonTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
