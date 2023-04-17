import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_salon_service.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/saloon_service_details_model.dart';
import 'package:barber_center/models/saloon_service_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class AddServiceProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final DatabaseSalonService _dbSalonService = DatabaseSalonService();
  final DatabaseService _dbService = DatabaseService();
  final DBAuth _dbAuth = DBAuth();
  late String userId;
  bool loading = true;
  List<ServiceModel> services = [];
  late SalonServiceModel salonServiceModel;
  int indexSelected = -1;

  AddServiceProvider() {
    userId = _dbAuth.getCurrentUser()!.uid;
    getServices();
    getSalonServices();
    for (final ServiceModel element in services) {
      salonServiceModel.services.add(ServiceDetailModel(
        name: element.name,
        serviceId: element.id,
        price: 0,
        avgTimeInMinutes: 0,
        createAt: DateTime.now(),
      ));
    }

    loading = false;
    notifyListeners();
  }

  Future<void> getServices() async {
    services = await _dbService.getServices();
  }

  void selectService(int index) {
    indexSelected = index;
    notifyListeners();
  }

  dynamic setPrice(double value) {
    salonServiceModel.services[indexSelected].price = value.toInt();
    notifyListeners();
    return value;
  }

  dynamic setTime(double value) {
    salonServiceModel.services[indexSelected].avgTimeInMinutes = value.toInt();
    notifyListeners();
    return value;
  }

  Future<void> saveService() async {
    if (checkVariables()) {
      loading = true;
      notifyListeners();

      await _dbSalonService.updateService(salonServiceModel);

      showMessageSuccessful('Service is successfully added');

      Routes.back();
      loading = false;
      notifyListeners();
    }
  }

  bool checkVariables() {
    if (indexSelected == -1) {
      showMessageError('Please select a service');
    } else if (salonServiceModel.services[indexSelected].price == 0) {
      showMessageError('Please specify the price for service');
    } else if (salonServiceModel.services[indexSelected].avgTimeInMinutes == 0) {
      showMessageError('Please specify the average time for service');
    } else {
      return true;
    }
    return false;
  }

  Future<void> getSalonServices() async {
    salonServiceModel = await _dbSalonService.getServicesByUserId(userId);
  }
}
