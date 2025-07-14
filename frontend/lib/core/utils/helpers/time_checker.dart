// // TimeChecker class
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class TimeChecker {
  static bool isServiceAvailable() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    // Check if current time is between 11 PM (23:00) and 8 AM (08:00)
    return !(hour >= 23 || hour < 8);
  }

  static String _getNextOpeningTime() {
    final now = DateTime.now();

    if (now.hour >= 23) {
      return "tomorrow at 8:00 AM";
    } else if (now.hour < 8) {
      return "today at 8:00 AM";
    }
    return "tomorrow at 8:00 AM";
  }

  static void showServiceUnavailableDialog(BuildContext context) {
    final nextOpening = _getNextOpeningTime();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 400.w,
          child: AlertDialog(
            backgroundColor: KColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(KSizes.xs),
            ),
            title: Row(
              children: [
                const Icon(
                  Icons.delivery_dining,
                  color: KColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Delivery Unavailable',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sorry! We\'re not accepting orders right now.',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                Text(
                  'Our delivery hours are:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                const Text(
                  '8:00 AM - 11:00 PM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: KColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'We\'ll be back $nextOpening to deliver your favorite food!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: KColors.darkGrey,
                      ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(
                  foregroundColor: KColors.primary,
                ),
                child: const Text(
                  'GOT IT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
