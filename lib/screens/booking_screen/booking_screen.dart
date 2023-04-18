import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/screens/booking_screen/booking_provider.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  final SalonServiceModel salonService;
  final SalonInformationModel salonInformation;
  const BookingScreen({
    required this.salonService,
    required this.salonInformation,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingProvider>(
      create: (context) => BookingProvider(salonService, salonInformation),
      child: Consumer<BookingProvider>(
        builder: (context, provider, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Booking'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    /// Calendar
                    CalendarWidget(provider: provider),

                    /// Hours List
                    HoursList(provider: provider),

                    //BUTTON SAVE
                    ElevatedButton(
                      onPressed: () => provider.save(),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({
    required this.provider,
    super.key,
  });

  final BookingProvider provider;
  @override
  Widget build(BuildContext context) {
    return CalendarWeek(
      height: 130,
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(const Duration(days: 60)),
      onDatePressed: (dateTime) {
        provider.onDatePressed(dateTime);
      },
      monthViewBuilder: (date) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          Strings.months[date.month - 1].toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      dayOfWeekStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      dateStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
      ),
      todayBackgroundColor: Colors.black.withOpacity(0.15),
      pressedDateBackgroundColor: Colors.black,
      backgroundColor: Colors.white.withOpacity(0),
      month: Strings.months,
    );
  }
}

class HoursList extends StatelessWidget {
  const HoursList({
    required this.provider,
    super.key,
  });

  final BookingProvider provider;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: provider.bookingTimes.length,
        itemBuilder: (context, index) {
          final DateTime? time = provider.bookingTimes[index].time.toDateTime();

          final bool isSelected = provider.selectedDate.hour == time?.hour &&
              provider.selectedDate.minute == time?.minute;

          return InkWell(
            onTap: () {
              if (provider.bookingTimes[index].available) {
                provider.onTimePressed(time);
              } else {
                showMessageError('This time is not available');
              }
            },
            child: Card(
              color: getColor(isSelected, provider.bookingTimes[index].available),
              child: ListTile(
                title: Text(
                  provider.bookingTimes[index].time,
                  style: TextStyle(
                    color: getColor(isSelected, provider.bookingTimes[index].available, text: true),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color getColor(bool isSelected, bool available, {bool text = false}) {
    if (available == false) {
      return text ? Colors.white : Colors.red;
    }
    if (text == false) {
      return isSelected ? Colors.black : Colors.white;
    }
    return isSelected ? Colors.white : Colors.black;
  }
}
