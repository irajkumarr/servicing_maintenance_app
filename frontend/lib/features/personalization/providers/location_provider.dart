import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  String? _currentAddress;
  LocationProvider() {
    _initialize();
  }

  Position? get currentPosition => _currentPosition;
  String? get currentAddress => _currentAddress;
  Future<void> _initialize() async {
    // bool serviceEnabled;
    // LocationPermission permission;

    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   // await Geolocator.openLocationSettings();
    //   return Future.error("Location servies are disabled");
    // }

    // permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error("Location Permissions are denied");
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }

    _currentPosition = await Geolocator.getCurrentPosition();
    notifyListeners();
    await _getAddressFromLatLng();

    Geolocator.getPositionStream().listen((Position position) {
      _currentPosition = position;
      notifyListeners();
      _getAddressFromLatLng();
    });
  }

//changing latlon to human readable address
  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      Placemark place = placemarks[0];
      _currentAddress =
          " ${place.locality}, ${place.postalCode}, ${place.country}";
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}