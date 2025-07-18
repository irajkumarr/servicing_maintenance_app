import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:icons_plus/icons_plus.dart';

class ServiceConfirmScreen extends StatelessWidget {
  const ServiceConfirmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColors.white,
      appBar: AppBar(
        backgroundColor: KColors.white,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Service Tracking",
              style: Theme.of(
                context,
              ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(KSizes.md),
                color: KColors.primary.withOpacity(0.2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline_outlined,
                    color: KColors.primary,
                    size: KSizes.iconSm,
                  ),
                  Text(
                    "Confirmed",
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall!.copyWith(color: KColors.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          //service details
Container(
          padding: EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(KSizes.sm),
            color: Colors.transparent,
            border: Border.all(color: KColors.grey),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 55.w,
                height: 55.h,
                padding: EdgeInsets.all(KSizes.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  color: KColors.grey,
                ),
                child: Image.network(
                  service.imageUrl ?? "",
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(width: KSizes.xs),
              SizedBox(
                width: 150.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: KSizes.xs,
                  children: [
                    Text(
                      service.title ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      service.description ?? "",

                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: KColors.darkGrey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          spacing: KSizes.xs,
                          children: [
                            Icon(
                              FontAwesome.clock,
                              color: KColors.darkGrey,
                              size: KSizes.iconSm,
                            ),
                            Text(
                              service.estimatedTime ?? "",
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    color: KColors.darkGrey,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: KSizes.xs,
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: KSizes.iconSm,
                            ),
                            Text(
                              service.rating.toString(),
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
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

              SizedBox(width: KSizes.xs),
              Column(
                spacing: KSizes.sm,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Rs ${service.basePrice}",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: KColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                 
                ],
              ),
            ],
          ),
        )
          //service provider details

          //service location details

          //cancel button

          //return to home button
        ],
      ),
    );
  }
}
