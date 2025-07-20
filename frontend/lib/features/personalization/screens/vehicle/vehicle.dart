import 'package:flutter/material.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/vehicle_model.dart';
import 'package:frontend/features/personalization/providers/vehicle_provider.dart';
import 'package:frontend/features/personalization/screens/vehicle/widgets/vehicle_card.dart';
import 'package:provider/provider.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<VehicleProvider>().fetchUserVehicles();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vehicleProvider = context.watch<VehicleProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Vehicles",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: KSizes.md),
            child: InkWell(
              onTap: () {},

              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: KSizes.md,
                  vertical: KSizes.sm,
                ),
                decoration: BoxDecoration(
                  color: KColors.black,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: KColors.grey),
                ),
                child: Row(
                  spacing: KSizes.md,
                  children: [
                    Icon(Icons.add, color: KColors.grey, size: KSizes.iconSm),
                    Text(
                      "Add Vehicle",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: vehicleProvider.isLoading
          ? Center(child: CustomLoading(color: KColors.primary))
          : vehicleProvider.error != null
          ? Center(
              child: Text('Error: ${vehicleProvider.error?.message ?? ""}'),
            )
          : vehicleProvider.vehicles.isEmpty
          ? Center(child: Text('No Vehicles Added'))
          : ListView.builder(
              padding: EdgeInsets.all(KSizes.md),
              itemCount: vehicleProvider.vehicles.length,
              itemBuilder: (context, index) {
                VehicleModel vehicle = vehicleProvider.vehicles[index];
                return VehicleCard(vehicle: vehicle);
              },
            ),
    );
  }
}
