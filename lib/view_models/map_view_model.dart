import 'package:flutter/material.dart';
import 'package:pesostagram/deta_models/item.dart';
import 'package:pesostagram/deta_models/owner.dart';

import '../models/repositories/post_repository.dart';
import '../models/repositories/user_repository.dart';

class MapViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  final PostRepository postRepository;

  MapViewModel({required this.userRepository, required this.postRepository});

  bool isProcessing = false;
  List<Owner> owners = [];

  List<Item> items = [];

  Future<void> getOwnerInfo() async {
    isProcessing = true;
    notifyListeners();

    owners = await userRepository.getOwners();
    isProcessing = false;
    notifyListeners();
  }

  Future<void> getItemByOwnerId(String ownerId) async {
    isProcessing = true;
    notifyListeners();

    items = await postRepository.getItemByOwnerId(ownerId);
    isProcessing = false;
    notifyListeners();

  }
  
}