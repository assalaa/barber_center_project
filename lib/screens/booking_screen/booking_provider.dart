import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_booking.dart';
import 'package:barber_center/models/booking_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  final SalonServiceModel salonService;
  final DBAuth _dbAuth = DBAuth();
  final DatabaseBooking _dbBooking = DatabaseBooking();
  DateTime selectedDate = DateTime.now();
  int selectedHour = -1;

  BookingProvider(this.salonService) {
    _init();
  }

  Future<void> _init() async {
    await getBookingsByDateTime(selectedDate);
    notifyListeners();
  }

  Future<void> getBookingsByDateTime(DateTime dateTime) async {
    await _dbBooking.getBookingFromSalonInDay(salonService.salonId, dateTime);
    notifyListeners();
  }

  Future<void> save() async {
    if (selectedHour == -1) {
      showMessageError('Please select time');
      return;
    }
    final now = DateTime.now();
    final User user = _dbAuth.getCurrentUser()!;
    final BookingModel bookingModel = BookingModel(
      id: dateToId(now),
      userId: user.uid,
      salonId: salonService.salonId,
      createAt: now,
      date: selectedDate,
      services: salonService.services,
    );
    _dbBooking.creatingBooking(bookingModel);
  }

  void onDatePressed(DateTime dateTime) {
    selectedDate = dateTime;
    getBookingsByDateTime(selectedDate);
  }

  void onHourPressed(int hour) {
    selectedHour = hour;
    selectedDate =
        selectedDate.copyWith(hour: hour, minute: 0, second: 0, millisecond: 0, microsecond: 0);
    debugPrint('selectedDate: $selectedDate');
    notifyListeners();
  }
}
