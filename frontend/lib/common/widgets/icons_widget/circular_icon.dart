import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizes.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    this.onPressed,
    this.bgColor,
  });
  final IconData icon;
  final Color iconColor;
  final Color? bgColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.all(KSizes.xs),
          decoration: BoxDecoration(
            color: bgColor != null ? bgColor! : KColors.white,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: KSizes.iconSm + 4,
          ),
        ));
  }
}
