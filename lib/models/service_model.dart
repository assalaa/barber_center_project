class ServiceModel {
  final String id;
  final String name;
  final String image;
  final DateTime createAt;
  bool isSelected = false;

  ServiceModel({
    required this.id,
    required this.name,
    required this.image,
    required this.createAt,
  });

  factory ServiceModel.fromJson(Map json) => ServiceModel(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        createAt: DateTime.parse(json['createAt']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'createAt': createAt.toString(),
      };
}
