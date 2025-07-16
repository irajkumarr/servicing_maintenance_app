import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // context.pushNamed(RoutesConstant.search);
      },
      child: Container(
        height: KDeviceUtils.getAppBarHeight(),
        // height: 40.h,
        width: double.infinity,
        padding: EdgeInsets.only(right: KSizes.sm, left: KSizes.md),
        decoration: BoxDecoration(
          color: KColors.white,
          borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
          border: Border.all(color: KColors.grey, width: 1.4),
        ),
        child: Row(
          spacing: KSizes.sm,
          children: [
            Container(
              // width: 40.w,
              // height: 40.h,
              // decoration: BoxDecoration(
              //   color: KColors.primary,
              //   borderRadius: BorderRadius.circular(50),
              // ),
              child: Icon(
                AntDesign.search_outline,
                color: KColors.darkGrey,
                // size: 28,
              ),
            ),
            Expanded(
              child: Text(
                'Search for services...',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: KColors.darkGrey,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
