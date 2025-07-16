import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:frontend/data/models/success_model.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ServiceProvider with ChangeNotifier {
  List<ServiceModel> _topRatedServices = [];
  bool _isLoading = false;
  ErrorModel? _error;

  List<ServiceModel> get topRatedServices => _topRatedServices;
  bool get isLoading => _isLoading;

  ErrorModel? get error => _error;
bool _hasFetchedTopRated = false;
  bool get hasFetchedTopRated => _hasFetchedTopRated;
  

  Future<void> fetchTopRatedServices() async {
     if (_hasFetchedTopRated) return;
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/services/top-rated'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _topRatedServices = serviceModelFromJson(response.body);
          _hasFetchedTopRated = true;
        _error = null; // No error
      } else {
        final errorBody = json.decode(response.body);
        final errorMessage = errorBody['message'];
        _error = ErrorModel(status: false, message: errorMessage);
        _topRatedServices = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _topRatedServices = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
