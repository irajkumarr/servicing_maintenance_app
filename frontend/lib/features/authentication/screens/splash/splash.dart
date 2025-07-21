// splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/services/notification_service.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/providers/permission_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late PermissionProvider _permissionProvider;
  @override
  void initState() {
    super.initState();
    _checkAuthAndInitializePermission();
  }

  Future<void> _checkAuthAndInitializePermission() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final hasToken = token != null && token.isNotEmpty;

    Future.delayed(const Duration(milliseconds: 3000), () async {
      _permissionProvider = Provider.of<PermissionProvider>(
        context,
        listen: false,
      );

      // Check permissions
      bool permissionsGranted = await _permissionProvider
          .checkAndRequestPermissions(context);

      if (!permissionsGranted) {
        if (mounted) {
          SystemNavigator.pop();
        }
        return;
      }
// Initialize notifications
      final NotificationService notificationService = NotificationService();
      await notificationService.requestNotificationPermission(context);
      await notificationService.getDeviceToken();
      notificationService.firebaseInit(context);
      notificationService.setupInteractMessage(context);
      if (hasToken) {
        context.goNamed(RoutesConstant.navigationMenu);
      } else {
        context.goNamed(RoutesConstant.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250.w,
              child: Image.asset(KImages.logo, fit: BoxFit.contain),
            ),
            SizedBox(height: KSizes.spaceBtwSections * 3),
            CustomLoading(color: KColors.primary),
          ],
        ),
      ),
    );
  }
}
