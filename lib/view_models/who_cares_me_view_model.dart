import 'package:flutter/material.dart';
import 'package:pesostagram/utils/constants.dart';

import '../deta_models/user.dart';
import '../models/repositories/post_repository.dart';
import '../models/repositories/user_repository.dart';

class WhoCaresMeViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  WhoCaresMeViewModel({required this.userRepository});

  List<User> careUserData = [];
  User get currentUser => UserRepository.currentUser!;

  Future<void> getCaresUserData(String id, WhoCaresMeMode mode) async {
    careUserData = await userRepository.getCaresUserData(id, mode);
    notifyListeners();
  }
}