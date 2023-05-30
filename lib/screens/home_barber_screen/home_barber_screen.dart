import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/models/booking_model.dart';
import 'package:barber_center/screens/home_barber_screen/home_barber_provider.dart';
import 'package:barber_center/services/language_constants.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/complete_profile_widget.dart';
import 'package:barber_center/widgets/section_header.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

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
                const CenterLoading(bottomMargin: 300)
              ] else ...[
                if (!provider.isProfileCompleted) ...[
                  CompleteProfileWidget(
                    titleText: 'Your profile isn\'t complete',
                    buttonText: 'Complete',
                    onPressed: () => Routes.goTo(Routes.barberOptionsRoute,
                        enableBack: true),
                  ),
                ],
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
                                image: provider.userHasPhoto
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            provider.barberModel!.image!))
                                    : null,
                                borderRadius: BorderRadius.circular(100),
                                color: Styles.greyColor.withOpacity(0.2)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (provider.barberBookings.isEmpty) ...[
                        const Center(
                          child: Text('No bookings'),
                        )
                      ] else ...[
                        Gap(AppLayout.getHeight(25)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: SectionHeader(
                            sectionTitle:
                                AppLocalizations.of(context)!.appointments,
                            sectionSeeMore: '',
                          ),
                        ),
                        Gap(AppLayout.getHeight(25)),

                        //Booking list goes here
                        Expanded(
                          child: ListView.builder(
                              itemCount: provider.barberBookings.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: AppointmentCard(
                                        provider: provider,
                                        bookingModel:
                                            provider.barberBookings[index]));
                              }),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ]),
          );
        },
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  const AppointmentCard({
    required this.bookingModel,
    required this.provider,
    super.key,
  });

  final BookingModel bookingModel;
  final HomeBarberProvider provider;

  @override
  Widget build(BuildContext context) {
    // GlobalKey key = GlobalKey();

    // Size size = provider.getCardSize(key);

    // print("CARD SIZE: " + size.toString());

    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Gap(AppLayout.getWidth(5)),
          //Time section goes here
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DateListIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  bookingModel.date.toStringTime(twelveHours: true),
                  style: const TextStyle(
                      color: Styles.darkBlueColor,
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          // Customer card details goes here
          Expanded(
            child: Container(
              // key: provider.cardContainerKey,
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(-4, 4), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    bookingModel.userName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  if (bookingModel.isHomeService) ...[
                    const SizedBox(height: 6),
                    Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Styles.primaryColor),
                      ),
                      child: const Center(
                        child: Text(
                          'HOME SERVICE',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Styles.orangeColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.place_outlined,
                          size: 20,
                          color: Styles.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            bookingModel.homeServiceLocation?.getAddress ??
                                bookingModel.salonName,
                            style: const TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ] else ...[
                    Gap(AppLayout.getHeight(5)),
                    Row(
                      children: [
                        const Icon(
                          FluentSystemIcons.ic_fluent_location_filled,
                          size: 20,
                          color: Styles.primaryColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          bookingModel.salonName,
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ],
                  const Divider(),
                  Wrap(
                    children: List.generate(
                        bookingModel.services.length,
                        (index) => Text(bookingModel.services[index].name +
                            (index < bookingModel.services.length - 1
                                ? ','
                                : ''))),
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
    return ChangeNotifierProvider<HomeBarberProvider>(
        create: (context) => HomeBarberProvider(),
        child: Consumer<HomeBarberProvider>(builder: (context, provider, _) {
          return FittedBox(
            child: Column(children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Styles.primaryColor),
              ),
              // LayoutBuilder(
              //     builder: (BuildContext context, BoxConstraints constraints) {
              //   print("the height is ${provider.cardSize.height}");
              //   return Flex(
              //     direction: Axis.vertical,
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: List.generate(
              //         40,
              //         (index) => const SizedBox(
              //               width: 1,
              //               height: 3,
              //               child: DecoratedBox(
              //                 decoration: BoxDecoration(color: Colors.red),
              //               ),
              //             )),
              //   );
              // }),
              Container(
                padding: const EdgeInsets.all(12),
                width: 1,
                height: 100,
                color: Colors.grey,
              )
            ]),
          );
        }));
  }
}
