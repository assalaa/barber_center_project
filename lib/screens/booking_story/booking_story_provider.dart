import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_booking.dart';
import 'package:barber_center/models/booking_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookingStoreCustomerProvider extends ChangeNotifier {
  bool loading = true;
  late User user;
  List<BookingModel> bookings = [];
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseBooking _dbBooking = DatabaseBooking();

  BookingStoreCustomerProvider() {
    _init();
  }

  Future<void> _init() async {
    user = _dbAuth.getCurrentUser()!;
    await getBookings();
    loading = false;
    notifyListeners();
  }

  Future<void> getBookings() async {
    bookings = await _dbBooking.getBookingFromUserId(user.uid);
  }
}

extension StringTime on DateTime {
  String showDateAndTime() {
    return '${day.toString().padLeft(2, '0')}/${month.toString().padLeft(2, '0')}/${year} ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
