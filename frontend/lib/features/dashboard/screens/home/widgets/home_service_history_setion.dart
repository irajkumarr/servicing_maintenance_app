import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:provider/provider.dart';

class HomeServiceAndHistoryButtonSection extends StatelessWidget {
  const HomeServiceAndHistoryButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.read<NavigationProvider>();
    return Row(
      spacing: KSizes.sm + 4,
      children: [
        //book service
        Expanded(
          child: InkWell(
            onTap: () {
              navigationProvider.onTap(1);
            },

            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.all(KSizes.md),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: KColors.grey),
              ),
              child: Column(
                spacing: KSizes.sm,
                children: [
                  Icon(Icons.add),
                  Text(
                    "Book Service",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: KColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //view history
        Expanded(
          child: InkWell(
            onTap: () {
              navigationProvider.onTap(2);
            },

            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: EdgeInsets.all(KSizes.md),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: KColors.grey),
              ),
              child: Column(
                spacing: KSizes.sm,
                children: [
                  Icon(Icons.calendar_today_outlined),
                  Text(
                    "View History",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: KColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
