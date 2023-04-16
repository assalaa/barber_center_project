import 'dart:io' as io;
import 'dart:math';

import 'package:barber_center/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DatabaseImage {
  Future<String> uploadImage(XFile image, String path) async {
    if (kDebugMode) {
      path = 'images/$path';
    }
    final Random rnd = Random();
    final String random =
        '${rnd.nextInt(20)}${rnd.nextInt(20)}${rnd.nextInt(20)}';
    final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    final String fileName = '$random${image.name}';
    final Reference reference =
        firebaseStorage.ref().child(path).child(fileName);
    io.File? file;
    if (!kIsWeb) {
      file = await compressFile(io.File(image.path));
    }
    final Uint8List bytes =
        kIsWeb ? await image.readAsBytes() : file!.readAsBytesSync();

    final TaskSnapshot snapshot = await reference.putData(bytes);
    final String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  static Future<io.File> compressFile(io.File file) async {
    final io.File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      quality: 50,
      percentage: 50,
    );
    return compressedFile;
  }

  Future<XFile?> selectImage(
      ImageSource imageSource, BuildContext context) async {
    if (await checkPermission(imageSource)) {
      final XFile? image = await ImagePicker().pickImage(
        source: imageSource,
      );
      if (kIsWeb) {
        return image;
      }
      // ignore: use_build_context_synchronously
      return cropImage(image, context);
    } else {
      showMessageError(
          'Permission not granted. Try Again with permission access');
      return null;
    }
  }

  Future<List<XFile>?> selectImages() async {
    if (await checkPermission(ImageSource.gallery)) {
      final List<XFile> images = await ImagePicker().pickMultiImage();
      return images;
    } else {
      showMessageError(
          'Permission not granted. Try Again with permission access');
      return null;
    }
  }

  Future<XFile?> pickVideo() async {
    if (await checkPermission(ImageSource.gallery)) {
      return await ImagePicker().pickVideo(source: ImageSource.gallery);
    } else {
      showMessageError(
          'Permission not granted. Try Again with permission access');
      return null;
    }
  }

  Future<String> uploadVideo(XFile video) async {
    final Random rnd = Random();
    final String random =
        '${rnd.nextInt(20)}${rnd.nextInt(20)}${rnd.nextInt(20)}';
    final String fileName = '$random${video.name}';
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('videos/$fileName');
    final UploadTask uploadTask =
        firebaseStorageRef.putFile(io.File(video.path));
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

  Future<bool> checkPermission(ImageSource imageSource) async {
    if (kIsWeb) {
      return true;
    }
    late PermissionStatus permissionStatus;
    if (imageSource == ImageSource.camera) {
      permissionStatus = await Permission.camera.status;
    } else {
      permissionStatus = await Permission.photos.status;
    }

    if (!permissionStatus.isGranted) {
      if (imageSource == ImageSource.camera) {
        permissionStatus = await Permission.camera.request();
      } else {
        permissionStatus = await Permission.photos.request();
      }
    }
    return permissionStatus.isGranted;
  }

  Future<XFile?> cropImage(XFile? file, BuildContext context) async {
    if (file != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
          ),
          WebUiSettings(context: context),
        ],
      );
      if (croppedFile != null) {
        return XFile(croppedFile.path);
      }
    }
    return null;
  }
}
