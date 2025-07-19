import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/texts/section_title.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/shimmers/job_detail_shimmer.dart';
import 'package:frontend/data/models/address_model.dart';
import 'package:frontend/data/models/service_model.dart';
import 'package:frontend/data/models/vehicle_model.dart';
import 'package:frontend/features/dashboard/providers/booking_provider.dart';
import 'package:frontend/features/dashboard/providers/vehicle_provider.dart';
import 'package:frontend/navigation_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceConfirmScreen extends StatefulWidget {
  const ServiceConfirmScreen({super.key, required this.bookingId});
  final String bookingId;

  @override
  State<ServiceConfirmScreen> createState() => _ServiceConfirmScreenState();
}

class _ServiceConfirmScreenState extends State<ServiceConfirmScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(
        context,
        listen: false,
      ).fetchBookingById(widget.bookingId);
      // ).fetchBookingById("687b3e5813763c561f640bd7");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    final booking = bookingProvider.booking;
    if (bookingProvider.isLoading) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Material(
            elevation: 0.2,
            child: AppBar(
              title: Text(
                'Service Tracking',
                style: Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(fontSize: 22),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(child: JobDetailShimmer()),
      );
    }
    if (booking == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No service data found.",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ),
      );
    }

    final utcDate = DateTime.parse(booking.scheduledAt.toString());
    final localDate = utcDate.toLocal();

    print(DateFormat('yyyy-MM-dd hh:mm a').format(localDate));
    final scheduleDate = DateFormat('yyyy-MM-dd hh:mm a').format(localDate);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.md),
          child: Column(
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
                        booking.service!.imageUrl ?? "",
                        fit: BoxFit.contain,
                      ),
                    ),

                    SizedBox(width: KSizes.xs),
                    SizedBox(
                      width: 170.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: KSizes.xs,
                        children: [
                          Text(
                            booking.service!.title ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: KColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            "${booking.vehicle!.brand} ${booking.vehicle!.model}",

                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: KColors.darkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                          Text(
                            scheduleDate,

                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  color: KColors.darkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
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
                          "Rs ${booking.totalAmount}",
                          style: Theme.of(context).textTheme.titleSmall!
                              .copyWith(
                                color: KColors.black,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: KSizes.defaultSpace),
              //service provider details
              Container(
                padding: EdgeInsets.all(KSizes.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  color: Colors.transparent,
                  border: Border.all(color: KColors.grey),
                ),
                child: Column(
                  children: [
                    SectionTitle(
                      title: "Service Provider",
                      showButtonTitle: false,
                    ),
                    SizedBox(height: KSizes.md),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: KSizes.md),
                          child: SizedBox(
                            width: 40.w,
                            height: 40.h,
                            child: Image.asset(
                              KImages.userIcon,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.provider!.user!.fullName!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: KColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
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
                                  booking.service!.rating.toString(),
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
                        Spacer(),
                        InkWell(
                          borderRadius: BorderRadius.circular(KSizes.sm),
                          onTap: () async {
                            final Uri url = Uri(
                              scheme: "tel",
                              path: "9821101186",
                            );
                            await launchUrl(url);
                          },
                          child: Container(
                            padding: EdgeInsets.all(KSizes.sm),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(KSizes.sm),
                              color: Colors.transparent,
                              border: Border.all(color: KColors.grey),
                            ),
                            child: Icon(Icons.call_outlined),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: KSizes.defaultSpace),
              //service location details
              Container(
                padding: EdgeInsets.all(KSizes.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  color: Colors.transparent,
                  border: Border.all(color: KColors.grey),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: KColors.darkerGrey,
                        ),
                        SizedBox(width: KSizes.md),
                        SizedBox(
                          width: 170.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Service Location",
                                style: Theme.of(context).textTheme.titleMedium!
                                    .copyWith(
                                      color: KColors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                "${booking.location!.address}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      color: KColors.darkGrey,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: KSizes.md),
                        InkWell(
                          borderRadius: BorderRadius.circular(KSizes.sm),

                          onTap: () async {
                            final latitude = booking.location?.latitude;
                            final longitude = booking.location?.longitude;
                            // final latitude = 27.411831677048884;
                            // final longitude = 85.06748100754166;

                            if (latitude != null && longitude != null) {
                              final url = Uri.parse(
                                "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude",
                              );
                              if (await canLaunchUrl(url)) {
                                await launchUrl(
                                  url,
                                  mode: LaunchMode.externalApplication,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Could not open Google Maps"),
                                  ),
                                );
                              }
                            }
                          },

                          child: Container(
                            padding: EdgeInsets.all(KSizes.sm),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(KSizes.sm),
                              color: Colors.transparent,
                              border: Border.all(color: KColors.grey),
                            ),
                            child: Text(
                              "View Map",

                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: KColors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: KSizes.defaultSpace),
              //cancel button
              InkWell(
                borderRadius: BorderRadius.circular(KSizes.sm),

                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    showDragHandle: false,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    builder: (context) {
                      final TextEditingController reasonController =
                          TextEditingController();

                      return Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 0,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 20,
                            left: 24,
                            right: 24,
                            top: 8,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Handle bar
                              Center(
                                child: Container(
                                  width: 40,
                                  height: 4,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),

                              // Icon and Title
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.red[50],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.red[600],
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Cancel Booking",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Please tell us why you're cancelling",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onSurface
                                                    .withOpacity(0.6),
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Text Field
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.outline.withOpacity(0.2),
                                  ),
                                ),
                                child: TextField(
                                  controller: reasonController,
                                  maxLines: 4,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Enter your reason for cancellation...",
                                    hintStyle: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface.withOpacity(0.5),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.all(16),
                                  ),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline
                                              .withOpacity(0.3),
                                        ),
                                      ),
                                      child: Text(
                                        "Keep Booking",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        final reason =
                                            reasonController.text.trim().isEmpty
                                            ? "Cancelled by user"
                                            : reasonController.text.trim();

                                        // Show loading state
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => const Center(
                                            child: Center(
                                              child: CustomLoading(
                                                color: KColors.primary,
                                              ),
                                            ),
                                          ),
                                        );

                                        final provider =
                                            Provider.of<BookingProvider>(
                                              context,
                                              listen: false,
                                            );

                                        await provider.cancelBooking(
                                          context: context,
                                          bookingId: provider.booking!.id!,
                                          cancelReason: reason,
                                        );

                                        // Close loading dialog
                                        Navigator.of(context).pop();
                                        // Close bottom sheet
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red[600],
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: const Text(
                                        "Cancel Booking",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },

                child: Container(
                  width: KDeviceUtils.getScreenWidth(context),
                  padding: EdgeInsets.all(KSizes.md),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(KSizes.sm),
                    color: Colors.transparent,
                    border: Border.all(color: KColors.grey),
                  ),
                  child: Center(
                    child: Text(
                      "Cancel Service",

                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: KSizes.defaultSpace),
              //return to home button
              InkWell(
                borderRadius: BorderRadius.circular(KSizes.sm),

                onTap: () {
                  context.read<NavigationProvider>().onTap(0);
                  context.goNamed(RoutesConstant.navigationMenu);
                },

                child: Container(
                  width: KDeviceUtils.getScreenWidth(context),
                  padding: EdgeInsets.all(KSizes.md),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(KSizes.sm),
                    color: Colors.transparent,
                    border: Border.all(color: KColors.grey),
                  ),
                  child: Center(
                    child: Text(
                      "Return to home",

                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
