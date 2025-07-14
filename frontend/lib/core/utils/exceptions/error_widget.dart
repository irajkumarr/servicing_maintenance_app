import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/popups/toast.dart';

class FullScreenErrorWidget extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const FullScreenErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text(
            //   "😀",
            //   style: Theme.of(context).textTheme.displaySmall,
            // ),
            Icon(
              Icons.error_outline_rounded,
              size: 40.sp,
              color: KColors.primary,
            ),
            SizedBox(height: KSizes.sm),
            Text(
              message,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: KSizes.spaceBtwSections),
            GestureDetector(
              onTap: () async {
                try {
                  await onRetry();
                  showToast("Retrying, Please try again later");
                } catch (e) {
                  showToast("Server Error");
                }
              },
              child: Container(
                padding: EdgeInsets.all(KSizes.sm),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: KColors.primary,
                ),
                child: Icon(
                  Icons.refresh_outlined,
                  size: 35.sp,
                  color: KColors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
