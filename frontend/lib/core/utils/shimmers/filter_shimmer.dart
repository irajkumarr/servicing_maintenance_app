import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

import 'package:frontend/core/utils/shimmers/shimmer_widget.dart';

class FilterShimmer extends StatelessWidget {
  const FilterShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md).copyWith(
        top: KSizes.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerWidget(
              shimmerWidth: 100.w,
              shimmerHeight: 30.h,
              shimmerRadius: KSizes.xs),
          SizedBox(height: KSizes.sm),
          ShimmerWidget(
              shimmerWidth: 200.w,
              shimmerHeight: 20.h,
              shimmerRadius: KSizes.xs),
          SizedBox(height: KSizes.md),
          SizedBox(
            height: 40.h,
            child: ListView.builder(
              // padding: EdgeInsets.symmetric(horizontal: KSizes.sm),
              itemCount: 5,
              // shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: KSizes.sm),
                  child: ShimmerWidget(
                      shimmerWidth: 100.w,
                      shimmerHeight: 20.h,
                      shimmerRadius: KSizes.defaultSpace),
                );
              },
            ),
          ),
          SizedBox(height: KSizes.sm),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: KSizes.sm),
                    child: ShimmerWidget(
                        shimmerWidth: double.infinity,
                        shimmerHeight: 140.h,
                        shimmerRadius: KSizes.borderRadiusMd),
                  );
                }),
          )
        ],
      ),
    );
  }
}
