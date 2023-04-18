import 'package:barber_center/models/booking_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseBooking {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'booking';

  Future<void> creatingBooking(BookingModel bookingModel) async {
    await _firestore.collection(_path).doc(bookingModel.id).set(bookingModel.toJson());
  }

  Future<BookingModel?> getBookingById(String id) async {
    final DocumentSnapshot snapshot = await _firestore.collection(_path).doc(id).get();
    final Map map = snapshot.data() as Map;
    final BookingModel bookingModel = BookingModel.fromJson(map);
    return bookingModel;
  }

  Future<void> updateBooking(BookingModel bookingModel) async {
    await _firestore.collection(_path).doc(bookingModel.id).update(bookingModel.toJson());
  }

  Future<List<BookingModel>> getBookingFromSalonInDay(String salonId, DateTime day) async {
    final List<BookingModel> booking = [];
    final DateTime start = DateTime(day.year, day.month, day.day);
    final DateTime end = DateTime(day.year, day.month, day.day, 23, 59, 59);
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(_path)
          .where('date', isLessThanOrEqualTo: end)
          .where('date', isGreaterThanOrEqualTo: start)
          .get();
      for (final doc in querySnapshot.docs) {
        booking.add(BookingModel.fromJson(doc.data()));
      }
    } catch (e) {
      debugPrint('ERROR: $e');
    }

    return booking;
  }
}
