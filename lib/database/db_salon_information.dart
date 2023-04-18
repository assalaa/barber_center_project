import 'package:barber_center/models/salon_information_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DBSalonInformation {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'salon';

  Future<void> createSalonInfo(
      SalonInformationModel salonInformationModel) async {
    await _firestore
        .collection(_path)
        .doc(salonInformationModel.salonId)
        .set(salonInformationModel.toJson());
  }

  Future<SalonInformationModel> getSalonInfoById(String uid) async {
    final DocumentSnapshot snapshot =
        await _firestore.collection(_path).doc(uid).get();

    final Map map = snapshot.data() as Map;
    final SalonInformationModel salonInformation =
        SalonInformationModel.fromJson(map);
    return salonInformation;
  }
}
