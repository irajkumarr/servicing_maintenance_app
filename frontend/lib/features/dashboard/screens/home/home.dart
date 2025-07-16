import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/texts/label_text.dart';
import 'package:frontend/common/widgets/texts/section_title.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_appbar.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_search_bar.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/home_service_history_setion.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/popular_services_section.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/service_card.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/vehicle_selection_card.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/vehicle_selection_section.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.md),
          child: Column(
            children: [
              HomeSearchBar(),
              SizedBox(height: KSizes.defaultSpace),
              //vehicle selection
              VehicleSelectionSection(),
              SizedBox(height: KSizes.defaultSpace),

              //popular services section or top rated section
              PopularServicesSection(),

              SizedBox(height: KSizes.defaultSpace),
              //book service and view history section
              HomeServiceAndHistoryButtonSection(),
            ],
          ),
        ),
      ),
    );
  }
}
