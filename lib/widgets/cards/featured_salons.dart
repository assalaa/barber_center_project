import 'package:barber_center/utils/app_assets.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';

class FeaturedSalons extends StatelessWidget {
  final String name;
  final String location;
  final String? image;
  final int timeOpen;
  final int timeClose;
  const FeaturedSalons({
    required this.name,
    required this.location,
    required this.image,
    required this.timeOpen,
    required this.timeClose,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppLayout.getWidth(230),
      height: AppLayout.getHeight(260),
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
              width: AppLayout.getWidth(230),
              height: AppLayout.getHeight(150),
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
            margin: const EdgeInsets.only(right: 12, left: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Styles.headLineStyle3.copyWith(
                      fontWeight: FontWeight.bold, color: Styles.darkTextColor),
                ),
                Gap(AppLayout.getHeight(5)),
                Row(
                  children: [
                    const Icon(
                      FluentSystemIcons.ic_fluent_location_filled,
                      size: 18,
                      color: Styles.primaryColor,
                    ),
                    Text(
                      location,
                    ),
                  ],
                ),
                Gap(AppLayout.getHeight(5)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.opens_at,
                          style: const TextStyle(
                            color: Styles.greyColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(AppLayout.getHeight(4)),
                        Text(
                          ' $timeOpen ${AppLocalizations.of(context)!.morning_time}',
                          style: Styles.textStyle.copyWith(
                              color: Styles.greenColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.closes_at,
                          style: const TextStyle(
                            color: Styles.greyColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(AppLayout.getHeight(4)),
                        Text(
                          ' ${timeClose.toString()} ${AppLocalizations.of(context)!.morning_time}',
                          style: Styles.textStyle.copyWith(
                              color: Styles.orangeColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
