import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/service_model.dart' as serviceModel;
import 'package:frontend/features/dashboard/screens/home/widgets/vehicle_selection_card.dart';
import 'package:frontend/features/dashboard/screens/service/widgets/service_card_horizontal.dart';
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
      context.read<ServiceProvider>().fetchServices();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();
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
                    onTap: () {},
                  ),
                  VehicleSelectionCard(
                    title: "Bike",
                    icon: Icons.motorcycle_outlined,
                    onTap: () {},
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
            : serviceProvider.topRatedServices.isEmpty
            ? Center(child: Text('No Available Services'))
            : RefreshIndicator(
                onRefresh: () async {
                  await serviceProvider.fetchServices();
                },
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: KSizes.md,
                    vertical: KSizes.md,
                  ),
                  itemCount: serviceProvider.services.length,
                  itemBuilder: (context, index) {
                    serviceModel.ServiceModel service =
                        serviceProvider.services[index];
                    return ServiceCardHorizontal(service: service);
                  },
                ),
              ),
      ),
    );
  }
}
