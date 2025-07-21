import 'package:flutter/material.dart';
import 'package:frontend/core/utils/circular_progress_indicator/circlular_indicator.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/address_model.dart';
import 'package:frontend/features/personalization/providers/address_provider.dart';
import 'package:frontend/features/personalization/screens/address/add_new_address.dart';
import 'package:frontend/features/personalization/screens/address/widgets/address_tile.dart';
import 'package:provider/provider.dart';

class AddressList extends StatelessWidget {
  const AddressList({
    super.key,
    required this.addresses,
    required this.refetch,
  });
  final List<AddressModel> addresses;
  final Function refetch;
  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);

    return Container(
      child: addressProvider.isLoading
          ? KIndicator.circularIndicator()
          : Consumer<AddressProvider>(
              builder: (context, provider, _) {
                final defaultAddressId = provider.defaultAddress?.id;

                return ListView.builder(
                  itemCount: addresses.length,
                  itemBuilder: (context, index) {
                    final address = addresses[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: KSizes.md,
                      ),
                      child: Container(
                        margin: const EdgeInsets.only(top: KSizes.md),
                        decoration: BoxDecoration(
                          color: KColors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: AddressTile(
                          address: address,
                          isSelected: address.id == defaultAddressId,
                          onSelect: () async {
                            if (address.id != defaultAddressId) {
                              await addressProvider.setDefaultAddress(
                                context,
                                address.id!,
                              );
                            }
                          },
                          onEdit: () {
                            showAddressModal(context, () async {
                              refetch();
                            }, address: address);
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
