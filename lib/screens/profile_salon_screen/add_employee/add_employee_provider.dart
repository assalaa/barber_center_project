import 'package:barber_center/database/database_image.dart';
import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/database/db_employees.dart';
import 'package:barber_center/models/employee_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployeeProvider with ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final DatabaseAuth _dbAuth = DatabaseAuth();
  final DatabaseImage _dbImage = DatabaseImage();
  final DatabaseEmployee _dbEmployee = DatabaseEmployee();
  bool loading = false;

  XFile? xFile;

  Future<void> selectImage(BuildContext context) async {
    try {
      xFile = await _dbImage.selectImage(ImageSource.gallery, context);
      notifyListeners();
    } catch (error) {
      debugPrint('error: $error');
    }
  }

  Future<void> saveEmployee() async {
    if (!hasImage()) {
      showMessageError('Please select an image');
      return;
    }

    final String? userId = _dbAuth.getCurrentUser()?.uid;

    if (userId == null) {
      showMessageError('Employee couldn\'t add. Try again later');
      return;
    }

    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      final now = DateTime.now();
      final String id = dateToId(now);
      final String photoUrl = await _dbImage.uploadImage(xFile!, 'employees/$id');
      final EmployeeModel employeeModel = EmployeeModel(
        id: dateToId(now),
        name: name.text,
        image: photoUrl,
        employerUid: userId,
        createAt: now,
      );
      await _dbEmployee.addEmployee(userId, employeeModel);
      loading = false;
      notifyListeners();
      Routes.back();
    }
  }

  bool hasImage() {
    return xFile != null;
  }
}
