import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';

import 'package:frontend/core/utils/shimmers/shimmer_widget.dart';

class FoodTileVerticalShimmer extends StatelessWidget {
  const FoodTileVerticalShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: KSizes.md),
      // height: 190.h,
      height: 300.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              width: 190.h,
              margin: const EdgeInsets.only(right: KSizes.md),
              decoration: BoxDecoration(
                border: Border.all(color: KColors.grey),
                borderRadius: BorderRadius.circular(KSizes.sm),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                      shimmerWidth: KDeviceUtils.getScreenWidth(context),
                      shimmerHeight: 180.h,
                      shimmerRadius: KSizes.sm),
                  SizedBox(height: KSizes.spaceBtwItems / 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerWidget(
                          shimmerWidth: 160.w,
                          shimmerHeight: 15.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.spaceBtwItems / 2),
                      ShimmerWidget(
                          shimmerWidth: 130.w,
                          shimmerHeight: 10.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.spaceBtwItems / 2),
                      ShimmerWidget(
                          shimmerWidth: 100.w,
                          shimmerHeight: 10.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.spaceBtwItems / 2),
                      ShimmerWidget(
                          shimmerWidth: 70.w,
                          shimmerHeight: 10.h,
                          shimmerRadius: KSizes.md),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
