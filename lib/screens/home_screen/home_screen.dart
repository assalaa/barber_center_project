import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/cards/featured_barbers.dart';
import 'package:barber_center/widgets/cards/featured_salons.dart';
import 'package:barber_center/widgets/cards/top_barbers.dart';
import 'package:barber_center/widgets/section_header.dart';
import 'package:barber_center/widgets/service_element.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.backgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(45), horizontal: AppLayout.getWidth(12)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Search BAR
                Container(
                  width: AppLayout.getWidth(250),
                  height: AppLayout.getHeight(50),
                  decoration: BoxDecoration(
                    color: Styles.brighttextColor,
                    border: Border.all(color: Styles.greyColor),
                    borderRadius: BorderRadius.circular(AppLayout.getWidth(12)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          color: Styles.greyColor,
                        ),
                        Text(
                          "Search barber or Salon...",
                          style: Styles.textStyle.copyWith(color: Styles.greyColor),
                        )
                      ],
                    ),
                  ),
                ),
                //NOTIFICATION ICON
                Stack(children: [
                  Container(
                    width: AppLayout.getHeight(50),
                    height: AppLayout.getWidth(50),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Styles.greyColor.withOpacity(0.2)),
                    child: Icon(
                      Icons.notifications_none_outlined,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    bottom: 35,
                    child: Container(
                      width: AppLayout.getWidth(15),
                      height: AppLayout.getHeight(15),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Styles.primaryColor),
                    ),
                  )
                ])
              ],
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Gap(AppLayout.getHeight(20)),
                  const SectionHeader(sectionTitle: Strings.topBarbers),
                  Gap(AppLayout.getHeight(20)),
                  //Card
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    scrollDirection: Axis.horizontal,
                    child: Row(children: const [TopBarbers(barberName: "barberName", location: "location", openCloseStatus: "open", closureTime: "Time"), TopBarbers(barberName: "barberName", location: "location", openCloseStatus: "open", closureTime: "Time")]),
                  ),
                  const SectionHeader(sectionTitle: Strings.services),
                  Gap(AppLayout.getHeight(20)),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    scrollDirection: Axis.horizontal,
                    child: Row(children: const [
                      ServiceElement(),
                      ServiceElement(),
                      ServiceElement(),
                      ServiceElement(),
                      ServiceElement(),
                    ]),
                  ),
                  Gap(AppLayout.getHeight(20)),
                  const SectionHeader(sectionTitle: Strings.featuredBarbers),
                  Gap(AppLayout.getHeight(20)),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    scrollDirection: Axis.horizontal,
                    child: Row(children: const [
                      FeaturedBarber(),
                      FeaturedBarber(),
                      FeaturedBarber(),
                    ]),
                  ),
                  Gap(AppLayout.getHeight(20)),
                  const SectionHeader(sectionTitle: Strings.featuredSalons),
                  Gap(AppLayout.getHeight(20)),
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 10, bottom: 20),
                    scrollDirection: Axis.horizontal,
                    child: Row(children: const [
                      FeaturedSalons(),
                      FeaturedSalons(),
                      FeaturedSalons(),
                    ]),
                  ),
                ],
              ),
            ),
            //TOP BARBERS SECTION STARTS HERE
            //TOP BARBERS SECTION STARTS HERE
            Gap(AppLayout.getHeight(20)),
            const SectionHeader(sectionTitle: Strings.topBarbers),
            Gap(AppLayout.getHeight(20)),
            Container(
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
                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Barber's Name",
                          style: Styles.headLineStyle3.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Location goes here",
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
                              "Open",
                              style: Styles.headLineStyle3.copyWith(fontWeight: FontWeight.bold, color: Colors.green),
                            ),
                            SizedBox(
                              width: AppLayout.getWidth(12),
                            ),
                            Text(
                              "Closes10pm",
                              style: Styles.headLineStyle3,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
