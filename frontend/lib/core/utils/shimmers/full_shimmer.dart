import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

import 'package:frontend/core/utils/shimmers/shimmer_widget.dart';

class FullShimmer extends StatelessWidget {
  const FullShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerWidget(
            shimmerWidth: double.infinity,
            shimmerHeight: 175.h,
            shimmerRadius: KSizes.borderRadiusMd),
      ],
    );
  }
}
