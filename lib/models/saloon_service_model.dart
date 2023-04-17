import 'package:barber_center/models/saloon_service_details_model.dart';

class SalonServiceModel {
  final String userId;
  List<ServiceDetailModel> services;

  SalonServiceModel({
    required this.userId,
    required this.services,
  });

  factory SalonServiceModel.fromJson(Map json) {
    print('SalonServiceModel.fromJson: $json');
    return SalonServiceModel(
      userId: json['userId'],
      services: List<ServiceDetailModel>.from(json['services'].map((x) => ServiceDetailModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        'serviceId': userId,
        'services': List<dynamic>.from(services.map((x) => x.toJson())),
      };
}
