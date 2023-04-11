import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/app_layout.dart';
import '../../utils/app_styles.dart';

class TopBarbers extends StatelessWidget {
  final String barberName;
  final String location;
  final String openCloseStatus;
  final String closureTime;
  const TopBarbers({Key? key, required this.barberName, required this.location, required this.openCloseStatus, required this.closureTime}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: AppLayout.getWidth(350),
      height: AppLayout.getHeight(150),
      decoration: BoxDecoration(boxShadow: [BoxShadow(color: Styles.greyColor, spreadRadius: 0.5, blurRadius: 15, offset: const Offset(0, 10))], borderRadius: BorderRadius.circular(AppLayout.getHeight(12)), color: Styles.brighttextColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: AppLayout.getWidth(120),
              height: AppLayout.getHeight(120),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Gap(AppLayout.getWidth(10)),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  barberName,
                  style: Styles.headLineStyle3.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text(
                  location,
                  style: Styles.headLineStyle4.copyWith(fontSize: 17),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      openCloseStatus,
                      style: Styles.headLineStyle3.copyWith(fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    SizedBox(width: AppLayout.getWidth(15)),
                    Text(
                      closureTime,
                      style: Styles.headLineStyle3,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
