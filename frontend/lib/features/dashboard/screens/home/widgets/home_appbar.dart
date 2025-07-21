import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/providers/login_provider.dart';
import 'package:frontend/features/personalization/providers/address_provider.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AddressProvider>(
        context,
        listen: false,
      ).fetchUserDefaultAddress();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<LoginProvider>().user;
    final addressProvider = context.watch<AddressProvider>();
    final address = addressProvider.defaultAddress;
    if (user == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return AppBar(
      title: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, ${user.fullName ?? "Loading..."}!",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w600,
                // color: KColors.white,
              ),
            ),
            const SizedBox(height: 2),
            address == null ||
                    address.fullAddress == null ||
                    address.fullAddress!.isEmpty ||
                    addressProvider.isLoading
                ? SizedBox()
                : Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: KColors.darkerGrey,
                        size: KSizes.iconSm,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${address.fullAddress}",
                          style: Theme.of(context).textTheme.bodyLarge!
                              .copyWith(
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
          child: GestureDetector(
            onTap: () {
              context.read<NavigationProvider>().onTap(3);
            },
            child: SizedBox(
              width: 40.w,
              height: 40.h,
              child: Image.asset(KImages.userIcon, fit: BoxFit.contain),
            ),
          ),
        ),
      ],
    );
  }
}
