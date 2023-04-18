import 'package:barber_center/models/salon_information_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseSalon {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'salon';

  Future<void> createSalonInfo(SalonInformationModel salonInformationModel) async {
    await _firestore
        .collection(_path)
        .doc(salonInformationModel.salonId)
        .set(salonInformationModel.toJson());
  }

  Future<bool> isProfileCompleted(String uid) async {
    final DocumentSnapshot snapshot = await _firestore.collection(_path).doc(uid).get();
    final Map map = snapshot.data() as Map;
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
}
