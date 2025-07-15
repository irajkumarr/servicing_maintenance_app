import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 250.w,
          child: Image.asset(KImages.logo, fit: BoxFit.contain),
        ),

        SizedBox(height: KSizes.sm),
        Text(
          "Welcome Back",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall!.copyWith(fontSize: 30.sp),
        ),
        SizedBox(height: KSizes.xs),
        Text(
          "Sign in to your account",
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(fontSize: 15.sp),
        ),
      ],
    );
  }
}
