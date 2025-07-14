import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class KElevatedButtonTheme {
  KElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: KColors.light,
      backgroundColor: KColors.primary,
      disabledForegroundColor: KColors.textGrey,
      disabledBackgroundColor: KColors.buttonDisabled,
      // side: const BorderSide(color: KColors.primary),
      padding: EdgeInsets.symmetric(vertical: KSizes.buttonHeight),
      textStyle: TextStyle(
          fontSize: 16.sp,
          color: KColors.textWhite,
          fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: KColors.light,
      backgroundColor: KColors.primary,
      disabledForegroundColor: KColors.darkGrey,
      disabledBackgroundColor: KColors.darkerGrey,
      side: const BorderSide(color: KColors.primary),
      padding: EdgeInsets.symmetric(vertical: KSizes.buttonHeight),
      textStyle: TextStyle(
          fontSize: 16.sp,
          color: KColors.textWhite,
          fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );
}
