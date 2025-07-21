import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/address_model.dart';
import 'package:frontend/features/personalization/providers/address_provider.dart';
import 'package:frontend/features/personalization/providers/map_provider.dart';
import 'package:frontend/features/personalization/screens/address/widgets/setting_address_on_map.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/constants/colors.dart';

void showAddressModal(
  BuildContext context,
  Function? refetch, {
  AddressModel? address,
}) {
  // final locationProvider =
  //     Provider.of<LocationProvider>(context, listen: false);
  final mapProvider = Provider.of<MapProvider>(context, listen: false);
  final formKey = GlobalKey<FormState>();

  TextEditingController addressTitle = TextEditingController(
    text: address?.label ?? '',
  );
  TextEditingController location = TextEditingController(
    text: address?.fullAddress ?? '',
  );

  showModalBottomSheet(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (context) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20.0.h,
            right: 20.0.h,
            top: 20.0.h,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address == null
                      ? "Add Delivery Address"
                      : "Edit Delivery Address",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: KSizes.spaceBtwItems),
                TextFormField(
                  controller: addressTitle,
                  validator: (value) =>
                      KValidator.validateEmptyText("Address label", value),
                  decoration: const InputDecoration(
                    labelText: 'Address label',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: KSizes.md),
                TextFormField(
                  controller: location,
                  readOnly: true,
                  onTap: () async {
                    final selectedLocation = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingAddressOnMapScreen(),
                      ),
                    );
                    if (selectedLocation != null) {
                      location.text = selectedLocation;
                    }
                  },
                  validator: (value) =>
                      KValidator.validateEmptyText("Address", value),
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    suffixIcon: Icon(Icons.location_on_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: KSizes.spaceBtwItems),
                Center(
                  child: SizedBox(
                    height: 45.h,
                    width: double.infinity,
                    // width: 200.w,
                    child: Consumer<AddressProvider>(
                      builder: (context, addressProvider, child) {
                        return ElevatedButton(
                          onPressed: addressProvider.isLoading
                              ? null
                              : () async {
                                  if (formKey.currentState!.validate()) {
                                    AddressModel model = AddressModel(
                                      label: addressTitle.text,
                                      fullAddress: location.text,

                                      location: Location(
                                        latitude:
                                            mapProvider
                                                .selectedLocation
                                                ?.latitude ??
                                            0,
                                        longitude:
                                            mapProvider
                                                .selectedLocation
                                                ?.longitude ??
                                            0,
                                      ),
                                      isDefault: true,
                                    );

                                    String data = addressModelToJson(model);
                                    if (address == null) {
                                      await addressProvider.addAddress(
                                        context,
                                        data,
                                      );
                                    } else {
                                      await addressProvider.updateAddress(
                                        context,
                                        address.id!,
                                        data,
                                      );
                                    }

                                    if (refetch != null) {
                                      refetch();
                                    }

                                    Navigator.pop(context);
                                  }
                                },
                          child: addressProvider.isLoading
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("CONFIRM"),
                                    const SizedBox(width: 8.0),
                                    SizedBox(
                                      height: 12.0.h,
                                      width: 12.0.w,
                                      child: const CircularProgressIndicator(
                                        color: KColors.primary,
                                        strokeWidth: 1.5,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text('CONFIRM'),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: KSizes.md),
              ],
            ),
          ),
        ),
      );
    },
  );
}
