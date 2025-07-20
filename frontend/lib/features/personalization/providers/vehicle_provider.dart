import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/vehicle_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class VehicleProvider with ChangeNotifier {
  bool _isLoading = false;
  ErrorModel? _error;

  bool get isLoading => _isLoading;

  ErrorModel? get error => _error;

  List<VehicleModel> _vehicles = [];

  List<VehicleModel> get vehicles => _vehicles;

  Future<void> fetchUserVehicles() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/vehicles/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _vehicles = vehicleModelFromJson(response.body);
        _error = null; // No error
      } else {
        final errorBody = json.decode(response.body);
        final errorMessage = errorBody['message'];
        _error = ErrorModel(status: false, message: errorMessage);
        _vehicles = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _vehicles = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
