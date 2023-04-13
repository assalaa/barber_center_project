import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_profile.dart';
import 'package:barber_center/models/customer_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class ProfileScreenProvider with ChangeNotifier {
  late final DBAuth _dbAuth = DBAuth();
  late final DBProfile _dbProfile = DBProfile();

  void logout() {
    _dbAuth.logOut().then((value) => Routes.goTo(Routes.welcomeRoute));
  }

  Future<CustomerModel> fetchMyProfile() async {
    final String? uid = _dbAuth.getCurrentUser()?.uid;

    return uid != null
        ? await _dbProfile.fetchCustomerProfile(uid)
        : CustomerModel.emptyCustomer();
  }
}
