import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

import 'package:frontend/core/utils/shimmers/shimmer_widget.dart';


class CategoriesVerticalShimmer extends StatelessWidget {
  const CategoriesVerticalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110.h,
        child: ListView.builder(
            itemCount: 10,
            padding: EdgeInsets.only(left: KSizes.md),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(right: KSizes.md),
                child: ShimmerWidget(
                    shimmerWidth: 110.w,
                    shimmerHeight: 110.h,
                    shimmerRadius: KSizes.md),
              );
            }));
  }
}
