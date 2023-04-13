import 'package:flutter/cupertino.dart';

import '../utils/app_layout.dart';

class LargeRoundedButton extends StatelessWidget {
  final String buttonName;
  final Color buttonColor;
  final Color buttonTextColor;
  final bool loading;
  final Function() onTap;
  const LargeRoundedButton({
    required this.buttonName,
    required this.buttonColor,
    required this.buttonTextColor,
    required this.onTap,
    this.loading = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: AppLayout.getWidth(250),
          height: AppLayout.getHeight(70),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: buttonColor,
          ),
          child: Center(
            child: Visibility(
              visible: !loading,
              replacement: const CupertinoActivityIndicator(),
              child: Text(
                buttonName,
                style: TextStyle(
                  fontSize: 20,
                  color: buttonTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
