import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/custom_shapes/container/rounded_container.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/address_model.dart';

class AddressTile extends StatelessWidget {
  final AddressModel address;
  final bool isSelected;
  final VoidCallback onSelect;
  final Function? onEdit;

  const AddressTile(
      {super.key,
      required this.address,
      required this.isSelected,
      required this.onSelect,
      this.onEdit});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      width: double.infinity,
      showBorder: true,
      // color: KColors.light,
      color: KColors.white,
      radius: KSizes.sm,
      borderColor: KColors.grey,
      child: ListTile(
        title: Text(
          address.label??"",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: KColors.primary),
        ),
        subtitle: Text(
          address.fullAddress??"",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onEdit != null)
              TextButton(
                onPressed: () => onEdit!(),
                // child: Icon(Icons.edit),
                child: const Text("Edit"),
              ),
            Checkbox(
              value: isSelected,
              onChanged: (value) => onSelect(),
            ),
          ],
        ),
        onTap: () {
          onSelect();
        },
      ),
    );
  }
}