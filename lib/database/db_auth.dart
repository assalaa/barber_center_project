import 'package:barber_center/models/salon_model.dart';
import 'package:firebase_database/firebase_database.dart';

class DBAuth {
  static FirebaseDatabase? database;
  late DatabaseReference _ref;

  DBAuth() {
    if (database != null) {
      return;
    }
    database = FirebaseDatabase.instance;
  }

  Future<void> addNewUser(SalonModel user) async {
    _ref = FirebaseDatabase.instance.ref('clients/${user.id}');
    await _ref.set(user.toJson());
  }

  Future<Map?> getUserById(String id) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("clients/$id");
    DatabaseEvent event = await ref.once();
    return (event.snapshot.value ?? {}) as Map?;
  }
}
