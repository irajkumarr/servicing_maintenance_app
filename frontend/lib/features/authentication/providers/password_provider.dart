import 'package:flutter/material.dart';

class PasswordProvider with ChangeNotifier {
  bool _loginPasswordVisible = true;
  bool get loginPasswordVisible => _loginPasswordVisible;

  void toggleLoginPasswordVisibility() {
    _loginPasswordVisible = !_loginPasswordVisible;
    notifyListeners();
  }
}
