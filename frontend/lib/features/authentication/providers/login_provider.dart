import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ErrorModel? _error;
  ErrorModel? get error => _error;

  UserModel? _user;
  UserModel? get user => _user;

  // Add this getter to check if user is logged in
  bool get isLoggedIn => _user != null;

  // Add this to track if initial auth check is complete
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  LoginProvider() {
    _initializeAuth();
  }

  // Initialize authentication state
  Future<void> _initializeAuth() async {
    await loadUser(); // Load user from local storage first
    if (_user == null) {
      await fetchUser(); // Try to fetch from API if no local user
    }
    _isInitialized = true;
    notifyListeners();
  }

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$kAppBaseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        UserModel loginResponse = userModelFromJson(response.body);
        _user = loginResponse;
        String? userId = loginResponse.id;
        String userData = jsonEncode(loginResponse);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', loginResponse.userToken!);
        await prefs.setString(userId!, userData);
        await prefs.setString('user', jsonEncode(loginResponse));

        _error = null;

        if (context.mounted) {
          context.goNamed(RoutesConstant.navigationMenu);
          KSnackbar.CustomSnackbar(
            context,
            "Login Successful",
            KColors.primary,
          );
        }
      } else {
        var error = errorModelFromJson(response.body);
        if (context.mounted) {
          KSnackbar.CustomSnackbar(context, error.message, Colors.red);
        }
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      if (context.mounted) {
        KSnackbar.CustomSnackbar(context, e.toString(), Colors.red);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('token');
    await prefs.clear();
    _user = null;

    if (context.mounted) {
      context.goNamed(RoutesConstant.splash);

      context.read<NavigationProvider>().onTap(0);
      KSnackbar.CustomSnackbar(context, "Logout Successful", KColors.primary);
    }
    notifyListeners();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');

    if (userString != null) {
      _user = userModelFromJson(userString);
      notifyListeners();
    }
  }

  Future<void> fetchUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return;

      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/users'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _user = userModelFromJson(response.body);
        await prefs.setString('user', jsonEncode(_user));
        notifyListeners();
      } else {
        // Token might be invalid, clear it
        await prefs.remove('token');
        await prefs.remove('user');
        print("Failed to fetch user info");
      }
    } catch (e) {
      print("Error fetching user info: $e");
    }
  }
}
