import 'package:flutter/material.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/service_model.dart' as serviceModel;
import 'package:frontend/features/dashboard/screens/home/widgets/vehicle_selection_card.dart';
import 'package:frontend/features/dashboard/screens/service/widgets/service_card_horizontal.dart';
import 'package:frontend/features/personalization/providers/vehicle_provider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import 'package:frontend/features/dashboard/providers/service_provider.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // context.read<ServiceProvider>().fetchServices();

      final vehicleProvider = Provider.of<VehicleProvider>(
        context,
        listen: false,
      );
      context.read<ServiceProvider>().fetchServicesByType(
        vehicleProvider.vehicleType!.toLowerCase(),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();
    final vehicleProvider = context.watch<VehicleProvider>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Services",
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.w600,
              // color: KColors.white,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: KSizes.md),
              child: Row(
                spacing: KSizes.md,
                children: [
                  VehicleSelectionCard(
                    title: "Car",
                    icon: AntDesign.car_outline,
                    onTap: () async {
                      vehicleProvider.selectVehicleType("Car");

                      await serviceProvider.fetchServicesByType(
                        vehicleProvider.vehicleType!.toLowerCase(),
                      );
                    },
                  ),
                  VehicleSelectionCard(
                    title: "Bike",
                    icon: Icons.motorcycle_outlined,
                    onTap: () async {
                      vehicleProvider.selectVehicleType("Bike");

                      await serviceProvider.fetchServicesByType(
                        vehicleProvider.vehicleType!.toLowerCase(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: serviceProvider.isLoading
            ? Center(child: CustomLoading(color: KColors.primary))
            : serviceProvider.error != null
            ? Center(
                child: Text('Error: ${serviceProvider.error?.message ?? ""}'),
              )
            : serviceProvider.servicesByType.isEmpty
            ? Center(child: Text('No Available Services'))
            : RefreshIndicator(
                onRefresh: () async {
                  await serviceProvider.fetchServicesByType(
                    vehicleProvider.vehicleType!.toLowerCase(),
                  );
                },
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: KSizes.md,
                    vertical: KSizes.md,
                  ),
                  itemCount: serviceProvider.servicesByType.length,
                  itemBuilder: (context, index) {
                    serviceModel.ServiceModel service =
                        serviceProvider.servicesByType[index];
                    return ServiceCardHorizontal(service: service);
                  },
                ),
              ),
      ),
    );
  }
}
