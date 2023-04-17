import 'package:barber_center/utils/app_assets.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class FeaturedBarber extends StatelessWidget {
  final String barberName;
  final String? barberImage;
  final String barberLocation;
  const FeaturedBarber({
    required this.barberName,
    required this.barberImage,
    required this.barberLocation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12)),
      child: Stack(children: [
        Container(
          width: AppLayout.getWidth(150),
          height: AppLayout.getHeight(150),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: barberImage != null ? Image.network(fit: BoxFit.cover, barberImage!) : Image.asset(Assets.unnamedImage),
        ),
        Container(
          width: AppLayout.getWidth(150),
          height: AppLayout.getHeight(150),
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.4), borderRadius: BorderRadius.circular(12)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100, left: 10),
          child: Column(
            children: [
              Text(
                barberName,
                style: Styles.textStyle,
              ),
              Gap(AppLayout.getHeight(5)),
              Text(
                barberLocation,
                style: Styles.textStyle.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
