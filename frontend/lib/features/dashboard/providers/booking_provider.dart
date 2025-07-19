import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/api_constants.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/address_model.dart';
import 'package:frontend/data/models/booking_model.dart';
import 'package:frontend/data/models/error_model.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:frontend/data/models/vehicle_model.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingProvider with ChangeNotifier {
  bool _isLoading = false;
  ErrorModel? _error;

  bool get isLoading => _isLoading;

  ErrorModel? get error => _error;

  Future<void> bookService(
    BuildContext context,
    String data,
    ServiceModel service,
    VehicleModel vehicle,
    AddressModel address,
  ) async {
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
        // var responseData = successModelFromJson(response.body);
        var responseData = jsonDecode(response.body);

        _isLoading = false;

        _error = null;

        if (context.mounted) {
          final bookingId = responseData['bookingId'];
          print('Booking ID: $bookingId');
          context.goNamed(RoutesConstant.bookConfirm, extra: bookingId);

          KSnackbar.CustomSnackbar(
            context,
            responseData['message'],
            KColors.primary,
          );
        }
      } else {
        var error = errorModelFromJson(response.body);
        print(error.message);
        if (context.mounted) {
          KSnackbar.CustomSnackbar(context, error.message, Colors.red);
        }
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      print(e.toString());
      if (context.mounted) {
        KSnackbar.CustomSnackbar(context, e.toString(), Colors.red);
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  BookingModel? _booking;

  BookingModel? get booking => _booking;

  Future<void> fetchBookingById(String bookingId) async {
    _isLoading = true;
    _error = null;

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.get(
        Uri.parse("$kAppBaseUrl/api/bookings/$bookingId"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        // _service = ServiceModel.fromJson(jsonData);
        _booking = BookingModel.fromJson(jsonData);

        _error = null; // No error
      } else {
        print("Status Code: ${response.statusCode}");
        print("Response Body: ${response.body}");
        _error = ErrorModel(
          status: false,
          message: "Failed to load booking $bookingId.",
        );
        print(_error?.toJson());
        _booking = null;
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _booking = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cancelBooking({
    required BuildContext context,
    required String bookingId,
    required String cancelReason,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;

    try {
      final response = await http.put(
        Uri.parse("$kAppBaseUrl/api/bookings/$bookingId/cancel"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"cancelReason": cancelReason}),
      );

      final jsonData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        KSnackbar.CustomSnackbar(context, jsonData['message'], Colors.green);

        context.read<NavigationProvider>().onTap(0);
        context.goNamed(RoutesConstant.navigationMenu);
        // _booking?.status = "cancelled"; // update local booking status
      } else {
        KSnackbar.CustomSnackbar(context, jsonData['message'], Colors.red);
      }
    } catch (e) {
      KSnackbar.CustomSnackbar(context, "Something went wrong.", Colors.red);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<BookingModel> _bookings = [];

  List<BookingModel> get bookings => _bookings;

  Future<void> fetchUserBookings() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) return;
    try {
      final response = await http.get(
        Uri.parse('$kAppBaseUrl/api/bookings/user'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        _bookings = bookingModelFromJson(response.body);
        _error = null; // No error
      } else {
        final errorBody = json.decode(response.body);
        final errorMessage = errorBody['message'];
        _error = ErrorModel(status: false, message: errorMessage);
        _bookings = [];
      }
    } catch (e) {
      _error = ErrorModel(status: false, message: e.toString());
      _bookings = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
