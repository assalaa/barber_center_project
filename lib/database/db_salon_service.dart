import 'package:barber_center/models/saloon_service_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSalonService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'salon_service';

  Future<void> createService(SalonServiceModel salonServiceModel) async {
    await _firestore.collection(_path).doc(salonServiceModel.userId).set(salonServiceModel.toJson());
  }

  Future<SalonServiceModel> getServicesByUserId(String id) async {
    final DocumentSnapshot snapshot = await _firestore.collection(_path).doc(id).get();
    final Map map = (snapshot.data() ?? {}) as Map;
    if (map.isEmpty) {
      return SalonServiceModel(userId: id, services: []);
    }
    final SalonServiceModel salonServiceModel = SalonServiceModel.fromJson(map);
    return salonServiceModel;
  }

  Future<void> updateService(SalonServiceModel salonServiceModel) async {
    await _firestore.collection(_path).doc(salonServiceModel.userId).update(salonServiceModel.toJson());
  }
}
