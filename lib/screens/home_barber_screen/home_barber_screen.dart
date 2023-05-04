import 'package:barber_center/screens/barber/home_barber_screen/home_barber_provider.dart';
import 'package:barber_center/services/language_constants.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/section_header.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import 'package:barber_center/services/routes.dart';
import 'package:barber_center/widgets/complete_profile_widget.dart';

class HomeBarberScreen extends StatelessWidget {
  const HomeBarberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeBarberProvider>(
      create: (context) => HomeBarberProvider(),
      child: Consumer<HomeBarberProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
            ),
            body: Column(children: [
              if (provider.loading) ...[
                const CenterLoading()
              ] else ...[
                if (!provider.isProfileCompleted) ...[
                  CompleteProfileWidget(
                    titleText: 'Your profile isn\'t complete',
                    buttonText: 'Complete',
                    onPressed: () => Routes.goTo(Routes.barberOptionsRoute,
                        enableBack: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //SEARCH BAR
                        (provider.myLocale == const Locale(ENGLISH, ''))
                            ? const Text(
                                'El-Mezayen',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'DancingScript',
                                    fontSize: 40),
                              )
                            : const Text(
                                'المزين',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'decotype',
                                    fontSize: 40),
                              ),

                        //NOTIFICATION ICON
                        Stack(
                          children: [
                            Container(
                              width: AppLayout.getHeight(50),
                              height: AppLayout.getWidth(50),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'provider.userModel.image!')),
                                  borderRadius: BorderRadius.circular(100),
                                  color: Styles.greyColor.withOpacity(0.2)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
                Gap(AppLayout.getHeight(45)),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: SectionHeader(
                    sectionTitle: AppLocalizations.of(context)!.appointments,
                    sectionSeeMore: '',
                  ),
                ),
                Gap(AppLayout.getHeight(25)),

                //Booking list goes here
                Expanded(
                  child: ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.all(8),
                          child: AppointementCard(),
                        );
                      }),
                ),
              ],
            ]),
          );
        },
      ),
    );
  }
}

class AppointementCard extends StatelessWidget {
  const AppointementCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Gap(AppLayout.getWidth(5)),
          //Time section goes here
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              DateListIndicator(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  '11:00 AM',
                  style: TextStyle(
                      color: Styles.darkBlueColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          // Customer card details goes here
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              width: 270,
              height: 100,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Customer Image
                  Row(
                    children: [
                      const CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                          )),
                      Gap(AppLayout.getWidth(15)),
                      //Customer name
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name last name',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Gap(AppLayout.getHeight(5)),
                          Row(
                            children: const [
                              Icon(
                                FluentSystemIcons.ic_fluent_location_filled,
                                size: 20,
                                color: Styles.primaryColor,
                              ),
                              Text(
                                'Customer address ',
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          )
                        ],
                      ),

                      //Address
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]);
  }
}

class DateListIndicator extends StatelessWidget {
  const DateListIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Styles.primaryColor),
      ),
      Container(
        padding: const EdgeInsets.all(12),
        width: 1,
        height: 100,
        color: Colors.grey,
      )
    ]);
  }
}
