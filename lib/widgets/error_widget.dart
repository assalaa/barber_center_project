import 'package:flutter/material.dart';

class SnapshotErrorWidget extends StatelessWidget {
  const SnapshotErrorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String errorText = 'Somethings went wrong. Please try again later';
    return const Center(child: Text(errorText));
  }
}
