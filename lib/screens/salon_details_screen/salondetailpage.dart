import 'package:barber_center/screens/profile_salon_screen/profile_salon_screen.dart';
import 'package:barber_center/screens/salon_details_screen/salon_details_screen.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_assets.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/profile/full_name.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:barber_center/screens/salon_details_screen/salon_details_provider.dart';

class SalonDetailPage extends StatelessWidget {
  final String uid;
  const SalonDetailPage({required this.uid, super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SalonDetailsProvider>(
        create: (context) => SalonDetailsProvider(uid),
        child: Consumer<SalonDetailsProvider>(builder: (context, provider, _) {
          return Scaffold(
              body: Column(children: [
            if (provider.loading) ...[
              const CenterLoading()
            ] else ...[
              Stack(
                children: [
                  if (provider.salon.image != null) ...[
                    Image.network(
                      provider.salon.image!,
                      width: AppLayout.getScreenWidth(),
                      height: AppLayout.getHeight(300),
                      fit: BoxFit.cover,
                    ),
                  ] else ...[
                    Image.asset(
                      Assets.welcomeBg,
                      width: AppLayout.getScreenWidth(),
                      height: AppLayout.getHeight(300),
                      fit: BoxFit.cover,
                      color: const Color(0xff141212).withOpacity(0.6),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ],
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: SafeArea(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Material(
                            color: Styles.greyColor.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(100),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                Routes.back();
                              },
                              child: Container(
                                width: AppLayout.getHeight(50),
                                height: AppLayout.getWidth(50),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: Styles.brightTextColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              //BODY
              Expanded(
                child: Container(
                  width: AppLayout.getScreenWidth(),
                  // height: AppLayout.getHeight(
                  //     900), // AppLayout.getScreenHeight(),
                  decoration: const BoxDecoration(
                    color: Styles.backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppLayout.getWidth(14),
                    vertical: AppLayout.getWidth(14),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FullName(
                        userName: provider.salon.name,
                        salonName: provider.salonInformation?.salonName,
                        center: false,
                      ),
                      Gap(AppLayout.getHeight(8)),
                      LocationInfo(
                        location:
                            provider.salonInformation?.location?.getAddress ??
                                provider.salonInformation?.address,
                        center: false,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              const Divider(),
                              Services(provider: provider),
                              const SizedBox(height: 16),
                              EstTimeAndTotalPrice(
                                visible: provider.hasItemSelected,
                                time:
                                    provider.salonService.stringDurationInMin,
                                price: provider.salonService.stringPrice,
                              ),
                              const SizedBox(height: 10),
                              Barbers(provider: provider),
                              const Divider(),
                              LocationButton(provider: provider),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      BookButton(provider: provider),
                    ],
                  ),
                ),
              ),
            ],
          ]));
        }));
  }
}
