import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class KAppBarTheme {
  KAppBarTheme._();

  static final lightAppBarTheme = AppBarTheme(
    elevation: 4,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: KColors.white,
    surfaceTintColor: Colors.transparent,

    // surfaceTintColor: Colors.black,
    iconTheme: IconThemeData(color: KColors.black, size: KSizes.iconMd),
    actionsIconTheme: IconThemeData(color: KColors.black, size: KSizes.iconMd),
    titleTextStyle: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: KColors.black,
    ),
  );
  static final darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: KColors.black, size: KSizes.iconMd),
    actionsIconTheme: IconThemeData(color: KColors.white, size: KSizes.iconMd),
    titleTextStyle: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: KColors.white,
    ),
  );
}
