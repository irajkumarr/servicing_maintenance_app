import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class LabelText extends StatelessWidget {
  const LabelText({super.key, required this.title, this.textColor});
  final String title;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: KSizes.sm),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium!.copyWith(color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
