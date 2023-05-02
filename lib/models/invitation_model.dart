import 'package:cloud_firestore/cloud_firestore.dart';

class InvitationModel {
  final String id;
  final DateTime createAt;
  final String inviter;
  final String invited;

  InvitationModel({
    required this.id,
    required this.createAt,
    required this.inviter,
    required this.invited,
  });

  factory InvitationModel.fromJson(Map json) {
    return InvitationModel(
      id: json['id'],
      createAt: json['createAt'].toDate().toLocal(),
      inviter: json['inviter'],
      invited: json['invited'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createAt': Timestamp.fromDate(createAt.toUtc()),
        'inviter': inviter,
        'invited': invited,
      };
}
