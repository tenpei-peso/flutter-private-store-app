import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pesostagram/deta_models/location.dart';
import 'package:pesostagram/models/db/database_manager.dart';
import 'package:pesostagram/models/location/location_manager.dart';
import 'package:pesostagram/utils/constants.dart';

class PostRepository {
  final DatabaseManager dbManager;
  final LocationManager locationManager;

  PostRepository({required this.dbManager, required this.locationManager});

  Future<File?> pickImage(UploadType uploadType) async {
    final imagePicker = ImagePicker();
     if(uploadType == UploadType.GALLERY) {
       final pickedImage =  await imagePicker.pickImage(source: ImageSource.gallery);
       return (pickedImage != null) ? File(pickedImage.path) : null;
     } else {
       final pickedCameraImage =  await imagePicker.pickImage(source: ImageSource.camera);
       return (pickedCameraImage != null) ? File(pickedCameraImage.path) : null;
     }
  }

  Future<Location?> getCurrentLocation() async {
    return await locationManager.getCurrentLocation();
  }

}