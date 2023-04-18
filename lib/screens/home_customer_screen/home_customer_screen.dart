import 'package:barber_center/screens/home_customer_screen/home_screen_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/cards/featured_barbers.dart';
import 'package:barber_center/widgets/cards/featured_salons.dart';
import 'package:barber_center/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeCustomerScreen extends StatelessWidget {
  const HomeCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenProvider>(
      create: (context) => HomeScreenProvider(),
      child: Consumer<HomeScreenProvider>(
        builder: (context, provider, _) {
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
                          color: Styles.brightTextColor,
                          border: Border.all(color: Styles.greyColor),
                          borderRadius: BorderRadius.circular(AppLayout.getWidth(12)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Styles.greyColor,
                              ),
                              Text(
                                'Search barber or Salon...',
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
                      child: SingleChildScrollView(
                    child: Column(children: [
                      Gap(AppLayout.getHeight(20)),
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 20),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: provider.services
                                .map((user) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: AppLayout.getWidth(80),
                                          height: AppLayout.getHeight(80),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(image: NetworkImage(user.image), fit: BoxFit.cover),
                                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                                          ),
                                        ),
                                        Gap(AppLayout.getHeight(5)),
                                        Text(user.name)
                                      ],
                                    )))
                                .toList()),
                      ),
                      Gap(AppLayout.getHeight(10)),
                      SectionHeader(
                        sectionTitle: AppLocalizations.of(context)!.featured_barbers,
                        sectionSeeMore: AppLocalizations.of(context)!.see_more,
                      ),
                      Gap(AppLayout.getHeight(10)),
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 20),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: provider.users
                                .map((user) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FeaturedBarber(
                                        barberName: user.name,
                                        barberImage: user.image,
                                        barberLocation: user.city,
                                      ),
                                    ))
                                .toList()),
                      ),
                      //FEATURED SALONS
                      Gap(AppLayout.getHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.featured_salons,
                            style: Styles.headLineStyle2,
                          ),
                          GestureDetector(
                            onTap: () {
                              Routes.goTo(Routes.seeAllSalonsRoute);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.see_more,
                              style: Styles.headLineStyle4,
                            ),
                          )
                        ],
                      ),
                      Gap(AppLayout.getHeight(10)),
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 20),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: provider.users
                                .map((user) => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Routes.goTo(Routes.salonDetailsRoute, args: user.uid);
                                        },
                                        child: FeaturedSalons(
                                          name: user.name,
                                          location: user.city,
                                          image: user.image,
                                        ),
                                      ),
                                    ))
                                .toList()),
                      ),
                    ]),
                  )),
                  //TOP BARBERS SECTION STARTS HERE
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
