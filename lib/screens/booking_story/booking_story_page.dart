import 'package:barber_center/models/booking_model.dart';
import 'package:barber_center/screens/booking_story/booking_story_provider.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class BookingStoryCustomerScreen extends StatelessWidget {
  const BookingStoryCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingStoreCustomerProvider>(
      create: (context) => BookingStoreCustomerProvider(),
      child: Consumer<BookingStoreCustomerProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
            ),
            body: SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(AppLayout.getHeight(10)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: AppLayout.getHeight(20),
                        horizontal: AppLayout.getWidth(20)),
                    child: Text(
                      AppLocalizations.of(context)!.your_bookings,
                      style: Styles.headLineStyle1,
                    ),
                  ),
                  if (provider.loading) ...[
                    const CenterLoading(bottomMargin: 300)
                  ] else if (provider.bookings.isEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 88.0),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.no_booking,
                          style: const TextStyle(
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
                      itemCount: provider.bookings.length * 2,
                      itemBuilder: (context, index) {
                        final BookingModel booking = provider.bookings.reversed
                            .toList()[(index / 2).floor()];

                        return BookingCard(booking: booking);
                      },
                    )
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

class BookingCard extends StatelessWidget {
  const BookingCard({
    required this.booking,
    super.key,
  });

  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    const TextStyle textSpanStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.normal,
      fontSize: 18,
    );

    final bool isHomeService = booking.isHomeService;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Container(
          // height: AppLayout.getHeight(200),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Styles.primaryColor, Styles.orangeColor],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Styles.primaryColor,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    booking.date.showDateAndTime(),
                    style: Styles.textStyle.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const Divider(color: Colors.white),
                RichText(
                  text: TextSpan(
                    text: '${AppLocalizations.of(context)!.booking_salon}: ',
                    style: textStyle,
                    children: [
                      TextSpan(
                        text: booking.salonName,
                        style: Styles.textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    text: '${AppLocalizations.of(context)!.booking_price} : ',
                    style: Styles.textStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${booking.getTotalPrice()}',
                        style: textSpanStyle,
                      ),
                    ],
                  ),
                ),
                //RICHTXT DURATION
                RichText(
                  text: TextSpan(
                    text:
                        '${AppLocalizations.of(context)!.booking_duration} : ',
                    style: textStyle,
                    children: [
                      TextSpan(
                        text: minutesToHours(booking.getDurationInMinutes()),
                        style: textSpanStyle,
                      ),
                    ],
                  ),
                ),
                //LISTVIEW BUILDER SERVICES
                Text(
                  booking.services.length > 1
                      ? '${AppLocalizations.of(context)!.booking_services} : '
                      : '${AppLocalizations.of(context)!.booking_service} : ',
                  style: textStyle,
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
  }
}
