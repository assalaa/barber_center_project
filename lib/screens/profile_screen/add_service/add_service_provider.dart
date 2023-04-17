import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';

import 'package:flutter/cupertino.dart';

class AddServiceProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final DatabaseService _dbService = DatabaseService();
  final DBAuth _dbAuth = DBAuth();

  bool loading = false;

  List<ServiceModel>? services;
  ServiceModel? selectedService;

  int price = 0;
  int avgTime = 0;

  AddServiceProvider() {
    fetchServices();
  }

  Future<void> fetchServices() async {
    loading = true;
    notifyListeners();
    services = await _dbService.getServices();
    loading = false;
    notifyListeners();
  }

  void selectService(ServiceModel serviceModel) {
    selectedService = serviceModel;
    notifyListeners();
  }

  dynamic setPrice(double value) {
    price = value.toInt();
    notifyListeners();
    return price;
  }

  dynamic setTime(double value) {
    avgTime = value.toInt();
    notifyListeners();
    return avgTime;
  }

  Future<void> saveService() async {
    if (checkVariables()) {
      loading = true;
      notifyListeners();

      final String? userId = _dbAuth.getCurrentUser()?.uid;

      if (userId == null) {
        showMessageError('Service couldn\'t add. Try again later');
        return;
      }

      final SaloonServiceModel saloonServiceModel = SaloonServiceModel(
        serviceId: selectedService!.id,
        price: price,
        avgTime: avgTime,
        createAt: DateTime.now(),
      );

      await _dbService.addService(userId, saloonServiceModel);

      showMessageSuccessful('Service is successfully added');

      Routes.back();
      loading = false;
      notifyListeners();
    }
  }

  bool checkVariables() {
    if (selectedService == null) {
      showMessageError('Please select a service');
    } else if (price == 0) {
      showMessageError('Please specify the price for service');
    } else if (avgTime == 0) {
      showMessageError('Please specify the average time for service');
    } else {
      return true;
    }
    return false;
  }
}
