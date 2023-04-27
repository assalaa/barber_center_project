import 'package:barber_center/screens/booking_story/booking_story_provider.dart';
import 'package:barber_center/screens/home_salon_screen/home_salon_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../models/booking_model.dart';
import '../../utils/utils.dart';

class HomeSalonScreen extends StatelessWidget {
  const HomeSalonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeSalonProvider>(
      create: (context) => HomeSalonProvider(),
      child: Consumer<HomeSalonProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(20), horizontal: AppLayout.getWidth(20)),
                    child: Text(
                      AppLocalizations.of(context)!.your_bookings,
                      style: Styles.headLineStyle1,
                    ),
                  ),
                  if (provider.loading) ...[
                    const CenterLoading()
                  ] else ...[
                    if (!provider.hasServices()) ...[
                      CompleteProfileWidget(
                        titleText: 'You haven\'t added services',
                        buttonText: 'Add',
                        onPressed: () => Routes.goTo(Routes.addServiceRoute, enableBack: true),
                      ),
                    ],
                    if (!provider.hasEmployees()) ...[
                      CompleteProfileWidget(
                        titleText: 'Your haven\'t added employees',
                        buttonText: 'Add',
                        onPressed: () => Routes.goTo(Routes.addEmployeeRoute, enableBack: true),
                      ),
                    ],
                    if (!provider.isProfileCompleted) ...[
                      CompleteProfileWidget(
                        titleText: 'Your profile isn\'t complete',
                        buttonText: 'Complete',
                        onPressed: () => Routes.goTo(Routes.salonOptionsRoute, enableBack: true),
                      ),
                    ],
                    if (provider.bookings.isEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.only(top: 88.0),
                        child: Center(
                          child: Text(
                            'No bookings',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ] else ...[
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: provider.bookings.length,
                        itemBuilder: (context, index) {
                          final BookingModel booking = provider.bookings[index];

                          return Padding(
                            padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              elevation: 4,
                              child: Container(
                                // height: AppLayout.getHeight(200),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), gradient: const LinearGradient(colors: [Styles.primaryColor, Styles.orangeColor], begin: Alignment.topLeft, end: Alignment.topRight), boxShadow: const [
                                  BoxShadow(color: Styles.primaryColor, blurRadius: 12, offset: Offset(0, 6)),
                                ]),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          booking.date.showDateAndTime(),
                                          style: Styles.textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
                                        ),
                                      ),
                                      Gap(AppLayout.getHeight(10)),
                                      const Divider(
                                        color: Colors.white,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: '${AppLocalizations.of(context)!.customer} : ',
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                                          children: [
                                            TextSpan(
                                              text: booking.userName,
                                              style: Styles.textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),

                                      RichText(
                                        text: TextSpan(
                                          text: '${AppLocalizations.of(context)!.booking_price} : ',
                                          style: Styles.textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                                          children: [
                                            TextSpan(
                                              text: '\$${booking.getTotalPrice()}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //RICHTXT DURATION
                                      RichText(
                                        text: TextSpan(
                                          text: '${AppLocalizations.of(context)!.booking_duration} : ',
                                          style: Styles.textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                                          children: [
                                            TextSpan(
                                              text: minutesToHours(booking.getDurationInMinutes()),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      //LISTVIEW BUILDER SERVICES
                                      Text(
                                        booking.services.length > 1 ? '${AppLocalizations.of(context)!.booking_services} : ' : '${AppLocalizations.of(context)!.booking_service} : ',
                                        style: Styles.textStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                                      ),
                                      ListView.builder(
                                        itemCount: booking.services.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final service = booking.services[index];
                                          return RichText(
                                            text: TextSpan(
                                              text: '${service.name} ',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: AppLayout.getHeight(10),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                      // ListView.builder(
                      //   itemCount: provider.bookings.length,
                      //   shrinkWrap: true,
                      //   itemBuilder: (context, index) {
                      //     final BookingModel booking = provider.bookings[index];
                      //     return Padding(
                      //       padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                      //       child: Card(
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(12),
                      //         ),
                      //         elevation: 4,
                      //         child: Padding(
                      //           padding:
                      //               const EdgeInsets.fromLTRB(24, 12, 24, 12),
                      //           child: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               RichText(
                      //                 text: TextSpan(
                      //                   text:
                      //                       '${AppLocalizations.of(context)!.booking_salon} :',
                      //                   style: const TextStyle(
                      //                     color: Colors.black,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                   children: [
                      //                     TextSpan(
                      //                       text: booking.userName,
                      //                       style: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.normal,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               RichText(
                      //                 text: TextSpan(
                      //                   text:
                      //                       '${AppLocalizations.of(context)!.booking_date} :',
                      //                   style: const TextStyle(
                      //                     color: Colors.black,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                   children: [
                      //                     TextSpan(
                      //                       text:
                      //                           booking.date.showDateAndTime(),
                      //                       style: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.normal,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               RichText(
                      //                 text: TextSpan(
                      //                   text:
                      //                       '${AppLocalizations.of(context)!.booking_price} :',
                      //                   style: const TextStyle(
                      //                     color: Colors.black,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                   children: [
                      //                     TextSpan(
                      //                       text:
                      //                           '\$${booking.getTotalPrice()}',
                      //                       style: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.normal,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               //RICHTXT DURATION
                      //               RichText(
                      //                 text: TextSpan(
                      //                   text:
                      //                       '${AppLocalizations.of(context)!.booking_duration} :',
                      //                   style: const TextStyle(
                      //                     color: Colors.black,
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                   children: [
                      //                     TextSpan(
                      //                       text: minutesToHours(
                      //                           booking.getDurationInMinutes()),
                      //                       style: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.normal,
                      //                       ),
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               //LISTVIEW BUILDER SERVICES
                      //               Text(
                      //                 booking.services.length > 1
                      //                     ? '${AppLocalizations.of(context)!.booking_services} :'
                      //                     : '${AppLocalizations.of(context)!.booking_service} :',
                      //                 style: const TextStyle(
                      //                   color: Colors.black,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //               ),
                      //               ListView.builder(
                      //                 itemCount: booking.services.length,
                      //                 shrinkWrap: true,
                      //                 itemBuilder: (context, index) {
                      //                   final service = booking.services[index];
                      //                   return RichText(
                      //                     text: TextSpan(
                      //                       text: '${service.name} ',
                      //                       style: const TextStyle(
                      //                         color: Colors.black,
                      //                         fontWeight: FontWeight.w400,
                      //                       ),
                      //                     ),
                      //                   );
                      //                 },
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // )
                    ]
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CompleteProfileWidget extends StatelessWidget {
  const CompleteProfileWidget({
    required this.onPressed,
    required this.titleText,
    required this.buttonText,
    super.key,
  });

  final Function() onPressed;
  final String titleText;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Text(
                  titleText,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
