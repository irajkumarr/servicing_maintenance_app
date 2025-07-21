import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/alert_box.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/vehicle_model.dart';
import 'package:frontend/features/personalization/providers/vehicle_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

// class VehicleCard extends StatelessWidget {
//   const VehicleCard({super.key, required this.vehicle});
//   final VehicleModel vehicle;
//   @override
//   Widget build(BuildContext context) {
//     String getVehicleIcon(String vehicleType) {
//       switch (vehicleType.toLowerCase()) {
//         case 'car':
//           return '🚗';

//         case 'bike':
//           return '🏍️';

//         default:
//           return '🚗';
//       }
//     }

//     return Container(
//       margin: EdgeInsets.only(bottom: KSizes.md),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(12),
//         onTap: () {},
//         child: Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: KColors.grey),
//           ),
//           child: Row(
//             children: [
//               Text(
//                 getVehicleIcon(vehicle.vehicleType ?? 'car'),
//                 style: TextStyle(fontSize: 24),
//               ),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       '${vehicle.brand} ${vehicle.model}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     Text(
//                       vehicle.registrationNumber ?? 'No number',
//                       style: TextStyle(color: Colors.grey[600], fontSize: 14),
//                     ),
//                     SizedBox(height: KSizes.sm),
//                     Row(
//                       spacing: KSizes.md,
//                       children: [
//                         _buildChip(context, vehicle.year.toString()),
//                         _buildChip(context, vehicle.color ?? ""),
//                         _buildChip(context, vehicle.fuelType ?? ""),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }

class VehicleCard extends StatelessWidget {
  const VehicleCard({super.key, required this.vehicle});
  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = context.watch<VehicleProvider>();
    String getVehicleIcon(String vehicleType) {
      switch (vehicleType.toLowerCase()) {
        case 'car':
          return '🚗';
        case 'bike':
          return '🏍️';
        default:
          return '🚗';
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: KSizes.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: KColors.grey),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getVehicleIcon(vehicle.vehicleType ?? 'car'),
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vehicle.brand} ${vehicle.model}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      vehicle.registrationNumber ?? 'No number',
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    SizedBox(height: KSizes.sm),
                    Row(
                      children: [
                        _buildChip(context, vehicle.year.toString()),
                        SizedBox(width: 8),
                        _buildChip(context, vehicle.color ?? ""),
                        SizedBox(width: 8),
                        _buildChip(context, vehicle.fuelType ?? ""),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Iconsax.edit_outline,
                      color: KColors.darkerGrey,
                      size: KSizes.iconSm,
                    ),
                    onPressed: () {
                      context.pushNamed(
                        RoutesConstant.addVehicle,
                        extra: vehicle,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      color: KColors.error,
                      size: KSizes.iconSm,
                    ),
                    onPressed: () async {
                      await CustomAlertBox.showAlert(
                        context,
                        "Are you sure you want to delete this vehicle?",
                        () async {
                          await vehicleProvider.deleteVehicle(vehicle.id!);
                        },
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildChip(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: KSizes.sm, vertical: KSizes.xs),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: KColors.grey),
      ),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(color: KColors.darkerGrey),
      ),
    );
  }
}
