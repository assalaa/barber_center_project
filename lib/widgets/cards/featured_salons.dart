import 'package:flutter/material.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_styles.dart';

class FeaturedSalons extends StatelessWidget {
  const FeaturedSalons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
          margin: EdgeInsets.all(8),
          width: AppLayout.getWidth(200),
          height: AppLayout.getHeight(230),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ], borderRadius: BorderRadius.circular(12), color: Styles.brighttextColor),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(8),
                width: AppLayout.getWidth(170),
                height: AppLayout.getHeight(120),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.welcomeBg),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.green,
                ),
              ),
              Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Salon name",
                      style: Styles.headLineStyle3.copyWith(fontWeight: FontWeight.bold, color: Styles.darktextColor),
                    ),
                    const Text(
                      "Salon location",
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "open",
                          style: Styles.textStyle.copyWith(color: Colors.green),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star_border,
                              color: Styles.primaryColor,
                            ),
                            const Text(
                              "4.2",
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}
