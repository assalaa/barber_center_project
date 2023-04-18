import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_booking.dart';
import 'package:barber_center/models/booking_model.dart';
import 'package:barber_center/models/booking_time_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  final SalonServiceModel salonService;
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseBooking _dbBooking = DatabaseBooking();

  final SalonInformationModel salonInformationModel;
  List<BookingModel> bookings = [];
  List<BookingTimeModel> bookingTimes = [];

  DateTime selectedDate = DateTime.now();
  bool timeSelected = false;

  BookingProvider(
    this.salonService,
    this.salonInformationModel,
  ) {
    _init();
  }

  Future<void> _init() async {
    await getBookingsByDateTime(selectedDate);
    notifyListeners();
  }

  void verifyStatus() {
    for (final booking in bookings) {
      for (final element in bookingTimes) {
        final String hour =
            '${booking.date.hour.toString().padLeft(2, '0')}:${booking.date.minute.toString().padLeft(2, '0')}';

        final String hour2 = '${element.time.split(':')[0]}:${element.time.split(':')[1]}';

        final int minutesUsed = booking.getDurationInMinutes();
        int card = minutesUsed ~/ 30;

        if (minutesUsed % 30 == 0) {
          card--;
        }

        if (hour2 == hour) {
          if (card > 0) {
            final int index = bookingTimes.indexOf(element);
            for (int i = 0; i <= card; i++) {
              bookingTimes[index + i].available = false;
            }
          }
          element.available = false;
        }
      }
    }
  }

  void calculateBookingTimes() {
    final DateTime openTime = salonInformationModel.openTime;
    final DateTime closeTime = salonInformationModel.closeTime;

    final List<String> times = getHalfHourIntervals(openTime, closeTime);

    bookingTimes = List.generate(
      times.length - 1,
      (index) => BookingTimeModel(time: times[index], available: true),
    );
    notifyListeners();
  }

  Future<void> getBookingsByDateTime(DateTime dateTime) async {
    bookings = await _dbBooking.getBookingFromSalonInDay(salonService.salonId, dateTime);
    calculateBookingTimes();
    verifyStatus();
    notifyListeners();
  }

  Future<void> save() async {
    if (!timeSelected) {
      showMessageError('Please select time');
      return;
    }
    final now = DateTime.now();
    final User user = _dbAuth.getCurrentUser()!;
    final BookingModel bookingModel = BookingModel(
      id: dateToId(now),
      salonName: salonService.services[0].name,
      userId: user.uid,
      salonId: salonService.salonId,
      createAt: now,
      date: selectedDate,
      services: salonService.services,
    );
    await _dbBooking.creatingBooking(bookingModel);
    showMessageSuccessful('Booking successful');
    Routes.goTo(Routes.splashRoute);
  }

  void onDatePressed(DateTime dateTime) {
    selectedDate = dateTime;
    getBookingsByDateTime(selectedDate);
  }

  void onTimePressed(DateTime? time) {
    if (time != null) {
      timeSelected = true;
      selectedDate = selectedDate.copyWith(
        hour: time.hour,
        minute: time.minute,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
      // debugPrint('selectedDate: $selectedDate');
      notifyListeners();
    }
  }
}
