import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/app_routes.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/vehicle_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class VehicleProvider with ChangeNotifier {
  bool _isLoading = false;
  ErrorModel? _error;

  bool get isLoading => _isLoading;

  ErrorModel? get error => _error;

  String? _vehicleType = "Car";

  String? get vehicleType => _vehicleType;

  void selectVehicleType(String type) {
    _vehicleType = type;
    notifyListeners();
  }

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

  /// ✅ Add Vehicle
  Future<bool> addVehicle({
    required String brand,
    required String model,
    required String year,
    required String registrationNumber,
    required String fuelType,
    required String color,
    required bool isDefault,
    File? imageFile, // 🔄 Now optional
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token == null) return false;

    try {
      final uri = Uri.parse('$kAppBaseUrl/api/vehicles');
      final request = http.MultipartRequest('POST', uri);

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['vehicleType'] = _vehicleType!.toLowerCase();
      request.fields['brand'] = brand;
      request.fields['model'] = model;
      request.fields['year'] = year;
      request.fields['registrationNumber'] = registrationNumber;
      request.fields['fuelType'] = fuelType;
      request.fields['color'] = color;
      request.fields['isDefault'] = isDefault.toString();

      // 🔄 Only add image file if it's not null
      // if (imageFile != null) {
      //   request.files.add(
      //     await http.MultipartFile.fromPath(
      //       'file', // Make sure this key matches your backend multer field
      //       imageFile.path,
      //       // contentType: MediaType('image', 'jpeg'),
      //     ),
      //   );
      // }
      if (imageFile != null) {
        request.files.add(
          await http.MultipartFile.fromPath("image", imageFile.path),
        );
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 201) {
        await fetchUserVehicles(); // Refresh
        return true;
      } else {
        final errorData = json.decode(response.body);
        _error = ErrorModel(status: false, message: errorData['message']);
        print(errorData);
        return false;
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      print(e.toString());
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteVehicle(String vehicleId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.delete(
        Uri.parse('$kAppBaseUrl/api/vehicles/$vehicleId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final data = json.decode(response.body);

      if (response.statusCode == 200) {
        final message = data["message"];
        await fetchUserVehicles();

        KSnackbar.CustomSnackbar(
          navigatorKey.currentState!.context,
          message,
          KColors.primary,
        );

        _error = null;
      } else {
        final errorMessage = data['message'] ?? 'Unknown error';
        _error = ErrorModel(status: false, message: errorMessage);

        KSnackbar.CustomSnackbar(
          navigatorKey.currentState!.context,
          errorMessage,
          Colors.red,
        );
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());

      KSnackbar.CustomSnackbar(
        navigatorKey.currentState!.context,
        e.toString(),
        Colors.red,
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateVehicle(
    BuildContext context,
    String vehicleId,
    String updatedata,
    VoidCallback onSuccess,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.put(
        Uri.parse('$kAppBaseUrl/api/vehicles/$vehicleId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: updatedata,
      );
      print(token);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        KSnackbar.CustomSnackbar(
          context,
          "Successfully updated!",
          KColors.primary,
        );
        onSuccess();
      } else {
        var error = jsonDecode(response.body)['message'];
        print(error.toString());

        KSnackbar.CustomSnackbar(context, error.toString(), KColors.error);
      }
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
