import 'package:barber_center/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseUser {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _path = 'users';

  Future<void> addUser(UserModel userModel) async {
    await _firestore.collection(_path).doc(userModel.uid).set(userModel.toJson());
  }

  Future<List<UserModel>> getUser(int limit, {UserModel? videoModel}) async {
    final List<UserModel> users = [];

    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot;
      querySnapshot = await _firestore.collection(_path).get();
      for (final doc in querySnapshot.docs) {
        users.add(UserModel.fromJson(doc.data()));
      }
    } catch (e) {
      debugPrint('ERROR: $e');
    }

    return users;
  }

  Future<void> updateUser(UserModel userModel) async {
    await _firestore.collection(_path).doc(userModel.uid).update(userModel.toJson());
  }

  Future<UserModel?> getUserByUid(String uid) async {
    final DocumentSnapshot snapshot = await _firestore.collection(_path).doc(uid).get();
    final Map map = snapshot.data() as Map;
    final UserModel user = UserModel.fromJson(map);
    return user;
  }
}
