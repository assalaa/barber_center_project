import 'package:barber_center/models/saloon_service_model.dart';
import 'package:flutter/material.dart';

class BookingProvider extends ChangeNotifier {
  final SalonServiceModel salonService;
  BookingProvider(this.salonService) {
    _init();
  }

  void _init() {}
}
