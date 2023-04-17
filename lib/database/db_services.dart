import 'package:barber_center/models/service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'service';

  Future<void> createService(ServiceModel serviceModel) async {
    await _firestore.collection(_path).doc(serviceModel.id).set(serviceModel.toJson());
  }

  Future<List<ServiceModel>> getServices() async {
    final List<ServiceModel> services = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection(_path).get();
      for (final doc in querySnapshot.docs) {
        services.add(ServiceModel.fromJson(doc.data()));
      }
    } catch (e) {
      debugPrint('ERROR: $e');
    }

    return services;
  }

  Future<ServiceModel?> getServiceById(String id) async {
    final DocumentSnapshot snapshot = await _firestore.collection(_path).doc(id).get();
    final Map map = snapshot.data() as Map;
    final ServiceModel service = ServiceModel.fromJson(map);
    return service;
  }

  Future<List<ServiceModel>> getMultipleServicesByIds(List<String> serviceIds) async {
    final List<ServiceModel> services = [];

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore.collection(_path).where('id', whereIn: serviceIds).get();

      for (final doc in querySnapshot.docs) {
        debugPrint(doc.id);
        services.add(ServiceModel.fromJson(doc.data()));
      }
    } catch (e) {
      debugPrint('ERROR: $e');
    }

    return services;
  }

  Future<void> updateService(ServiceModel serviceModel) async {
    await _firestore.collection(_path).doc(serviceModel.id).update(serviceModel.toJson());
  }
}
