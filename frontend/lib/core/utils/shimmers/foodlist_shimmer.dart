import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/shimmers/shimmer_widget.dart';

class FoodsListShimmer extends StatelessWidget {
  const FoodsListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // padding: const EdgeInsets.only(left: 12, top: 10),
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: KSizes.md),
              decoration: BoxDecoration(
                border: Border.all(color: KColors.grey),
                borderRadius: BorderRadius.circular(KSizes.sm),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                      shimmerWidth: 100.w,
                      // shimmerHieght: 70.h,
                      shimmerHeight: 100.h,
                      shimmerRadius: 0),
                  const SizedBox(width: KSizes.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: KSizes.sm),
                      ShimmerWidget(
                          shimmerWidth: 150.w,
                          // shimmerHieght: 70.h,
                          shimmerHeight: 15.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.sm),
                      ShimmerWidget(
                          shimmerWidth: 100.w,
                          // shimmerHieght: 70.h,
                          shimmerHeight: 15.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.sm),
                      ShimmerWidget(
                          shimmerWidth: 50.w,
                          // shimmerHieght: 70.h,
                          shimmerHeight: 15.h,
                          shimmerRadius: KSizes.md),
                    ],
                  ),
                  const SizedBox(width: KSizes.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: KSizes.sm),
                      ShimmerWidget(
                          shimmerWidth: 50.w,
                          // shimmerHieght: 70.h,
                          shimmerHeight: 15.h,
                          shimmerRadius: KSizes.md),
                      SizedBox(height: KSizes.sm),
                      ShimmerWidget(
                          shimmerWidth: 50.w,
                          // shimmerHieght: 70.h,
                          shimmerHeight: 15.h,
                          shimmerRadius: KSizes.md),
                    ],
                  ),

                  // ShimmerWidget(
                  //     shimmerWidth: MediaQuery.of(context).size.width,
                  //     // shimmerHieght: 70.h,
                  //     shimmerHeight: 125,
                  //     shimmerRadius: KSizes.md),
                ],
              ),
            );
          }),
    );
  }
}
