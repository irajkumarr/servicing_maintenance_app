import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

import 'package:frontend/core/utils/shimmers/shimmer_widget.dart';

class CatergoriesShimmer extends StatelessWidget {
  const CatergoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 225.h,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: KSizes.md),
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: KSizes.md),
              child: Column(
                children: [
                  ShimmerWidget(
                      shimmerWidth: 170.w,
                      shimmerHeight: 225.h,
                      shimmerRadius: KSizes.borderRadiusMd),
                  // SizedBox(height: KSizes.sm),
                  // ShimmerWidget(
                  //     shimmerWidth: 55.w,
                  //     shimmerHeight: 10.h,
                  //     shimmerRadius: KSizes.borderRadiusMd),
                ],
              ),
            );
          }),
    );
  }
}
