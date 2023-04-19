import 'package:barber_center/models/saloon_service_details_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String userId;
  final String salonId;
  final String salonName;
  final String userName;
  final DateTime createAt;
  final DateTime date;
  final List<ServiceDetailModel> services;

  BookingModel({
    required this.id,
    required this.userId,
    required this.salonName,
    required this.userName,
    required this.salonId,
    required this.createAt,
    required this.date,
    required this.services,
  });

  factory BookingModel.fromJson(Map json) {
    return BookingModel(
      id: json['id'],
      salonName: json['salonName'],
      userName: json['userName'] ?? 'Ariel Gómez',
      userId: json['userId'],
      salonId: json['salonId'],
      createAt: json['createAt'].toDate().toLocal(),
      date: json['date'].toDate().toLocal(),
      services: List<ServiceDetailModel>.from(
          json['services'].map((x) => ServiceDetailModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'salonName': salonName,
        'userName': userName,
        'salonId': salonId,
        'createAt': Timestamp.fromDate(createAt.toUtc()),
        'date': Timestamp.fromDate(date.toUtc()),
        'services': List<dynamic>.from(services.map((x) => x.toJson())),
      };

  double getTotalPrice() {
    double price = 0;
    for (final element in services) {
      price += element.price;
    }
    return price;
  }

  int getDurationInMinutes() {
    int duration = 0;
    for (final element in services) {
      duration += element.avgTimeInMinutes;
    }
    return duration;
  }

  String intMinutesToStringHours() {
    final int minutes = getDurationInMinutes();
    final int hours = minutes ~/ 60;
    final int minutesLeft = minutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutesLeft.toString().padLeft(2, '0')}';
  }

  String print() {
    return 'id: $id, userId: $userId, salonId: $salonId, createAt: $createAt, date: $date, services: $services';
  }
}
