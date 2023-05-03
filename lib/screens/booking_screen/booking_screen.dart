import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/booking_time_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/screens/booking_screen/booking_provider.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  final SalonServiceModel salonService;
  final SalonInformationModel salonInformation;
  final BarberModel barberModel;
  const BookingScreen({
    required this.salonService,
    required this.salonInformation,
    required this.barberModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingProvider>(
      create: (context) =>
          BookingProvider(salonService, salonInformation, barberModel),
      child: Consumer<BookingProvider>(
        builder: (context, provider, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Booking'),
              ),
              body: Column(
                children: [
                  BarberInfo(
                    barberModel: barberModel,
                    salonService: salonService,
                  ),
                  const Divider(),

                  /// Calendar
                  CalendarWidget(provider: provider),

                  /// Hours List
                  HoursList(provider: provider),

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

class BarberInfo extends StatelessWidget {
  const BarberInfo({
    required this.barberModel,
    required this.salonService,
    super.key,
  });

  final BarberModel barberModel;
  final SalonServiceModel salonService;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (barberModel.image != null) ...[
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 36,
              child: CircleAvatar(
                backgroundImage: NetworkImage(barberModel.image!),
                radius: 34,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  barberModel.barberName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  salonService.services
                      .where((element) => element.selected)
                      .map((e) => e.name)
                      .toList()
                      .join(', '),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
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
      maxDate: DateTime.now().add(const Duration(days: 6)),
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
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: provider.bookingTimes.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final BookingTimeModel bookingTime =
                      provider.bookingTimes[index];

                  final DateTime? time = bookingTime.time.toDateTime();

                  final bool isSelected =
                      provider.selectedDate.hour == time?.hour &&
                          provider.selectedDate.minute == time?.minute;

                  final bool isAvailable = bookingTime.available;

                  final bool durationFits = bookingTime.durationFits;

                  return InkWell(
                    onTap: () {
                      if (isAvailable) {
                        if (!durationFits) {
                          showMessageError(
                              'Duration of the services you chose doesn\'t fit in this time interval');
                        } else {
                          provider.onTimePressed(time);
                        }
                      } else {
                        showMessageError(AppLocalizations.of(context)!
                            .error_msg_booking_screen);
                      }
                    },
                    child: Card(
                      color: getColor(isSelected, isAvailable, durationFits),
                      child: ListTile(
                        title: Text(
                          provider.bookingTimes[index].time,
                          style: TextStyle(
                            color: getColor(
                                isSelected, isAvailable, durationFits,
                                text: true),
                          ),
                        ),
                        trailing:
                            getIcon(isSelected, isAvailable, durationFits),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon? getIcon(bool isSelected, bool available, bool durationFits) {
    if (isSelected) {
      return const Icon(Icons.done);
    } else if (!available) {
      return const Icon(Icons.calendar_month_outlined);
    } else if (!durationFits) {
      return const Icon(
        Icons.timer_off_sharp,
      );
    }
    return null;
  }

  Color getColor(bool isSelected, bool available, bool durationFits,
      {bool text = false}) {
    if (available) {
      if (isSelected) {
        return text ? Colors.white : Styles.primaryColor;
      } else if (!durationFits) {
        return text ? Colors.white : Colors.grey;
      }
      return text ? Colors.black : Colors.white;
    }
    return text ? Colors.white : Colors.red;
  }
}
