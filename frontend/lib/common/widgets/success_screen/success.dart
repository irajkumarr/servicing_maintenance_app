import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../core/routes/routes_constant.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/image_strings.dart';
import '../../../core/utils/constants/sizes.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    // Auto-redirect to login after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.goNamed(RoutesConstant.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: KSizes.lg,
            vertical: KSizes.spaceBtwSections,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Lottie animation
              Lottie.asset(
                KImages.successfullyRegisterAnimation,
                height: 200.h,
                repeat: false,
              ),

              SizedBox(height: KSizes.spaceBtwSections),

              // ✅ Success Text
              Text(
                "Verification Successful!",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: KColors.success,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: KSizes.spaceBtwItems),

              Text(
                "Your account has been successfully verified. You can now login to continue.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: KSizes.spaceBtwSections * 2),

              // ✅ Optional Progress Indicator + Redirect Message
              CustomLoading(color: KColors.primary),
              SizedBox(height: 12),
              Text(
                "Redirecting to login...",
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: KColors.darkGrey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
