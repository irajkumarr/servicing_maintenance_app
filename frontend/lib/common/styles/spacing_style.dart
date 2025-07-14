import 'package:flutter/material.dart';

import '../../core/utils/constants/sizes.dart';
import '../../core/utils/device/device_utility.dart';


class KSpacingStyle {
  static EdgeInsets paddingWithAppbar() {
    return EdgeInsets.only(
      top: KDeviceUtils.getAppBarHeight(),
      left: KSizes.defaultSpace,
      bottom: KSizes.defaultSpace,
      right: KSizes.defaultSpace,
    );
  }
}
