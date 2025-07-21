import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchProvider with ChangeNotifier {
  String _searchText = '';
  bool _isLoading = false;
  bool _isTrigger = false;
  List<ServiceModel>? searchResults;

  String get searchText => _searchText;
  bool get isLoading => _isLoading;
  bool get isTrigger => _isTrigger;

  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set setTrigger(bool value) {
    _isTrigger = value;
    notifyListeners();
  }

  void updateSearchText(String text) {
    _searchText = text;
    notifyListeners();
  }

  Future<void> searchServices(String text) async {
    setLoading = true;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    Uri url = Uri.parse("$kAppBaseUrl/api/services/search/$text");
    try {
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        searchResults = serviceModelFromJson(response.body);
      } else {
        // var error = apiErrorFromJson(response.body);
        // showToast(error.message.toString());
        // Handle error
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    setLoading = false;
    setTrigger = true; // Set trigger to true after search results come in
  }

  void clearSearch() {
    _searchText = '';
    searchResults = null;
    setTrigger = false;
    notifyListeners();
  }
}
