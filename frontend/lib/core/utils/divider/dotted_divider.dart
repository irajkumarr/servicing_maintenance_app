
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';

class DottedDivider extends StatelessWidget {
  const DottedDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dash(
      direction: Axis.horizontal,
      length: KDeviceUtils.getScreenWidth(context) - KSizes.spaceBtwSections,
      dashLength: 5,
      dashColor: KColors.grey,
    );
  }
}
