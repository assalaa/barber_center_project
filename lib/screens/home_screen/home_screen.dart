import 'package:barber_center/screens/home_screen/home_screen_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_assets.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/cards/featured_salons.dart';
import 'package:barber_center/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                      Text(
                        Strings.appName,
                        style: Styles.headLineStyle1,
                      ),
                      //NOTIFICATION ICON
                      Stack(children: [
                        InkWell(
                          onTap: () => Routes.goTo(Routes.customerProfileRoute),
                          child: Container(
                            width: AppLayout.getHeight(50),
                            height: AppLayout.getWidth(50),
                            decoration: BoxDecoration(
                              image: const DecorationImage(image: AssetImage(Assets.unnamedImage), fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(100),
                              color: Styles.greyColor.withOpacity(0.2),
                            ),
                          ),
                        ),
                      ])
                    ],
                  ),
                  SingleChildScrollView(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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

                      //FEATURED SALONS
                      Gap(AppLayout.getHeight(10)),
                      const SectionHeader(sectionTitle: Strings.featuredSalons),
                      Gap(AppLayout.getHeight(20)),
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
                  ),
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
