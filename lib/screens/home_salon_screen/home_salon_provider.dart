import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_booking.dart';
import 'package:barber_center/database/db_employees.dart';
import 'package:barber_center/database/db_salon.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/models/booking_model.dart';
import 'package:barber_center/models/employee_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeSalonProvider with ChangeNotifier {
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseSalon _dbSalon = DatabaseSalon();
  final DatabaseEmployee _dbEmployees = DatabaseEmployee();
  final DatabaseBooking _dbBooking = DatabaseBooking();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  bool loading = true;
  late bool isProfileCompleted;
  late SalonServiceModel salonServiceModel;
  late User user;
  List<EmployeeModel> employees = [];
  List<BookingModel> bookings = [];

  HomeSalonProvider() {
    init();
  }

  Future<void> init() async {
    user = _dbAuth.getCurrentUser()!;
    await Future.wait([
      setIsProfileCompleted(),
      setIsServicesCompleted(),
      getEmployees(),
      getBookings(),
    ]);
    loading = false;
    notifyListeners();
  }

  Future<void> setIsProfileCompleted() async {
    isProfileCompleted = await _dbSalon.isProfileCompleted(user.uid);
  }

  Future<void> setIsServicesCompleted() async {
    salonServiceModel = await _dbSalonService.getServicesByUserId(user.uid);
  }

  Future<void> getEmployees() async {
    employees = await _dbEmployees.getEmployees(user.uid);
  }

  bool hasServices() {
    return salonServiceModel.services.isNotEmpty;
  }

  bool hasEmployees() {
    return employees.isNotEmpty;
  }

  Future<void> getBookings() async {
    bookings = await _dbBooking.getBookingFromUserId(user.uid, isSalon: true);
    bookings.sort((a, b) => a.date.compareTo(b.date));
    //remove where date is in the past
    bookings.removeWhere((element) => element.date.isBefore(DateTime.now()));
  }
}
