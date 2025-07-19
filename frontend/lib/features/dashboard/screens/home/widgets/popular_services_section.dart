import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/texts/section_title.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/service_model.dart' as serviceModel;
import 'package:frontend/features/dashboard/providers/service_provider.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/service_card.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:provider/provider.dart';

class PopularServicesSection extends StatefulWidget {
  const PopularServicesSection({super.key});

  @override
  State<PopularServicesSection> createState() => _PopularServicesSectionState();
}

class _PopularServicesSectionState extends State<PopularServicesSection> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ServiceProvider>();
      if (!provider.hasFetchedTopRated) {
        provider.fetchTopRatedServices();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final serviceProvider = context.watch<ServiceProvider>();
    return Column(
      children: [
        SectionTitle(
          title: "Popular Services",
          showButtonTitle: true,
          buttonTitle: "View All",
          buttonColor: KColors.black,
          onPressed: () {
            context.read<NavigationProvider>().onTap(1);
          },
        ),
        SizedBox(height: KSizes.md),
        serviceProvider.isLoading
            ? Center(child: CustomLoading(color: KColors.primary))
            : serviceProvider.error != null
            ? Center(
                child: Text('Error: ${serviceProvider.error?.message ?? ""}'),
              )
            : serviceProvider.topRatedServices.isEmpty
            ? Center(child: Text('No Available Services'))
            : GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: serviceProvider.topRatedServices.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: KSizes.sm,
                  mainAxisSpacing: KSizes.sm,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  serviceModel.ServiceModel service =
                      serviceProvider.topRatedServices[index];
                  return ServiceCard(service: service);
                },
              ),
      ],
    );
  }
}
