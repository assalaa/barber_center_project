import 'package:barber_center/models/saloon_service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseSalonService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'salon_service';

  Future<void> createService(SalonServiceModel salonServiceModel) async {
    await _firestore
        .collection(_path)
        .doc(salonServiceModel.salonId)
        .set(salonServiceModel.toJson());
  }

  Future<SalonServiceModel> getServicesByUserId(String id) async {
    final DocumentSnapshot snapshot =
        await _firestore.collection(_path).doc(id).get();
    final Map map = (snapshot.data() ?? {}) as Map;
    if (map.isEmpty) {
      return SalonServiceModel(salonId: id, services: []);
    }
    final SalonServiceModel salonServiceModel = SalonServiceModel.fromJson(map);
    return salonServiceModel;
  }

  Future<void> updateService(SalonServiceModel salonServiceModel) async {
    final DocumentReference ref =
        _firestore.collection(_path).doc(salonServiceModel.salonId);

    try {
      await ref.update(salonServiceModel.toJson());
    } catch (e) {
      debugPrint('Error: $e');
      await ref.set(salonServiceModel.toJson());
    }
  }

  Future<List<SalonServiceModel>> getAllSalonServices() async {
    final QuerySnapshot snapshot = await _firestore.collection(_path).get();
    final List<SalonServiceModel> list = [];
    for (final doc in snapshot.docs) {
      list.add(SalonServiceModel.fromJson(doc.data() as Map));
    }
    return list;
  }
}
