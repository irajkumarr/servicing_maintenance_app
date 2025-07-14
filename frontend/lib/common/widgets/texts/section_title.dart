import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/sizes.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    super.key,
    required this.title,
    required this.showButtonTitle,
    this.textColor,
    this.buttonColor = KColors.primary,
    this.onPressed,
  });
  final String title;
  final bool showButtonTitle;
  final Color? textColor;
  final Color? buttonColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.w700,
            color: textColor,
            fontSize: 22.sp,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showButtonTitle)
          InkWell(
            onTap: onPressed,
            child: Padding(
              padding: EdgeInsets.all(KSizes.xs),
              child: Text(
                "View all",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: buttonColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
