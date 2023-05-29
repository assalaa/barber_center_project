import 'package:cloud_firestore/cloud_firestore.dart';

class InvitationModel {
  final String id;
  final DateTime createAt;
  final String inviter;
  final String inviterId;
  final String invited;
  final String invitedId;

  InvitationModel({
    required this.id,
    required this.createAt,
    required this.inviter,
    required this.inviterId,
    required this.invited,
    required this.invitedId,
  });

  factory InvitationModel.fromJson(Map json) {
    return InvitationModel(
      id: json['id'],
      createAt: json['createAt'].toDate().toLocal(),
      inviter: json['inviter'],
      inviterId: json['inviterId'],
      invited: json['invited'],
      invitedId: json['invitedId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createAt': Timestamp.fromDate(createAt.toUtc()),
        'inviter': inviter,
        'inviterId': inviterId,
        'invited': invited,
        'invitedId': invitedId,
      };
}
