import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_styles.dart';

class FeaturedBarber extends StatelessWidget {
  const FeaturedBarber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Container(
          width: AppLayout.getWidth(150),
          height: AppLayout.getHeight(150),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Image.asset(fit: BoxFit.cover, Assets.welcomeBg),
        ),
        Container(
          width: AppLayout.getWidth(150),
          height: AppLayout.getHeight(150),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12)),
        ),
        Text(
          "Baeber name",
          style: Styles.textStyle,
        )
      ]),
    );
  }
}
