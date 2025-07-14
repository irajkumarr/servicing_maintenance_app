import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

import 'package:frontend/core/utils/shimmers/shimmer_widget.dart';

class JobDetailShimmer extends StatelessWidget {
  const JobDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: KSizes.md, vertical: KSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ShimmerWidget(
                  shimmerWidth: 75.w,
                  shimmerHeight: 75.h,
                  shimmerRadius: KSizes.md),
              SizedBox(width: KSizes.sm),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                      shimmerWidth: 100.w,
                      shimmerHeight: 7.h,
                      shimmerRadius: KSizes.md),
                  SizedBox(height: KSizes.sm),
                  ShimmerWidget(
                      shimmerWidth: 150.w,
                      shimmerHeight: 7.h,
                      shimmerRadius: KSizes.md),
                ],
              )
            ],
          ),
          SizedBox(height: KSizes.defaultSpace),
          ShimmerWidget(
              shimmerWidth: 200.w,
              shimmerHeight: 7.h,
              shimmerRadius: KSizes.md),
          SizedBox(height: KSizes.md),
          ShimmerWidget(
              shimmerWidth: 70.w, shimmerHeight: 7.h, shimmerRadius: KSizes.md),
          SizedBox(height: KSizes.md),
          ShimmerWidget(
              shimmerWidth: 100.w,
              shimmerHeight: 7.h,
              shimmerRadius: KSizes.md),
          SizedBox(height: KSizes.defaultSpace),
          Container(
            height: 350.h,
            padding: const EdgeInsets.all(KSizes.md),
            decoration: BoxDecoration(
              color: KColors.secondaryBackground,
              borderRadius: BorderRadius.circular(KSizes.md),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ShimmerWidget(
                          shimmerWidth: 125.w,
                          shimmerHeight: 7.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.md),
                      ShimmerWidget(
                          shimmerWidth: 125.w,
                          shimmerHeight: 7.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.md),
                      ShimmerWidget(
                          shimmerWidth: 125.w,
                          shimmerHeight: 7.h,
                          shimmerRadius: KSizes.md),
                    ],
                  ),
                ),
                SizedBox(width: KSizes.md),
                Expanded(
                  child: Column(
                    children: [
                      ShimmerWidget(
                          shimmerWidth: 125.w,
                          shimmerHeight: 7.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.md),
                      ShimmerWidget(
                          shimmerWidth: 125.w,
                          shimmerHeight: 7.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.md),
                      ShimmerWidget(
                          shimmerWidth: 125.w,
                          shimmerHeight: 7.h,
                          shimmerRadius: KSizes.md),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: KSizes.defaultSpace),
          Container(
            height: 350.h,
            width: double.infinity,
            padding: const EdgeInsets.all(KSizes.md),
            decoration: BoxDecoration(
              color: KColors.secondaryBackground,
              borderRadius: BorderRadius.circular(KSizes.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerWidget(
                    shimmerWidth: 200.w,
                    shimmerHeight: 7.h,
                    shimmerRadius: KSizes.md),
                SizedBox(height: KSizes.md),
                ShimmerWidget(
                    shimmerWidth: 300.w,
                    shimmerHeight: 7.h,
                    shimmerRadius: KSizes.md),
                SizedBox(height: KSizes.md),
                ShimmerWidget(
                    shimmerWidth: 300.w,
                    shimmerHeight: 7.h,
                    shimmerRadius: KSizes.md),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
