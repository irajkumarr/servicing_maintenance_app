import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class KSnackbar {
  static void CustomSnackbar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.md),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        content: Text(text),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static void Snackbar(
      BuildContext context, String text, bool isButtonShowed, Color? color) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 30, // Distance from the top
        left: 0,
        right: 0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: KSizes.md, vertical: KSizes.md + 4),
            decoration: BoxDecoration(
              color: color ?? Colors.black,
              // borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                !isButtonShowed
                    ? SizedBox()
                    : GestureDetector(
                        onTap: () {
                          // Navigate to the cart screen
                          // context.read<NavigationProvider>().onTap(4);
                        },
                        child: const Text(
                          'View Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the OverlayEntry
    overlay.insert(overlayEntry);

    // Remove the OverlayEntry after a delay
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
