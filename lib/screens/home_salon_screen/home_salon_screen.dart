import 'package:barber_center/models/booking_model.dart';
import 'package:barber_center/screens/booking_story/booking_story_provider.dart';
import 'package:barber_center/screens/home_salon_screen/home_salon_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
                  if (provider.loading) ...[
                    SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  ] else ...[
                    if (!provider.hasServices()) ...[
                      CompleteProfileWidget(
                        titleText: 'You haven\'t added services',
                        buttonText: 'Add',
                        onPressed: () => Routes.goTo(Routes.addServiceRoute,
                            enableBack: true),
                      ),
                    ],
                    if (!provider.isProfileCompleted) ...[
                      CompleteProfileWidget(
                        titleText: 'Your profile isn\'t completed',
                        buttonText: 'Complete',
                        onPressed: () => Routes.goTo(Routes.salonOptionsRoute,
                            enableBack: true),
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
                        itemCount: provider.bookings.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final BookingModel booking = provider.bookings[index];
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(24, 12, 24, 0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(24, 12, 24, 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: 'Salon: ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: booking.userName,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Date: ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                booking.date.showDateAndTime(),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Price: ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '\$${booking.getTotalPrice()}',
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //RICHTXT DURATION
                                    RichText(
                                      text: TextSpan(
                                        text: 'Duration: ',
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: minutesToHours(
                                                booking.getDurationInMinutes()),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //LISTVIEW BUILDER SERVICES
                                    Text(
                                      booking.services.length > 1
                                          ? 'Services'
                                          : 'Service',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      )
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
                  titleText * 2,
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
