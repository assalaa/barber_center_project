import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';

class ServiceElement extends StatelessWidget {
  const ServiceElement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          width: AppLayout.getWidth(70),
          height: AppLayout.getHeight(70),
          decoration: BoxDecoration(
              color: Styles.pinkColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(100)),
          child: const Icon(
            Icons.cut,
            color: Styles.pinkColor,
          ),
        ),
        Gap(AppLayout.getHeight(10)),
        Text(
          'Hair styles',
          style: Styles.textStyle.copyWith(color: Styles.greyColor),
        )
      ],
    );
  }
}
