import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/texts/section_title.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/vehicle_selection_card.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class VehicleSelectionSection extends StatelessWidget {
  const VehicleSelectionSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                // onTap: () {},
              ),
            ),
            Expanded(
              child: VehicleSelectionCard(
                title: "Bike",
                icon: Icons.motorcycle_outlined,
                // onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
