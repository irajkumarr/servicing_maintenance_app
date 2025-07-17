import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:icons_plus/icons_plus.dart';

class ServiceCardHorizontal extends StatelessWidget {
  const ServiceCardHorizontal({super.key, required this.service});
  final ServiceModel service;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: KSizes.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(KSizes.sm),
        onTap: () {},
        child: Container(
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
                  SizedBox(
                    // height: 30.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: KSizes.sm,
                          horizontal: KSizes.md,
                        ),
                        backgroundColor: KColors.black,
                      ),
                      onPressed: () {},
                      child: Text(
                        "Book Now",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: KColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
