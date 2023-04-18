import 'package:barber_center/screens/booking_story/booking_story_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingStoryScreen extends StatelessWidget {
  const BookingStoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingStoreProvider>(
      create: (context) => BookingStoreProvider(),
      child: Consumer<BookingStoreProvider>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Booking Story'),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (provider.loading) ...[
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ] else ...[
                    //listview.builder of bookings
                    ListView.builder(
                      itemCount: provider.bookings.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final booking = provider.bookings[index];
                        return ListTile(
                          title: Text(booking.salonName),
                          subtitle: Text(booking.date.toString()),
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
