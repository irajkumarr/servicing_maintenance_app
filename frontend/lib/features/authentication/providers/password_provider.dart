import 'package:flutter/material.dart';

class PasswordProvider with ChangeNotifier {
  bool _loginPasswordVisible = true;
  bool get loginPasswordVisible => _loginPasswordVisible;
  bool _signupPasswordVisible = true;
  bool get signupPasswordVisible => _signupPasswordVisible;
  bool _signupConfirmPasswordVisible = true;
  bool get signupConfirmPasswordVisible => _signupConfirmPasswordVisible;

  void toggleLoginPasswordVisibility() {
    _loginPasswordVisible = !_loginPasswordVisible;
    notifyListeners();
  }
  void toggleSignupPasswordVisibility() {
    _signupPasswordVisible = !_signupPasswordVisible;
    notifyListeners();
  }
  void toggleSignupConfirmPasswordVisibility() {
    _signupConfirmPasswordVisible = !_signupConfirmPasswordVisible;
    notifyListeners();
  }
}
