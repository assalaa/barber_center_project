import 'package:barber_center/models/invitation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseInvitation {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'invitation';

  Future<void> createInvitation(InvitationModel invitationModel) async {
    await _firestore
        .collection(_path)
        .doc(invitationModel.id)
        .set(invitationModel.toJson());
  }

  Future<void> deleteInvitation(String invitationId) async {
    try {
      await _firestore.collection(_path).doc(invitationId).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List<InvitationModel>> getInvitations(String userId) async {
    final List<InvitationModel> invitations = [];

    final QuerySnapshot snapshot1 = await _firestore
        .collection(_path)
        .where('invitedId', isEqualTo: userId)
        .get();

    for (final doc in snapshot1.docs) {
      invitations.add(InvitationModel.fromJson(doc.data() as Map));
    }
    return invitations;
  }

  Future<List<InvitationModel>> getInvolvedInvitations(String userId) async {
    final List<InvitationModel> invitations = [];

    final QuerySnapshot snapshot0 = await _firestore
        .collection(_path)
        .where('inviterId', isEqualTo: userId)
        .get();

    final QuerySnapshot snapshot1 = await _firestore
        .collection(_path)
        .where('invitedId', isEqualTo: userId)
        .get();

    for (final doc in snapshot0.docs + snapshot1.docs) {
      invitations.add(InvitationModel.fromJson(doc.data() as Map));
    }
    return invitations;
  }
}
