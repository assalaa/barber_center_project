import 'package:barber_center/utils/app_layout.dart';
import 'package:flutter/material.dart';

class CenterLoading extends StatelessWidget {
  const CenterLoading({
    this.bottomMargin = 100,
    super.key,
  });

  final int bottomMargin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppLayout.getScreenHeight() - bottomMargin,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
