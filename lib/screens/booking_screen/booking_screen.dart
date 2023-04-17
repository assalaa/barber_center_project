import 'package:barber_center/models/saloon_service_model.dart';
import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  final SalonServiceModel salonService;
  const BookingScreen({required this.salonService, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Booking screen goes here')),
    );
  }
}
