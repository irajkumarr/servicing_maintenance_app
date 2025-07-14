import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget(
      {super.key,
      required this.shimmerWidth,
      required this.shimmerHeight,
      required this.shimmerRadius});

  final double shimmerWidth;
  final double shimmerHeight;
  final double shimmerRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: shimmerWidth,
      height: shimmerHeight,
      // padding: const EdgeInsets.only(right: 12),
      child: _buildShimmerLine(
          // height: shimmerHieght - 20,
          // width: shimmerHieght - 15,
          height: shimmerHeight,
          width: shimmerWidth,
          radius: shimmerRadius),
    );
  }

  Widget _buildShimmerLine(
      {required double height, required double width, required double radius}) {
    return Shimmer.fromColors(
      baseColor: Color(0xffE6EBF1),
      highlightColor: Color(0xffffffff),
      // baseColor: KColors.primaryContainer,
      // highlightColor: KColors.white,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
