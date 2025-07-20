import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/data/models/user_model.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.watch<LoginProvider>();
    final UserModel? user = loginProvider.user;

    if (user == null) {
      return const Center(child: CustomLoading(color: KColors.primary));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w600,
            // color: KColors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.md),
        child: Column(
          children: [
            //image with name and phone number of logged in user
            Column(
              spacing: KSizes.sm,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: user.profileImage == null
                        ? Image.asset(KImages.userIcon, fit: BoxFit.cover)
                        : Image.network(user.profileImage!, fit: BoxFit.cover),
                  ),
                ),
                Text(
                  user.fullName!,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  "+977 ${user.phoneNumber!}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            SizedBox(height: KSizes.defaultSpace),
            //button for managing vehicle
            InkWell(
              borderRadius: BorderRadius.circular(KSizes.sm),

              onTap: () {
                context.pushNamed(RoutesConstant.vehicle);
              },

              child: Container(
                width: KDeviceUtils.getScreenWidth(context),
                padding: EdgeInsets.all(KSizes.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  color: Colors.transparent,
                  border: Border.all(color: KColors.grey),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Icon(Icons.directions_car, color: KColors.darkerGrey),
                      SizedBox(width: KSizes.sm),
                      Text(
                        "My Vehicles",

                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: KColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: KSizes.iconSm,
                        color: KColors.darkerGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: KSizes.defaultSpace),
            //button for saved locations
            InkWell(
              borderRadius: BorderRadius.circular(KSizes.sm),

              onTap: () {},

              child: Container(
                width: KDeviceUtils.getScreenWidth(context),
                padding: EdgeInsets.all(KSizes.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  color: Colors.transparent,
                  border: Border.all(color: KColors.grey),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Icon(Iconsax.location_outline, color: KColors.darkerGrey),
                      SizedBox(width: KSizes.sm),
                      Text(
                        "Saved Locations",

                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: KColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: KSizes.iconSm,
                        color: KColors.darkerGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: KSizes.defaultSpace),
            //button for sign out from the app
            InkWell(
              borderRadius: BorderRadius.circular(KSizes.sm),

              onTap: () {
                context.read<NavigationProvider>().onTap(0);
                context.read<LoginProvider>().logout(context);
              },

              child: Container(
                width: KDeviceUtils.getScreenWidth(context),
                padding: EdgeInsets.all(KSizes.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  color: Colors.transparent,
                  border: Border.all(color: KColors.grey),
                ),
                child: Center(
                  child: Text(
                    "Sign Out",

                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: KColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
