import 'package:barber_center/database/database_image.dart';
import 'package:barber_center/database/db_services.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class CreateServiceProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final DatabaseImage _dbImage = DatabaseImage();
  final DatabaseService _dbService = DatabaseService();
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

  Future<void> saveService() async {
    if (!hasImage()) {
      showMessageError('Please select an image');
      return;
    }

    if (formKey.currentState!.validate()) {
      loading = true;
      notifyListeners();
      final String photoUrl = await _dbImage.uploadImage(xFile!, 'services/');
      final now = DateTime.now();
      final ServiceModel serviceModel = ServiceModel(
        id: dateToId(now),
        name: name.text,
        image: photoUrl,
        createAt: now,
      );
      await _dbService.createService(serviceModel);
      loading = false;
      notifyListeners();
      Routes.goTo(Routes.splashRoute);
    }
  }

  bool hasImage() {
    return xFile != null;
  }
}
