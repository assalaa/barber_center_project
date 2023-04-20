import 'package:flutter/material.dart';

class FullName extends StatelessWidget {
  const FullName({
    required this.userName,
    this.salonName,
    super.key,
  });

  final String userName;
  final String? salonName;

  @override
  Widget build(BuildContext context) {
    const TextStyle customerStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold);

    const TextStyle salonStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        salonName != null
            ? Text(salonName!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            : const SizedBox.shrink(),
        Text(userName, style: salonName == null ? customerStyle : salonStyle),
      ],
    ));
  }
}
