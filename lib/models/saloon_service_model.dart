class SaloonServiceModel {
  final String serviceId;
  final int price;
  final int avgTime;
  final DateTime createAt;

  SaloonServiceModel({
    required this.serviceId,
    required this.price,
    required this.avgTime,
    required this.createAt,
  });

  factory SaloonServiceModel.fromJson(Map json) => SaloonServiceModel(
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
