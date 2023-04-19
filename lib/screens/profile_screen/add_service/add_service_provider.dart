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
  final DatabaseAuth _dbAuth = DatabaseAuth();
  late String userId;
  bool loading = true;
  List<ServiceModel> services = [];
  late SalonServiceModel salonServiceModel;
  int indexSelected = -1;

  int price = 0;
  int avgTime = 0;
  String buttonText = 'Save';

  AddServiceProvider() {
    userId = _dbAuth.getCurrentUser()!.uid;
    getServices();
    getSalonServices();
    loading = false;
    notifyListeners();
  }

  Future<void> getServices() async {
    services = await _dbService.getServices();
    notifyListeners();
  }

  void selectService(int index) {
    indexSelected = index;
    checkIfExist();
    notifyListeners();
  }

  dynamic setPrice(double value) {
    price = value.toInt();
    notifyListeners();
    return value;
  }

  dynamic setTime(double value) {
    avgTime = value.toInt();
    notifyListeners();
    return value;
  }

  bool get anyServiceSelected => indexSelected != -1;

  Future<void> saveService() async {
    if (checkVariables()) {
      loading = true;
      notifyListeners();

      final ServiceModel serviceModel = services[indexSelected];

      if (salonServiceModel.services.any((serviceDetailModel) =>
          serviceDetailModel.serviceId == serviceModel.id)) {
        final int index = salonServiceModel.services.indexWhere(
            (serviceDetailModel) =>
                serviceDetailModel.serviceId == serviceModel.id);
        salonServiceModel.services[index].price = price;
        salonServiceModel.services[index].avgTimeInMinutes = avgTime;
      } else {
        salonServiceModel.services.add(ServiceDetailModel(
          serviceId: serviceModel.id,
          price: price,
          avgTimeInMinutes: avgTime,
          createAt: DateTime.now(),
          name: serviceModel.name,
        ));
      }

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
    } else if (price == 0) {
      showMessageError('Please specify the price for service');
    } else if (avgTime == 0) {
      showMessageError('Please specify the average time for service');
    } else {
      return true;
    }
    return false;
  }

  Future<void> getSalonServices() async {
    salonServiceModel = await _dbSalonService.getServicesByUserId(userId);
  }

  void checkIfExist() {
    final bool serviceExist = salonServiceModel.services
        .any((element) => element.serviceId == services[indexSelected].id);

    if (!serviceExist) {
      price = 0;
      avgTime = 0;
      buttonText = 'Save';
    } else {
      final ServiceDetailModel serviceDetailModel = salonServiceModel.services
          .firstWhere(
              (element) => element.serviceId == services[indexSelected].id);
      price = serviceDetailModel.price;
      avgTime = serviceDetailModel.avgTimeInMinutes;
      buttonText = 'Update';
    }
    notifyListeners();
  }
}
