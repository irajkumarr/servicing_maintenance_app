import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, Rajkumar!",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w600,
                // color: KColors.white,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: KColors.darkerGrey,
                  size: KSizes.iconSm,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    "Hetauda, Makwanpur",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      // color: KColors.white,
                      color: KColors.darkerGrey,

                      // fontStyle: FontStyle.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          tooltip: "Notification",
          onPressed: () {
            // Navigator.pushNamed(context, "/search");
          },
          icon: Icon(
            Icons.notifications_on_outlined,
            // color: KColors.white,
            size: KSizes.iconMd,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: KSizes.md),
          child: SizedBox(
            width: 40.w,
            height: 40.h,
            child: Image.asset(KImages.userIcon, fit: BoxFit.contain),
          ),
        ),
      ],
    );
  }
}
