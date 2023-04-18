import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/screens/booking_screen/booking_provider.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:gap/gap.dart';
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
              body: Column(
                children: [
                  /// Calendar
                  CalendarWidget(provider: provider),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          /// Hours List
                          HoursList(provider: provider),
                        ],
                      ),
                    ),
                  ),
                  //BUTTON SAVE

                  SaveButton(
                    onPressed: provider.save,
                    loading: provider.loading,
                  ),
                  const Gap(16),
                ],
              ));
        },
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    required this.onPressed,
    required this.loading,
    super.key,
  });

  final Function() onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LargeRoundedButton(
            buttonName: 'Save',
            onTap: onPressed,
            loading: loading,
          ),
        ],
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
      height: 120,
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
      width: MediaQuery.of(context).size.width / 1,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: provider.bookingTimes.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final DateTime? time = provider.bookingTimes[index].time.toDateTime();

          final bool isSelected = provider.selectedDate.hour == time?.hour &&
              provider.selectedDate.minute == time?.minute;

          final bool isAvailable = provider.bookingTimes[index].available;

          return InkWell(
            onTap: () {
              if (isAvailable) {
                provider.onTimePressed(time);
              } else {
                showMessageError('This time is not available');
              }
            },
            child: Card(
              color: getColor(isSelected, isAvailable),
              child: ListTile(
                title: Text(
                  provider.bookingTimes[index].time,
                  style: TextStyle(
                    color: getColor(isSelected, isAvailable, text: true),
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.done)
                    : !isAvailable
                        ? const Icon(Icons.calendar_month_outlined)
                        : null,
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
      return isSelected ? Styles.primaryColor : Colors.white;
    }
    return isSelected ? Colors.white : Colors.black;
  }
}
