import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';

class KIndicator {
  static circularIndicator({Color color=KColors.primary}) {
    return Center(
      child: SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: color,
          )),
    );
  }
}
