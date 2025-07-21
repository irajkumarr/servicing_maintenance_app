
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/popups/toast.dart';
import 'package:frontend/features/personalization/providers/location_provider.dart';
import 'package:frontend/features/personalization/providers/map_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geocoding/geocoding.dart';
import 'dart:async';
import '../../../../../../core/utils/constants/colors.dart';
import '../../../../../../core/utils/constants/image_strings.dart';
import '../../../../../../core/utils/constants/sizes.dart';
import '../../../../../../core/utils/device/device_utility.dart';

class SettingAddressOnMapScreen extends StatefulWidget {
  const SettingAddressOnMapScreen({super.key});

  @override
  _SettingAddressOnMapScreenState createState() =>
      _SettingAddressOnMapScreenState();
}

class _SettingAddressOnMapScreenState extends State<SettingAddressOnMapScreen> {
  GoogleMapController? _controller;
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  CameraPosition? _lastPosition;
  bool isServiceAvailable = true; // Flag to track service availability

  bool isMapInitialized = false;

  // Define Hetauda's latitude and longitude range (approximate boundaries)
  //this for whole city hetauda
  // static const double hetaudaLatMin = 27.2695853;
  // static const double hetaudaLatMax = 27.5895853;
  // static const double hetaudaLonMin = 84.8726586;
  // static const double hetaudaLonMax = 85.1926586;

  //using this for only hetauda municipality
  static const double hetaudaLatMin = 27.3124132;
  static const double hetaudaLatMax = 27.5261498;
  static const double hetaudaLonMin = 84.8884753;
  static const double hetaudaLonMax = 85.1874277;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setInitialPosition();
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          isMapInitialized = true;
        });
      }
    });
  }

  Future<void> _setInitialPosition() async {
    final locationProvider = context.read<LocationProvider>();
    if (locationProvider.currentPosition != null) {
      final lat = locationProvider.currentPosition!.latitude;
      final lon = locationProvider.currentPosition!.longitude;
      final initialPosition = LatLng(lat, lon);

      _controller?.moveCamera(CameraUpdate.newLatLng(initialPosition));
      context.read<MapProvider>().setSelectedLocation(initialPosition);
      _checkServiceAvailability(
          lat, lon); // Check if the initial location is within Hetauda
    }
  }

  void _checkServiceAvailability(double lat, double lon) {
    if (mounted) {
      setState(() {
        isServiceAvailable = lat >= hetaudaLatMin &&
            lat <= hetaudaLatMax &&
            lon >= hetaudaLonMin &&
            lon <= hetaudaLonMax;
      });
    }
  }

  Future<void> _searchLocation() async {
    try {
      String query = _searchController.text;
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        final location = locations.first;
        LatLng latLng = LatLng(location.latitude, location.longitude);
        _controller?.animateCamera(CameraUpdate.newLatLngZoom(latLng, 15));
        context.read<MapProvider>().setSelectedLocation(latLng);
        _checkServiceAvailability(
            location.latitude, location.longitude); // Check after search
      }
    } catch (e) {
      showToast(e.toString());
    }
  }

  void _onCameraMove(CameraPosition position) {
    _lastPosition = position;
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      context.read<MapProvider>().setSelectedLocation(position.target);
      _searchController.clear();
      _checkServiceAvailability(position.target.latitude,
          position.target.longitude); // Check while moving
    });
  }

  void _onCameraIdle() {
    if (_lastPosition != null) {
      context.read<MapProvider>().setSelectedLocation(_lastPosition!.target);
      _checkServiceAvailability(
          _lastPosition!.target.latitude, _lastPosition!.target.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: Material(
          elevation: 1,
          child: AppBar(
            title: const Text("Your Location"),
          ),
        ),
      ),
      body: locationProvider.currentPosition == null
          ? const Center(
              child: CircularProgressIndicator(
                color: KColors.primary,
                strokeWidth: 3,
              ),
            )
          : Stack(
              children: [
                Consumer<MapProvider>(
                  builder: (context, mapProvider, child) {
                    return GoogleMap(
                      onMapCreated: _onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          locationProvider.currentPosition!.latitude,
                          locationProvider.currentPosition!.longitude,
                        ),
                        zoom: 16,
                      ),
                      onCameraMove: _onCameraMove,
                      onCameraIdle: _onCameraIdle,
                      zoomControlsEnabled: false,
                    );
                  },
                ),
                Center(
                  child: Image.asset(
                    KImages.locationPin,
                    width: 40.w,
                    height: 40.h,
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 0,
                  left: 0,
                  child: Consumer<MapProvider>(
                    builder: (context, mapProvider, child) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: KSizes.md),
                        child: TextFormField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          cursorColor: KColors.black,
                          onEditingComplete: _searchController.text.isNotEmpty
                              ? _searchLocation
                              : null,
                          style: Theme.of(context).textTheme.headlineSmall,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: KColors.white,
                              hintText:
                                  mapProvider.address ?? 'Search Location',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: KColors.darkGrey),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(23)),
                              prefixIcon: const Icon(
                                Icons.location_on,
                                color: KColors.primary,
                              ),
                              suffixIcon: IconButton(
                                onPressed: _searchController.text.isNotEmpty
                                    ? _searchLocation
                                    : null,
                                icon: Icon(
                                  Icons.search,
                                  color: _searchController.text.isNotEmpty
                                      ? KColors.primary
                                      : KColors.grey,
                                ),
                              )),
                        ),
                      );
                    },
                  ),
                ),
                if (!isServiceAvailable) // Show "Service Unavailable" message
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: KColors.primary.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.error_outline,
                              color: KColors.white,
                              size: 24,
                            ),
                            SizedBox(width: KSizes.sm),
                            Text(
                              'Service Unavailable in this Area',
                              style: TextStyle(
                                color: KColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  left: 0,
                  child: Consumer<MapProvider>(
                    builder: (context, mapProvider, child) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: KSizes.md),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                          )),
                          onPressed: isMapInitialized &&
                                  isServiceAvailable &&
                                  mapProvider.address != null
                              ? () {
                                  Navigator.pop(context, mapProvider.address);
                                }
                              : null, // Disable the button if service is unavailable
                          child: const Text("Confirm Location"),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller?.dispose();
    _searchController.dispose();
    super.dispose();
  }
}