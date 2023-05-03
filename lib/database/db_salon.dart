import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseSalon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'salon';

  Future<void> createSalonInfo(SalonInformationModel salonInformationModel) async {
    await _firestore.collection(_path).doc(salonInformationModel.salonId).set(salonInformationModel.toJson());
  }

  Future<bool> isProfileCompleted(String uid) async {
    final DocumentSnapshot snapshot = await _firestore.collection(_path).doc(uid).get();
    final Map map = (snapshot.data() ?? {}) as Map;
    return map.isNotEmpty;
  }

  Future<SalonInformationModel?> getSalonInformation(String uid) {
    return _firestore.collection(_path).doc(uid).get().then((value) {
      final Map map = (value.data() ?? {});
      if (map.isEmpty) {
        return null;
      }
      final SalonInformationModel salonInformationModel = SalonInformationModel.fromJson(map);
      return salonInformationModel;
    });
  }

  Future<void> updateSalonInformation(SalonInformationModel salonInformationModel) async {
    try {
      await _firestore.collection(_path).doc(salonInformationModel.salonId).update(salonInformationModel.toJson());
    } catch (e) {
      debugPrint('Error: $e');
      await createSalonInfo(salonInformationModel);
    }
  }

  Future<List<SalonInformationModel>> getSalonsInformation() async {
    final QuerySnapshot snapshot = await _firestore.collection(_path).get();
    final List<SalonInformationModel> list = [];
    for (final doc in snapshot.docs) {
      list.add(SalonInformationModel.fromJson(doc.data() as Map));
    }
    return list;
  }

  Future<List<SalonInformationModel>> searchSalons(String searchKey) async {
    final QuerySnapshot snapshot = await _firestore
        .collection(_path)
        .orderBy('salonName')
        .startAt([searchKey.capitalize()]).endAt(
            ['${searchKey[0].toUpperCase()}\uf8ff']).get();
    final List<SalonInformationModel> list = [];
    for (final doc in snapshot.docs) {
      list.add(SalonInformationModel.fromJson(doc.data() as Map));
    }
    return list;
  }
}
