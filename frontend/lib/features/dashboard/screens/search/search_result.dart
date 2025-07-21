import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:frontend/features/dashboard/providers/search_provider.dart';
import 'package:frontend/features/dashboard/screens/service/widgets/service_card_horizontal.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/constants/sizes.dart';

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);
    return ListView(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(height: KSizes.md),
        Row(
          children: [
            Text(
              "${searchProvider.searchResults!.length}",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: KColors.primary,
              ),
            ),
            const Text(" results found"),
            Text(
              ' "${searchProvider.searchText}"',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: KColors.black,
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: KSizes.sm),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.83,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              // physics: NeverScrollableScrollPhysics(),
              children: List.generate(searchProvider.searchResults!.length, (
                index,
              ) {
                ServiceModel service = searchProvider.searchResults![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: KSizes.md),
                  child: ServiceCardHorizontal(service: service),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
