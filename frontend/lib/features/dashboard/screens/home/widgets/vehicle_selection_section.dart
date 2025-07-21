import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/texts/section_title.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/vehicle_selection_card.dart';
import 'package:frontend/features/personalization/providers/vehicle_provider.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../providers/service_provider.dart';

class VehicleSelectionSection extends StatelessWidget {
  const VehicleSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
    
    final serviceProvider = context.watch<ServiceProvider>();
    final vehicleProvider = context.watch<VehicleProvider>();
    return Column(
      children: [
        SectionTitle(
          title: "Select Vehicle",
          showButtonTitle: true,
          buttonTitle: "Manage",
          buttonColor: KColors.black,
          onPressed: () {
            context.pushNamed(RoutesConstant.vehicle);
          },
        ),
        SizedBox(height: KSizes.md),
        Row(
          spacing: KSizes.md,
          children: [
            Expanded(
              child: VehicleSelectionCard(
                title: "Car",
                icon: AntDesign.car_outline,
                onTap: () async {
                      context.read<NavigationProvider>().onTap(1);
                      vehicleProvider.selectVehicleType("Car");

                      await serviceProvider.fetchServicesByType(
                        vehicleProvider.vehicleType!.toLowerCase(),
                      );
                    },
              ),
            ),
            Expanded(
              child: VehicleSelectionCard(
                title: "Bike",
                icon: Icons.motorcycle_outlined,
                onTap: () async {
                      context.read<NavigationProvider>().onTap(1);
                      vehicleProvider.selectVehicleType("Bike");

                      await serviceProvider.fetchServicesByType(
                        vehicleProvider.vehicleType!.toLowerCase(),
                      );
                    },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
