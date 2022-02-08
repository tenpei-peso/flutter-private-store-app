import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/location.dart';
import 'package:pesostagram/models/repositories/post_repository.dart';
import 'package:pesostagram/models/repositories/user_repository.dart';
import 'package:pesostagram/utils/constants.dart';

class PostViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;

  PostViewModel({required this.userRepository, required this.postRepository});

  bool isProcessing = false;
  bool isImagePicked = false;

  File? imageFile;

  Location? location;
  String locationString = "";

  String caption = "";

  Future<void> pickImage(UploadType uploadType) async {
    isImagePicked = false;
    isProcessing = true;
    notifyListeners();

    imageFile = await postRepository.pickImage(uploadType);

    location = await postRepository.getCurrentLocation();
    locationString = (location != null) ? _toLocationString(location!) : "";

    if (imageFile != null) isImagePicked = true;
    isProcessing = false;
    notifyListeners();

  }

  String _toLocationString(Location location) {
    return location.country + " " + location.state + " " + location.city;
  }



}