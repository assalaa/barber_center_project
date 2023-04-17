import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ServiceElement extends StatelessWidget {
  final String serviceImage;
  final String serviceName;
  const ServiceElement({
    required this.serviceName,
    required this.serviceImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(8),
            width: AppLayout.getWidth(70),
            height: AppLayout.getHeight(70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.network(
              serviceImage,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Gap(AppLayout.getHeight(10)),
        Text(
          serviceName,
          style: Styles.textStyle.copyWith(color: Styles.greyColor),
        )
      ],
    );
  }
}
