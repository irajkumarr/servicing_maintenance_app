import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class SectionRowTitleText extends StatelessWidget {
  const SectionRowTitleText({
    super.key,
    required this.title,
    required this.subTitle,
    required this.isViewAll,
  });

  final String title;
  final String subTitle;
  final bool isViewAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: KColors.black,
                    ),
              ),
              !isViewAll
                  ? SizedBox()
                  : Text(
                      "View All",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: KColors.primary,
                          ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
