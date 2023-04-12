import 'package:barber_center/utils/app_assets.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/app_strings.dart';

class SalonDetailsScreen extends StatelessWidget {
  const SalonDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.backgroundColor,
        body: ListView(
          children: [
            Stack(children: [
              Container(
                width: AppLayout.getScreenWidth(),
                height: AppLayout.getHeight(300),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(Assets.welcomeBg),
                  fit: BoxFit.fill,
                )),
                child: Container(
                  margin: const EdgeInsets.only(top: 280),
                  height: AppLayout.getHeight(10),
                  decoration: BoxDecoration(color: Styles.backgroundColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(12), vertical: AppLayout.getWidth(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: AppLayout.getHeight(50),
                          height: AppLayout.getWidth(50),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Styles.greyColor.withOpacity(0.4)),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Styles.brighttextColor,
                            ),
                          ),
                        ),
                        Container(
                          width: AppLayout.getHeight(50),
                          height: AppLayout.getWidth(50),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Styles.greyColor.withOpacity(0.4)),
                          child: Center(
                            child: Icon(
                              Icons.favorite,
                              color: Styles.brighttextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
            Expanded(
                flex: 1,
                child: Container(
                  width: AppLayout.getScreenWidth(),
                  height: AppLayout.getHeight(AppLayout.getScreenHeight() - 200),
                  decoration: BoxDecoration(
                    color: Styles.backgroundColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(12), vertical: AppLayout.getWidth(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Salon Name goes here",
                            style: Styles.textStyle.copyWith(fontSize: 24, color: Styles.darktextColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Gap(AppLayout.getHeight(10)),
                        Row(
                          children: [
                            Icon(
                              Icons.pin_drop,
                              color: Styles.primaryColor,
                              size: 30,
                            ),
                            Gap(AppLayout.getWidth(5)),
                            Container(
                              child: Text(
                                "Location Name goes here",
                                style: Styles.textStyle.copyWith(fontSize: 20, color: Styles.greyColor, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Gap(AppLayout.getHeight(25)),
                        Text("services", style: Styles.headLineStyle3),
                        Gap(AppLayout.getHeight(10)),
                        Container(
                          decoration: BoxDecoration(
                            color: Styles.pinkColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          width: AppLayout.getWidth(100),
                          height: AppLayout.getHeight(50),
                          child: Center(
                              child: Text(
                            "Hair style",
                            style: Styles.textStyle,
                          )),
                        ),
                        Gap(AppLayout.getHeight(25)),
                        Text("working hours", style: Styles.headLineStyle3),
                        Gap(AppLayout.getHeight(18)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Opens at:",
                                  style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.w500, fontSize: 20, color: Styles.darktextColor.withOpacity(0.7)),
                                ),
                                Text(
                                  "Open",
                                  style: Styles.textStyle.copyWith(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 21),
                                )
                              ],
                            ),
                            Gap(AppLayout.getHeight(18)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Closes at:",
                                  style: Styles.headLineStyle2.copyWith(fontWeight: FontWeight.w500, fontSize: 20, color: Styles.darktextColor.withOpacity(0.7)),
                                ),
                                Text(
                                  "10PM",
                                  style: Styles.textStyle.copyWith(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 21),
                                ),
                              ],
                            ),
                            Gap(AppLayout.getHeight(18)),
                            LargeRoundedButton(
                              buttonName: Strings.bookingBtn,
                              buttonColor: Styles.primaryColor,
                              buttonTextColor: Styles.brighttextColor,
                              onTap: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ));
  }
}
