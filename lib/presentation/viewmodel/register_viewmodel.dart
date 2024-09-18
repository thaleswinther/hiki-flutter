import 'package:flutter/material.dart';
import '../../data/repository/user_repository.dart';
import '../../data/database/entity/user.dart';

class RegisterViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  String email = '';
  String username = '';
  String password = '';
  bool isLoading = false;
  String? error;
  bool isRegistered = false;

  RegisterViewModel({required this.userRepository});

  void updateEmail(String value) {
    email = value;
    error = null;
    notifyListeners();
  }

  void updateUsername(String value) {
    username = value;
    error = null;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    error = null;
    notifyListeners();
  }

  Future<void> register() async {
    if (email.isEmpty || username.isEmpty || password.isEmpty) {
      error = 'Preencha todos os campos';
      notifyListeners();
      return;
    }

    isLoading = true;
    notifyListeners();

    final existingUser = await userRepository.getUserByEmail(email);
    if (existingUser != null) {
      error = 'User already exists';
    } else {
      final user = User(email: email, username: username, password: password);
      await userRepository.insert(user);
      isRegistered = true;
    }

    isLoading = false;
    notifyListeners();
  }
}
