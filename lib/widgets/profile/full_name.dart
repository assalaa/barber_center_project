import 'package:flutter/material.dart';

class FullName extends StatelessWidget {
  const FullName({
    required this.userName,
    this.salonName,
    this.center = true,
    super.key,
  });

  final String userName;
  final String? salonName;
  final bool center;

  @override
  Widget build(BuildContext context) {
    const TextStyle customerStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    const TextStyle salonStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
    return Row(
      mainAxisAlignment:
          center ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:
              center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            salonName != null
                ? Text(salonName!,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold))
                : const SizedBox.shrink(),
            Text(userName,
                style: salonName == null ? customerStyle : salonStyle),
          ],
        ),
      ],
    );
  }
}
