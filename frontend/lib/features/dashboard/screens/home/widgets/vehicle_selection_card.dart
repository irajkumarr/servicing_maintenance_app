import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class VehicleSelectionCard extends StatelessWidget {
  const VehicleSelectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,

      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: KSizes.md,
          vertical: KSizes.sm + 3,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: KColors.grey),
        ),
        child: Row(
          spacing: KSizes.sm + 4,
          children: [
            Icon(icon),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: KColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
