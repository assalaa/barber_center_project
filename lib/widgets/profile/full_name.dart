import 'package:flutter/material.dart';

class FullName extends StatelessWidget {
  const FullName({
    required this.fullName,
    super.key,
  });

  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(fullName,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}
