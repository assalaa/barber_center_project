import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/salon_employee_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseBarber {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'barber';

  Future<void> createBarberAccount(BarberModel barber) async {
    await _firestore
        .collection(_path)
        .doc(barber.barberId)
        .set(barber.toJson());
  }

  Future<void> deleteBarber(String barberId) async {
    await _firestore.collection(_path).doc(barberId).delete();
  }

  Future<void> updateBarber(BarberModel barberModel) async {
    await _firestore
        .collection(_path)
        .doc(barberModel.barberId)
        .update(barberModel.toJson());
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

  Future<List<BarberModel>> getBarbersFromSalonId(String salonId) async {
    final QuerySnapshot snapshot = await _firestore
        .collection(_path)
        .where('salonId', isEqualTo: salonId)
        .get();
    final List<BarberModel> list = [];
    for (final doc in snapshot.docs) {
      list.add(BarberModel.fromJson(doc.data() as Map));
    }
    return list;
  }

  Future<List<SalonEmployeeModel>> getBarbers() async {
    final QuerySnapshot snapshot = await _firestore.collection(_path).get();
    final List<SalonEmployeeModel> list = [];
    for (final doc in snapshot.docs) {
      final BarberModel barberModel = BarberModel.fromJson(doc.data() as Map);

      if (list.any((element) => element.employees.contains(barberModel))) {
        final int index = list.indexOf(list
            .firstWhere((element) => element.salonId == barberModel.salonId));

        list[index].employees.add(barberModel);
      } else {
        list.add(SalonEmployeeModel(
            salonId: barberModel.salonId, employees: [barberModel]));
      }
    }
    return list;
  }

  Future<List<BarberModel>> searchUnemployedBarbers(String searchKey) async {
    final QuerySnapshot snapshot = await _firestore
        .collection(_path)
        .where('salonId', isEqualTo: '')
        .orderBy('barberName')
        .startAt([searchKey.capitalize()]).endAt(
            ['${searchKey[0].toUpperCase()}\uf8ff']).get();
    final List<BarberModel> list = [];
    for (final doc in snapshot.docs) {
      list.add(BarberModel.fromJson(doc.data() as Map));
    }
    return list;
  }
}
