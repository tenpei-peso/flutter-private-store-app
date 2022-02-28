import 'package:flutter/material.dart';
import 'package:pesostagram/models/repositories/user_repository.dart';

import '../deta_models/user.dart';

class SearchViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  SearchViewModel({required this.userRepository});

  List<User> soughtUsers = [];

  Future<void> searchUsers(String query) async {
    soughtUsers = await userRepository.searchUsers(query);
    notifyListeners();
  }
}