import 'package:barber_center/models/booking_model.dart';
import 'package:barber_center/screens/booking_story/booking_story_provider.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:flutter/material.dart';
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
              title: const Text('Booking History'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (provider.loading) ...[
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ] else if (provider.bookings.isEmpty) ...[
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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
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
                                          text: booking.salonName,
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
                                          text: booking.date.showDateAndTime(),
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
                                          text: '\$${booking.getTotalPrice()}',
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
                                          text: minutesToHours(booking.getDurationInMinutes()),
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
                                    booking.services.length > 1 ? 'Services' : 'Service',
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
