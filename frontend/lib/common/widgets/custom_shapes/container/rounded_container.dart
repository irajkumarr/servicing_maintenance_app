import 'package:flutter/material.dart';


import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/sizes.dart';

class RoundedContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color color;
  final Color borderColor;
  final double radius;
  final bool showBorder;
  final Widget? child;
  final EdgeInsetsGeometry? margin, padding;

   const RoundedContainer({
    super.key,
    this.width,
    this.height,
    this.color = KColors.white,
    this.borderColor = KColors.borderPrimary,
    this.radius = KSizes.cardRadiusLg,
    this.showBorder = false,
    this.child,
    this.margin,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius),
          border: showBorder ? Border.all(color: borderColor) : null),
      child: child,
    );
  }
}
