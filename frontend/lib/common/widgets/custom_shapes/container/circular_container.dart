// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double radius;
  final Border? border;
  final EdgeInsetsGeometry? margin;

  const CircularContainer({
    Key? key,
    this.width = 400,
    this.height = 400,
    required this.color,
    this.radius = 400,
    this.border,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: color,
        border: border ??
            Border.all(
              color: Colors.transparent,
            ),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
