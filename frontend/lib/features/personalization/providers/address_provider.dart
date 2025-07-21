import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/popups/toast.dart';
import 'package:frontend/data/models/address_model.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class AddressProvider with ChangeNotifier {
  bool _isLoading = false;
  ErrorModel? _error;

  bool get isLoading => _isLoading;

  ErrorModel? get error => _error;

  List<AddressModel> _addresses = [];

  List<AddressModel> get addresses => _addresses;

  Future<void> fetchUserAddresses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/addresses/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _addresses = addressModelFromJson(response.body);
        await fetchUserDefaultAddress();
        _error = null; // No error
      } else {
        final errorBody = json.decode(response.body);
        final errorMessage = errorBody['message'];
        _error = ErrorModel(status: false, message: errorMessage);
        _addresses = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _addresses = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  AddressModel? _defaultAddress;

  AddressModel? get defaultAddress => _defaultAddress;

  Future<void> fetchUserDefaultAddress() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/addresses/default'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        _defaultAddress = AddressModel.fromJson(jsonData);
        // _defaultAddress = AddressModel.fromJson(jsonData);
        _error = null; // No error
      } else {
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        _error = ErrorModel(
          status: false,
          message: "Failed to load default address .",
        );
        print(_error?.toJson());
        _defaultAddress = null;
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _defaultAddress = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setDefaultAddress(BuildContext context, String addressId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;

    Uri url = Uri.parse("$kAppBaseUrl/api/addresses/$addressId/default");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      var response = await http.patch(url, headers: headers);
      if (response.statusCode == 200) {
        await fetchUserDefaultAddress();
        showToast("Default address set successfully");
      } else {
        var error = errorModelFromJson(response.body);
        showToast(error.message);
      }
    } catch (e) {
      showToast(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addAddress(BuildContext context, String data) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;

    Uri url = Uri.parse("$kAppBaseUrl/api/addresses/");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      var response = await http.post(url, headers: headers, body: data);
      if (response.statusCode == 201) {
        // final addressId = jsonDecode(response.body)["data"]['_id'];
        // _defaultAddress = addressId;
        // notifyListeners();
        // await fetchUserDefaultAddress();
        showToast("Address added successfully");

        // await setDefaultAddress(context, addressId);
      } else {
        var error = errorModelFromJson(response.body);
        showToast(error.message);
      }
    } catch (e) {
      showToast(e.toString());
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  Future<void> updateAddress(
    BuildContext context,
    String id,
    String data,
  ) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    Uri url = Uri.parse("$kAppBaseUrl/api/addresses/$id");
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    try {
      var response = await http.put(url, headers: headers, body: data);

      // Debugging: Print the raw response
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        showToast("Address updated successfully");
        // refetch!();
      } else {
        var error = errorModelFromJson(response.body);
        showToast(error.message);
      }
    } catch (e) {
      showToast(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
