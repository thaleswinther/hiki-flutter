import 'package:flutter/material.dart';
import '../../data/repository/user_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginViewModel extends ChangeNotifier {
  final UserRepository userRepository;

  String email = '';
  String password = '';
  bool isLoading = false;
  String? error;
  bool isLoggedIn = false;

  LoginViewModel({required this.userRepository});

  void updateEmail(String value) {
    email = value;
    error = null;
    notifyListeners();
  }

  void updatePassword(String value) {
    password = value;
    error = null;
    notifyListeners();
  }

  Future<void> login(BuildContext context) async {
    final loc = AppLocalizations.of(context)!;

    isLoading = true;
    notifyListeners();

    final user = await userRepository.getUserByEmail(email);
    if (user != null && user.password == password) {
      isLoggedIn = true;
    } else {
      error = user == null ? loc.invalid_email : loc.invalid_password;
    }

    isLoading = false;
    notifyListeners();
  }
}
