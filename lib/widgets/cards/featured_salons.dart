import 'package:barber_center/utils/app_assets.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FeaturedSalons extends StatelessWidget {
  final String name;
  final String location;
  final String? image;
  final int timeOpen;
  const FeaturedSalons({
    required this.name,
    required this.location,
    required this.image,
    Key? key,
    required this.timeOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppLayout.getWidth(200),
      height: AppLayout.getHeight(230),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(12),
        color: Styles.brightTextColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.all(8),
              width: AppLayout.getWidth(1800),
              height: AppLayout.getHeight(120),
              child: (image != null)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        image!,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        Assets.welcomeBg,
                        fit: BoxFit.cover,
                      ),
                    )),
          Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Styles.headLineStyle3.copyWith(fontWeight: FontWeight.bold, color: Styles.darkTextColor),
                ),
                Text(
                  location,
                ),
                RichText(
                  text: TextSpan(
                    text: AppLocalizations.of(context)!.opens_at,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '${timeOpen.toString()} ${AppLocalizations.of(context)!.morning_time}',
                        style: Styles.textStyle.copyWith(color: Styles.greenColor, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
