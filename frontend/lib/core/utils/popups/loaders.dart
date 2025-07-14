import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class KLoaders {
  static hideSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

  static successSnackBar(BuildContext context, {required title, message = ''}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        padding: const EdgeInsets.all(KSizes.md),
        decoration: BoxDecoration(
          color: KColors.accent,
          borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
        ),
        child: Column(
          children: [
            Text(title),
            Text(message),
          ],
        ),
      ),
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.vertical,
      behavior: SnackBarBehavior.floating,
    ));
  }

  static snackbar(BuildContext context,
      {required String title,
      required VoidCallback onPressed,
      required String buttonText}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          )),
          TextButton(
            style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                splashFactory: NoSplash.splashFactory,
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                )),
            onPressed: () {
              // Navigate to cart screen
              // Navigator.pushNamed(context, '/cart');
              onPressed();
            },
            child: Text(
              // 'Go to Cart',
              buttonText,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: KColors.white),
            ),
          ),
        ],
      ),
    ));
  }

  static void showSnackbarTop(BuildContext context, String message,
      String buttonText, VoidCallback onPressed) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        // top: 20,
        top: MediaQuery.of(context).padding.top,
        // top: 0,
        // bottom: 0,
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(KSizes.md),
            padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 12.0.h),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      splashFactory: NoSplash.splashFactory,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      )),
                  onPressed: onPressed,
                  child: Text(
                    buttonText,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: KColors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    Future.delayed(const Duration(seconds: 4), () {
      overlayEntry.remove();
    });
  }
}
