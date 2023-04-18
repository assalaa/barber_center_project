import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_booking.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/booking_model.dart';
import 'package:barber_center/models/booking_time_model.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  final SalonServiceModel salonService;
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseBooking _dbBooking = DatabaseBooking();
  final DatabaseUser _dbUser = DatabaseUser();

  final SalonInformationModel salonInformationModel;
  List<BookingModel> bookings = [];
  List<BookingTimeModel> bookingTimes = [];

  List<String> workingTimes = [];

  DateTime selectedDate = DateTime.now();
  bool timeSelected = false;

  bool loading = true;

  BookingProvider(
    this.salonService,
    this.salonInformationModel,
  ) {
    _init();
  }

  Future<void> _init() async {
    setWorkingTimes();
    await getBookingsByDateTime(selectedDate);
    loading = false;
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

  void setWorkingTimes() {
    final DateTime openTime = salonInformationModel.openTime;
    final DateTime closeTime = salonInformationModel.closeTime;

    workingTimes = getHalfHourIntervals(openTime, closeTime);
    notifyListeners();
  }

  void setBookingTimes() {
    bookingTimes = List.generate(
      workingTimes.length - 1,
      (index) => BookingTimeModel(time: workingTimes[index], available: true),
    );
    notifyListeners();
  }

  Future<void> getBookingsByDateTime(DateTime dateTime) async {
    bookings = await _dbBooking.getBookingFromSalonInDay(salonService.salonId, dateTime);
    setBookingTimes();
    verifyStatus();
    notifyListeners();
  }

  Future<void> save() async {
    if (!timeSelected) {
      showMessageError('Please select time');
      return;
    }
    loading = true;
    notifyListeners();
    final now = DateTime.now();
    final User user = _dbAuth.getCurrentUser()!;
    final UserModel userModel = (await _dbUser.getUserByUid(user.uid))!;
    final BookingModel bookingModel = BookingModel(
      id: dateToId(now),
      userName: userModel.name,
      salonName: salonInformationModel.salonName,
      userId: user.uid,
      salonId: salonService.salonId,
      createAt: now,
      date: selectedDate,
      services: salonService.services,
    );
    await _dbBooking.creatingBooking(bookingModel);
    showMessageSuccessful('Booking successful');

    loading = false;
    notifyListeners();

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
