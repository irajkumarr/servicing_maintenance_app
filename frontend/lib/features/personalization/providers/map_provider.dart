import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapProvider with ChangeNotifier {
  LatLng? _selectedLocation;
  String? _address;

  LatLng? get selectedLocation => _selectedLocation;
  String? get address => _address;

  void setSelectedLocation(LatLng location) {
    _selectedLocation = location;
    _fetchAddress(location);
  }

  Future<void> _fetchAddress(LatLng location) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks.isNotEmpty) {
        final placemark = placemarks.first;
        _address =
            '${placemark.name}, ${placemark.locality}, ${placemark.country}';
        notifyListeners();
      } else {
        _address = "Hetauda";
      }
    } catch (e) {
      print("Error from map:${e.toString()}");
    }
  }

  // Future<void> getCurrentLocation() async {
  //   Position position = await Geolocator.getCurrentPosition(
  //       // ignore: deprecated_member_use
  //       desiredAccuracy: LocationAccuracy.high);
  //   // Position? position =
  //   //     Provider.of<LocationProvider>(context, listen: false).currentPosition;
  //   LatLng currentLocation = LatLng(position.latitude, position.longitude);
  //   setSelectedLocation(
  //       currentLocation); // Update the selected location and fetch address
  // }
  Future<void> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Update address to indicate location services are off
        _address = "Hetauda";
        notifyListeners();
        return;
      }

      // Proceed to fetch the current location
      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );
      LatLng currentLocation = LatLng(position.latitude, position.longitude);
      setSelectedLocation(
          currentLocation); // Updates selected location and fetches address
    } catch (e) {
      print("Error fetching location: ${e.toString()}");
      _address = "Error fetching location";
      notifyListeners();
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapProvider with ChangeNotifier {
//   LatLng? _selectedLocation;
//   String? _address;

//   LatLng? get selectedLocation => _selectedLocation;
//   String? get address => _address;

//   void setSelectedLocation(LatLng location) {
//     _selectedLocation = location;
//     _fetchAddress(location);
//   }

//   Future<void> _fetchAddress(LatLng location) async {
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(location.latitude, location.longitude);
//       if (placemarks.isNotEmpty) {
//         final placemark = placemarks.first;
//         _address =
//             '${placemark.name}, ${placemark.locality}, ${placemark.country}';
//         notifyListeners();
//       } else {
//         _address = "Hetauda";
//       }
//     } catch (e) {
//       print("Error from map:${e.toString()}");
//     }
//   }

//   Future<void> getCurrentLocation() async {
//     try {
//       // Check if location services are enabled
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         // If location services are disabled, set a default location
//         setSelectedLocation(
//             LatLng(27.6768, 85.3450)); // Default to Hetauda coordinates
//         return;
//       }

//       // Check and request location permissions
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           // Permissions are denied, set default location
//           setSelectedLocation(
//               LatLng(27.6768, 85.3450)); // Default to Hetauda coordinates
//           return;
//         }
//       }

//       // If permissions are permanently denied, handle accordingly
//       if (permission == LocationPermission.deniedForever) {
//         // Permissions are permanently denied, set default location
//         setSelectedLocation(
//             LatLng(27.6768, 85.3450)); // Default to Hetauda coordinates
//         return;
//       }

//       // Get current position
//       Position position = await Geolocator.getCurrentPosition(
//         // ignore: deprecated_member_use
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       LatLng currentLocation = LatLng(position.latitude, position.longitude);
//       setSelectedLocation(currentLocation);
//     } catch (e) {
//       print("Error getting current location: ${e.toString()}");
//       // Set a default location if there's any error
//       setSelectedLocation(
//           LatLng(27.6768, 85.3450)); // Default to Hetauda coordinates
//     }
//   }
// }