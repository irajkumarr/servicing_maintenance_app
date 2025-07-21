
import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:app_settings/app_settings.dart';

class PermissionProvider extends ChangeNotifier {
  bool _isLocationGranted = false;
  bool get isLocationGranted => _isLocationGranted;

  Future<bool> checkAndRequestPermissions(BuildContext context) async {
    try {
      PermissionStatus status = await Permission.location.status;

      if (status.isGranted) {
        _isLocationGranted = true;
        notifyListeners();
        return true;
      }

      // Request permission
      status = await Permission.location.request();

      if (status.isGranted) {
        _isLocationGranted = true;
        notifyListeners();
        return true;
      } else if (status.isPermanentlyDenied) {
        bool? openSettings = await _showPermanentlyDeniedDialog(context);
        if (openSettings == true) {
          // await openAppSettings();
          await AppSettings.openAppSettings(type: AppSettingsType.location);
          // Recheck permission after returning from settings
          status = await Permission.location.status;
          if (status.isGranted) {
            _isLocationGranted = true;
            notifyListeners();
            return true;
          }
        }
        return false;
      } else {
        bool? shouldRetry = await _showPermissionDeniedDialog(context);
        if (shouldRetry == true) {
          // Recursive call to retry permission request
          return checkAndRequestPermissions(context);
        }
        return false;
      }
    } catch (e) {
      print("Permission error: $e");
      return false;
    }
  }

  Future<bool?> _showPermissionDeniedDialog(BuildContext context) async {
    if (!context.mounted) return false;

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: KColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.xs),
        ),
        title: const Text('Location Permission Required'),
        content: const Text(
          'Location permission is essential for app functionality. Please grant permission to continue.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('EXIT APP'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('RETRY'),
          ),
        ],
      ),
    );
  }

  Future<bool?> _showPermanentlyDeniedDialog(BuildContext context) async {
    if (!context.mounted) return false;

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: KColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.xs),
        ),
        title: const Text('Permissions Permanently Denied'),
        content: const Text(
          'Location permission is blocked. Would you like to open app settings?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('EXIT APP'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('OPEN SETTINGS'),
          ),
        ],
      ),
    );
  }
}