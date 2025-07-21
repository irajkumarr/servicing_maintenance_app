import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/core/network/connectivity_checker.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/personalization/providers/address_provider.dart';
import 'package:frontend/features/personalization/screens/address/add_new_address.dart';
import 'package:frontend/features/personalization/screens/address/widgets/address_list.dart';

import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AddressProvider>().fetchUserAddresses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> emptyMessages = [
      "Where are we servicing today? Add your address to begin.",
      "Let's get you set up! Add a delivery address to start.",
      "You haven't added an address yet! Let's fix that.",
      "Ready to explore? Add your address now!",
    ];

    // Randomly select a message from the list
    final randomMessage = emptyMessages[Random().nextInt(emptyMessages.length)];
    final addressProvider = context.watch<AddressProvider>();
    return ConnectivityChecker(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddressModal(context, () async {
              await addressProvider.fetchUserAddresses();
            });
          },
          backgroundColor: KColors.primary,
          child: const Icon(Iconsax.add, color: KColors.white),
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Material(
            elevation: 1,
            child: AppBar(title: const Text("Your Saved Locations")),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await addressProvider.fetchUserAddresses();
          },
          child: addressProvider.isLoading
              ? Center(child: CustomLoading(color: KColors.primary))
              : (addressProvider.addresses.isEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: KSizes.defaultSpace,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SizedBox(height: KSizes.spaceBtwSections),
                        Text(
                          "No Delivery Address Found",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(height: KSizes.sm),
                        Text(
                          randomMessage,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        // Text(
                        //   "Delivery options and delivery speeds may vary for different locations.",
                        //   style: Theme.of(context).textTheme.bodySmall,
                        //   textAlign: TextAlign.center,
                        // ),
                      ],
                    ),
                  ),
                )
              : AddressList(
                  addresses: addressProvider.addresses,
                  refetch: () async {
                    await addressProvider.fetchUserAddresses();
                  },
                ),
        ),
      ),
    );
  }
}
