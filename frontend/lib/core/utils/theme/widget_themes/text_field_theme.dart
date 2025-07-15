import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class KTextFormFieldTheme {
  KTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: KColors.darkGrey,

    suffixIconColor: KColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
      fontSize: KSizes.fontSizeSm,
      color: KColors.darkGrey,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: KSizes.fontSizeSm,
      fontWeight: FontWeight.w400,
      color: KColors.darkGrey,
    ),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
      color: KColors.primary,
      fontSize: KSizes.fontSizeSm,
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1.3, color: KColors.lightBackground),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1.3, color: KColors.lightBackground),
    ),
    disabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1.3, color: KColors.lightBackground),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1.3, color: KColors.primary),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1.3, color: KColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1.3, color: KColors.error),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: KColors.darkGrey,
    suffixIconColor: KColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
      fontSize: KSizes.fontSizeMd,
      color: KColors.white,
    ),
    hintStyle: const TextStyle().copyWith(
      fontSize: KSizes.fontSizeSm,
      color: KColors.white,
    ),
    floatingLabelStyle: const TextStyle().copyWith(
      color: KColors.white.withOpacity(0.8),
    ),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: KColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: KColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: KColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: KColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(KSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: KColors.warning),
    ),
  );
}
