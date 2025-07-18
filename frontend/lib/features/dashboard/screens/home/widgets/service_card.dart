import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:go_router/go_router.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key, required this.service});
  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(KSizes.sm),
      onTap: () {
        context.pushNamed(RoutesConstant.book, extra: service.id);
      },
      child: Container(
        padding: EdgeInsets.all(KSizes.md),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(KSizes.sm),
          color: Colors.transparent,
          border: Border.all(color: KColors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 55.w,
              height: 55.h,
              padding: EdgeInsets.all(KSizes.sm),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(KSizes.sm),
                color: KColors.grey,
              ),
              child: Image.network(service.imageUrl ?? "", fit: BoxFit.contain),
            ),
            // Container(
            //   padding: EdgeInsets.all(KSizes.md - 5),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(KSizes.sm),
            //     color: KColors.grey,
            //   ),
            //   child: Icon(Icons.wash_outlined),
            // ),
            SizedBox(height: KSizes.sm),
            Text(
              service.title ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: KColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),

            // SizedBox(height: KSizes.xs),
            Text(
              service.estimatedTime ?? "",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: KColors.darkGrey,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: KSizes.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs ${service.basePrice}",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: KColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  spacing: KSizes.xs,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: KSizes.iconSm),
                    Text(
                      service.rating.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                        // fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
