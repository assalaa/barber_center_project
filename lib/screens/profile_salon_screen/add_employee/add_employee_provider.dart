// import 'package:barber_center/database/database_image.dart';
// import 'package:barber_center/database/db_auth.dart';
// import 'package:barber_center/database/db_employees.dart';
// import 'package:barber_center/database/db_services.dart';
// import 'package:barber_center/models/service_model.dart';
// import 'package:barber_center/services/routes.dart';
// import 'package:barber_center/utils/utils.dart';
// import 'package:flutter/widgets.dart';
// import 'package:image_picker/image_picker.dart';

// class AddEmployeeProvider with ChangeNotifier {
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController name = TextEditingController();
//   final DatabaseAuth _dbAuth = DatabaseAuth();
//   final DatabaseImage _dbImage = DatabaseImage();
//   final DatabaseEmployee _dbEmployee = DatabaseEmployee();
//   final DatabaseService _dbService = DatabaseService();
//   bool loading = true;

//   XFile? xFile;

//   List<ServiceModel> services = [];

//   List<ServiceModel> selectedServices = [];

//   AddEmployeeProvider() {
//     _init();
//   }

//   Future<void> _init() async {
//     await _getServices();
//     _selectAllServices();
//     loading = false;
//     notifyListeners();
//   }

//   Future<void> selectImage(BuildContext context) async {
//     try {
//       xFile = await _dbImage.selectImage(ImageSource.gallery, context);
//       notifyListeners();
//     } catch (error) {
//       debugPrint('error: $error');
//     }
//   }

//   Future<void> _getServices() async {
//     services = await _dbService.getServices();
//   }

//   void _selectAllServices() {
//     for (final serviceModel in services) {
//       selectedServices.add(serviceModel);
//     }
//   }

//   void selectService(ServiceModel serviceModel) {
//     if (!selectedServices.contains(serviceModel)) {
//       selectedServices.add(serviceModel);
//     } else {
//       if (selectedServices.length > 1) {
//         selectedServices.remove(serviceModel);
//       } else {
//         showMessageError('Employee has at least 1 service');
//       }
//     }
//     notifyListeners();
//   }

//   Future<void> saveEmployee() async {
//     if (!hasImage()) {
//       showMessageError('Please select an image');
//       return;
//     }

//     if (selectedServices.isEmpty) {
//       showMessageError(
//           'Employee has at least 1 service. Please add services before adding employee');
//       return;
//     }

//     final String? userId = _dbAuth.getCurrentUser()?.uid;

//     if (userId == null) {
//       showMessageError('Employee couldn\'t add. Try again later');
//       return;
//     }

//     if (formKey.currentState!.validate()) {
//       loading = true;
//       notifyListeners();
//       final now = DateTime.now();
//       final String id = dateToId(now);
//       final String photoUrl =
//           await _dbImage.uploadImage(xFile!, 'employees/$id');
//       final EmployeeModel employeeModel = EmployeeModel(
//         id: dateToId(now),
//         name: name.text,
//         image: photoUrl,
//         employerUid: userId,
//         createAt: now,
//         servicesIds: List<String>.generate(
//             selectedServices.length, (index) => selectedServices[index].id),
//       );

//       await _dbEmployee.addEmployee(userId, employeeModel);
//       loading = false;
//       notifyListeners();
//       Routes.goTo(Routes.homeSalonRoute);
//     }
//   }

//   bool hasImage() {
//     return xFile != null;
//   }
// }
