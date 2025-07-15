import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.size = KSizes.defaultSpace,
    this.isLoadingTextShowed = true,
    this.padding = const EdgeInsets.only(top: KSizes.md),
    this.color=KColors.white,
  });
  final double size;
  final bool isLoadingTextShowed;
  final EdgeInsets padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          children: [
            LoadingAnimationWidget.staggeredDotsWave(color: color, size: size),
            !isLoadingTextShowed
                ? SizedBox()
                : Text(
                    "Loading",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.copyWith(color: KColors.white),
                  ),
          ],
        ),
      ),
    );
  }
}
