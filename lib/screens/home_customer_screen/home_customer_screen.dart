import 'package:barber_center/screens/home_customer_screen/home_screen_provider.dart';
import 'package:barber_center/services/language_constants.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/cards/featured_salons.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class HomeCustomerScreen extends StatefulWidget {
  const HomeCustomerScreen({Key? key}) : super(key: key);

  @override
  State<HomeCustomerScreen> createState() => _HomeCustomerScreenState();
}

class _HomeCustomerScreenState extends State<HomeCustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeScreenProvider>(
      create: (context) => HomeScreenProvider(),
      child: Consumer<HomeScreenProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  //SEARCH BAR AND NOTIFICATION ICON

                  if (provider.loading) ...[
                    const CenterLoading()
                  ] else ...[
                    const SizedBox(height: 20),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //SEARCH BAR
                          (provider.myLocale == const Locale(ENGLISH, ''))
                              ? const Text(
                                  'El-Mezayen',
                                  style: TextStyle(color: Colors.black, fontFamily: 'DancingScript', fontSize: 40),
                                )
                              : const Text(
                                  'المزين',
                                  style: TextStyle(color: Colors.black, fontFamily: 'decotype', fontSize: 40),
                                ),

                          //NOTIFICATION ICON

                          Stack(
                            children: [
                              Container(
                                width: AppLayout.getHeight(50),
                                height: AppLayout.getWidth(50),
                                decoration: BoxDecoration(image: DecorationImage(image: AssetImage(provider.userModel.image!)), borderRadius: BorderRadius.circular(100), color: Styles.greyColor.withOpacity(0.2)),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    //SERVICES
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: provider.services.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final service = provider.services[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 24, right: 24),
                            child: Column(
                              children: [
                                Container(
                                  width: AppLayout.getWidth(80),
                                  height: AppLayout.getHeight(80),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(service.image), fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                                Gap(AppLayout.getHeight(5)),
                                Text(service.name)
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Gap(AppLayout.getHeight(10)),

                    //FEATURED SALONS
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                      child: SectionHeader(
                        sectionTitle: AppLocalizations.of(context)!.featured_salons,
                        sectionSeeMore: '',
                      ),
                    ),
                    Gap(AppLayout.getHeight(10)),
                    SizedBox(
                      height: 230 + 24 * 2,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: provider.salons.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final salon = provider.salons[index];
                          final salonInfo = provider.salonsInformation[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 24, top: 4, bottom: 4, right: 24),
                            child: GestureDetector(
                              onTap: () {
                                Routes.goTo(
                                  Routes.salonDetailsRoute,
                                  args: salon.uid,
                                  enableBack: true,
                                );
                              },
                              child: FeaturedSalons(
                                name: salon.name,
                                location: salon.city,
                                image: salon.image,
                                timeOpen: salonInfo.openTime.hour,
                                timeClose: salonInfo.closeTime.hour,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
