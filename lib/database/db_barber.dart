import 'package:barber_center/models/barber_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseBarber {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'barber';

  Future<void> createBarberAccount(BarberModel barber) async {
    await _firestore.collection(_path).doc(barber.barberId).set(barber.toJson());
  }

  Future<bool> isProfileCompleted(String uid) async {
    final DocumentSnapshot snapshot = await _firestore.collection(_path).doc(uid).get();
    final Map map = (snapshot.data() ?? {}) as Map;
    return map.isNotEmpty;
  }

  Future<BarberModel?> getBarber(String uid) {
    return _firestore.collection(_path).doc(uid).get().then((value) {
      final Map map = (value.data() ?? {});
      if (map.isEmpty) {
        return null;
      }
      final BarberModel barber = BarberModel.fromJson(map);
      return barber;
    });
  }

  Future<List<BarberModel>> getBarbers() async {
    final QuerySnapshot snapshot = await _firestore.collection(_path).get();
    final List<BarberModel> list = [];
    for (final doc in snapshot.docs) {
      list.add(BarberModel.fromJson(doc.data() as Map));
    }
    return list;
  }

  Future<void> updateBarberInformation(BarberModel barberModel) async {
    print('id= ' + barberModel.barberId);
    try {
      await _firestore.collection(_path).doc(barberModel.barberId).update(barberModel.toJson());
    } catch (e) {
      debugPrint('Error: $e');
      await createBarberAccount(barberModel);
    }
  }
}
