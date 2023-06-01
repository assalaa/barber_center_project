import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CompleteProfileWidget extends StatelessWidget {
  const CompleteProfileWidget({
    required this.onPressed,
    required this.titleText,
    required this.buttonText,
    super.key,
  });

  final Function() onPressed;
  final String titleText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Styles.greyColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(
                  titleText,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
