import 'package:barber_center/models/saloon_service_details_model.dart';

class SalonServiceModel {
  final String salonId;
  List<ServiceDetailModel> services;
  int durationInMin = 0;
  double price = 0;

  SalonServiceModel({
    required this.salonId,
    required this.services,
  });

  void setPriceAndDuration() {
    durationInMin = 0;
    price = 0;
    for (final service in services) {
      if (service.selected) {
        durationInMin += service.avgTimeInMinutes;
        price += service.price;
      }
    }
  }

  List<ServiceDetailModel> get selectedServices =>
      services.where((element) => element.selected).toList();

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
