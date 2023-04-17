class ServiceDetailModel {
  final String serviceId;
  int price;
  int avgTime;
  final DateTime createAt;

  ServiceDetailModel({
    required this.serviceId,
    required this.price,
    required this.avgTime,
    required this.createAt,
  });

  factory ServiceDetailModel.fromJson(Map json) => ServiceDetailModel(
        serviceId: json['serviceId'],
        price: json['price'],
        avgTime: json['avgTime'],
        createAt: DateTime.parse(json['createAt']),
      );

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'price': price,
        'avgTime': avgTime,
        'createAt': createAt.toString(),
      };
}
