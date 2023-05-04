import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/location_model.dart';
import 'package:barber_center/models/saloon_service_details_model.dart';
import 'package:barber_center/services/location_service.dart';

class SalonServiceModel {
  final String salonId;
  List<ServiceDetailModel> services;
  BarberModel? selectedEmployee;
  bool homeService;
  int homeServiceFee;
  LocationModel? serviceLocation;
  LocationModel? salonLocation;
  int? distanceInMeters;

  SalonServiceModel({
    required this.salonId,
    required this.services,
    this.homeService = false,
    this.homeServiceFee = 100,
    this.selectedEmployee,
    this.serviceLocation,
    this.distanceInMeters,
  });

  List<ServiceDetailModel> get selectedServices =>
      services.where((element) => element.selected).toList();

  int get price {
    int price = 0;
    for (final service in services.where((element) => element.selected)) {
      price += service.price;
    }
    return homeService ? price + homeServiceFee : price;
  }

  String get stringPrice {
    String totalPrice = '$price EGP';

    if (homeService) {
      totalPrice =
          '${price - homeServiceFee} EGP +$homeServiceFee EGP home service fee';
    }

    return totalPrice;
  }

  int get durationInMin {
    int durationInMin = 0;
    for (final service in services.where((element) => element.selected)) {
      durationInMin += service.avgTimeInMinutes;
    }
    if (transportationDurationInMin > 0) {
      durationInMin += transportationDurationInMin;
    }
    return durationInMin;
  }

  String get stringDurationInMin {
    String duration = '$durationInMin min';

    if (transportationDurationInMin > 0) {
      duration =
          '${durationInMin - transportationDurationInMin} min +$transportationDurationInMin min for transportation';
    }

    return duration;
  }

  int get transportationDurationInMin {
    if (homeService && serviceLocation != null && salonLocation != null) {
      distanceInMeters = LocationService.calculateDistance(
              salonLocation!.geoPoint, serviceLocation!.geoPoint)
          .toInt();

      final int timeInSeconds = (distanceInMeters! / 8).ceil();

      final timeInMinutes = (timeInSeconds / 60).round();

      return timeInMinutes * 2;
    }
    return -1;
  }

  factory SalonServiceModel.fromJson(Map json) {
    return SalonServiceModel(
      salonId: json['userId'],
      services: List<ServiceDetailModel>.from(
          json['services'].map((x) => ServiceDetailModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': salonId,
        'services': List<dynamic>.from(services.map((x) => x.toJson())),
      };
}
