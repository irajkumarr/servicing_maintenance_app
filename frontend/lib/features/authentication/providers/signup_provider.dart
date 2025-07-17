import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/success_model.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class SignupProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ErrorModel? _error;
  ErrorModel? get error => _error;

  // UserModel? _user;
  // UserModel? get user => _user;

  Future<void> register(BuildContext context, String data, String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$kAppBaseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: data,
      );

      if (response.statusCode == 201) {
        var responseData = successModelFromJson(response.body);

        _isLoading = false;

        _error = null;

        if (context.mounted) {
          context.goNamed(RoutesConstant.otpVerify, extra: email);
          print(email);

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

  Future<void> verifyOtp(BuildContext context, String email, String otp) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse('$kAppBaseUrl/verify-otp'),
        headers: {'Content-Type': 'application/json'},
        body: '{"email": "$email", "otp": "$otp"}',
      );

      if (response.statusCode == 200) {
        final data = successModelFromJson(response.body);
        _error = null;

        if (context.mounted) {
          KSnackbar.CustomSnackbar(context, data.message, KColors.primary);

         context.goNamed(RoutesConstant.otpSuccess);
        }
      } else {
        final error = errorModelFromJson(response.body);
        _error = error;

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
