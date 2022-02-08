import 'package:flutter/material.dart';
import 'package:pesostagram/models/repositories/user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;
  LoginViewModel({required this.userRepository});

  bool isLoading = false;
  bool isSuccessful = false;

  bool emailIsLoading = false;
  bool emailIsSuccessful = false;
  String emailString = "";
  String passwordString = "";

  Future<bool> isSingIn() async {
    return await userRepository.isSignIn();
  }

  Future<void> signIn() async {
    isLoading = true;
    notifyListeners();

    isSuccessful = await userRepository.signIn();
    isLoading = false;
    notifyListeners();
  }

  Future<void> emailRegister() async {
    emailIsLoading = true;
    notifyListeners();

    emailIsSuccessful = await userRepository.emailRegister(emailString, passwordString);
    emailIsLoading = false;
    notifyListeners();
  }

  Future<void> emailSignIn() async {
    emailIsLoading = true;
    notifyListeners();

    emailIsSuccessful = await userRepository.emailSignIn(emailString, passwordString);
    emailIsLoading = false;
    notifyListeners();
  }
}

