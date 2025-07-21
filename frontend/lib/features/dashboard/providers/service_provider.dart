import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/service_model.dart';
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

  List<ServiceModel> _services = [];

  List<ServiceModel> get services => _services;

  Future<void> fetchServices() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/services/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _services = serviceModelFromJson(response.body);
        _error = null; // No error
      } else {
        final errorBody = json.decode(response.body);
        final errorMessage = errorBody['message'];
        _error = ErrorModel(status: false, message: errorMessage);
        _services = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _services = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  ServiceModel? _service;

  ServiceModel? get service => _service;

  Future<void> fetchServiceById(String serviceId) async {
    _isLoading = true;
    _error = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.get(
        Uri.parse("$kAppBaseUrl/api/services/$serviceId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        _service = ServiceModel.fromJson(jsonData);
        _service = ServiceModel.fromJson(jsonData);

        _error = null; // No error
      } else {
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        _error = ErrorModel(
          status: false,
          message: "Failed to load service $serviceId.",
        );
        print(_error?.toJson());
        _service = null;
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _service = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<ServiceModel> _servicesByType = [];

  List<ServiceModel> get servicesByType => _servicesByType;

  Future<void> fetchServicesByType(String type) async {
    _isLoading = true;
    _error = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.get(
        Uri.parse("$kAppBaseUrl/api/services/type/?type=$type"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        _servicesByType = serviceModelFromJson(response.body);
        // _service = ServiceModel.fromJson(jsonData);

        _error = null; // No error
      } else {
        // print("Status Code: ${response.statusCode}");
        // print("Response Body: ${response.body}");
        _error = ErrorModel(
          status: false,
          message: "Failed to load service $type.",
        );
        print(_error?.toJson());
        _servicesByType = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _servicesByType = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
