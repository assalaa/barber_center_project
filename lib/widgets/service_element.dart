import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ServiceElement extends StatelessWidget {
  final Color serviceColor;
  final Color containerColor;
  final IconData serviceIcon;
  final String serviceName;
  const ServiceElement({Key? key, required this.serviceColor, required this.serviceIcon, required this.serviceName, required this.containerColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          width: AppLayout.getWidth(70),
          height: AppLayout.getHeight(70),
          decoration: BoxDecoration(color: containerColor.withOpacity(0.5), borderRadius: BorderRadius.circular(100)),
          child: Icon(
            serviceIcon,
            color: serviceColor,
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
