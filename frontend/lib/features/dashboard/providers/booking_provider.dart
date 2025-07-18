import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/success_model.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BookingProvider with ChangeNotifier {
  bool _isLoading = false;
  ErrorModel? _error;

  bool get isLoading => _isLoading;

  ErrorModel? get error => _error;

  Future<void> bookService(BuildContext context, String data) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;

    try {
      final response = await http.post(
        Uri.parse('$kAppBaseUrl/api/bookings/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: data,
      );

      if (response.statusCode == 201) {
        var responseData = successModelFromJson(response.body);

        _isLoading = false;

        _error = null;

        if (context.mounted) {
          context.goNamed(RoutesConstant.bookConfirm);

          KSnackbar.CustomSnackbar(
            context,
            responseData.message,
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
}
