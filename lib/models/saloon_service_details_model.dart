class ServiceDetailModel {
  final String serviceId;
  final String name;
  int price;
  int avgTimeInMinutes;
  final DateTime createAt;
  bool selected = false;

  ServiceDetailModel({
    required this.serviceId,
    required this.price,
    required this.name,
    required this.avgTimeInMinutes,
    required this.createAt,
  });

  factory ServiceDetailModel.fromJson(Map json) => ServiceDetailModel(
        serviceId: json['serviceId'],
        name: json['name'] ?? '',
        price: json['price'],
        avgTimeInMinutes: json['avgTime'],
        createAt: DateTime.parse(json['createAt']),
      );

  Map<String, dynamic> toJson() => {
        'serviceId': serviceId,
        'price': price,
        'name': name,
        'avgTime': avgTimeInMinutes,
        'createAt': createAt.toString(),
      };
}
