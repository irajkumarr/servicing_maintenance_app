import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

import 'package:frontend/core/utils/shimmers/shimmer_widget.dart';

class RoomShimmer extends StatelessWidget {
  const RoomShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding:
            EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.md),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: KSizes.spaceBtwSections),
            child: Row(
              spacing: KSizes.sm,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget(
                    shimmerWidth: 120.w,
                    shimmerHeight: 120.h,
                    shimmerRadius: KSizes.sm),
                Column(
                  spacing: KSizes.sm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: KSizes.md),
                    ShimmerWidget(
                        shimmerWidth: 75.w,
                        shimmerHeight: 15.h,
                        shimmerRadius: 0),
                    ShimmerWidget(
                        shimmerWidth: 80.w,
                        shimmerHeight: 8.h,
                        shimmerRadius: 0),
                    ShimmerWidget(
                        shimmerWidth: 160.w,
                        shimmerHeight: 8.h,
                        shimmerRadius: 0),
                    ShimmerWidget(
                        shimmerWidth: 140.w,
                        shimmerHeight: 8.h,
                        shimmerRadius: 0),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
