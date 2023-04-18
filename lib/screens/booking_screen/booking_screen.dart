import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/screens/booking_screen/booking_provider.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:provider/provider.dart';

class BookingScreen extends StatelessWidget {
  final SalonServiceModel salonService;
  const BookingScreen({required this.salonService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingProvider>(
      create: (context) => BookingProvider(salonService),
      child: Consumer<BookingProvider>(
        builder: (context, provider, child) {
          return Scaffold(
              appBar: AppBar(
                title: const Text('Booking'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    calendar(provider),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ListView.builder(
                        itemCount: 10,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => provider.onHourPressed(index),
                            child: Card(
                              color: provider.selectedHour == index ? Colors.black : Colors.white,
                              child: ListTile(
                                title: Text(
                                  'Horario 0$index:00',
                                  style: TextStyle(
                                    color: provider.selectedHour == index ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    //BUTTON SAVE
                    ElevatedButton(
                      onPressed: () => provider.save(),
                      child: Text('Save'),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  Widget calendar(BookingProvider controller) {
    return CalendarWeek(
      height: 114,
      minDate: DateTime.now(),
      maxDate: DateTime.now().add(const Duration(days: 60)),
      onDatePressed: (datetime) {
        controller.onDatePressed(datetime);
      },
      monthViewBuilder: (date) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          Strings.meses2[date.month - 1].toUpperCase(),
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
      dayOfWeek: const ['SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB', 'DOM'],
      month: const [
        'JANEIRO',
        'FEVEREIRO',
        'MARÇO',
        'ABRIL',
        'MAIO',
        'JUNHO',
        'JULHO',
        'AGOSTO',
        'SETEMBRO',
        'OUTUBRO',
        'NOVEMBRO',
        'DEZEMBRO',
      ],
    );
  }
}
