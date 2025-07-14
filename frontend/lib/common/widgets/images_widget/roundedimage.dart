import 'package:flutter/material.dart';

import '../../../core/utils/constants/sizes.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width,
    this.height,
    this.padding,
    required this.imageUrl,
    this.onTap,
    this.borderRadius = KSizes.md,
    this.isNetworkImage = false,
    this.color,
    this.border,
  });
  final double? width, height;
  final EdgeInsetsGeometry? padding;
  final String imageUrl;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool isNetworkImage;
  final Color? color;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(KSizes.sm),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: color,
            border: border,
            borderRadius: BorderRadius.circular(KSizes.sm),
          ),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(KSizes.sm),
              child: Image(
                image: isNetworkImage
                    ? NetworkImage(imageUrl)
                    : AssetImage(imageUrl) as ImageProvider,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
