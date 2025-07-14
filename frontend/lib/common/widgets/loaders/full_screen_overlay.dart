import 'package:flutter/material.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class FullScreenOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const FullScreenOverlay({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          // Positioned.fill(
          Positioned(
            // Ensures full-screen overlay
            child: Container(
              color: KColors.black.withOpacity(0.7),
              child: Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CustomLoading(size: KSizes.iconLg),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
