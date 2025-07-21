// import 'package:flutter/material.dart';
// import 'package:frontend/core/utils/constants/colors.dart';
// import 'package:frontend/core/utils/constants/sizes.dart';

// class VehicleSelectionCard extends StatelessWidget {
//   const VehicleSelectionCard({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.onTap,
//   });
//   final IconData icon;
//   final String title;
//   final VoidCallback onTap;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,

//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: KSizes.md,
//           vertical: KSizes.sm + 3,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: KColors.grey),
//         ),
//         child: Row(
//           spacing: KSizes.sm + 4,
//           children: [
//             Icon(icon),
//             Text(
//               title,
//               style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                 color: KColors.black,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
// import 'package:frontend/data/models/service_model.dart' as serviceModel;
import 'package:frontend/features/dashboard/providers/service_provider.dart';
import 'package:frontend/features/personalization/providers/vehicle_provider.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:provider/provider.dart';

class VehicleSelectionCard extends StatelessWidget {
  const VehicleSelectionCard({
    super.key,
    required this.icon,
    required this.title, required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    final isSelected = vehicleProvider.vehicleType == title;
    final serviceProvider = context.read<ServiceProvider>();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: KSizes.md,
          vertical: KSizes.sm + 3,
        ),
        decoration: BoxDecoration(
          color: isSelected ? KColors.black : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? KColors.black : KColors.grey,
            width: 2,
          ),
        ),
        child: Row(
          spacing: KSizes.sm + 4,
          children: [
            Icon(icon, color: isSelected ? KColors.white : KColors.dark),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: isSelected ? KColors.white : KColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
