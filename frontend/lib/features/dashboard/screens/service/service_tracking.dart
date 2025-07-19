import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/data/models/booking_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceTrackingScreen extends StatefulWidget {
  final BookingModel booking;

  const ServiceTrackingScreen({super.key, required this.booking});

  @override
  State<ServiceTrackingScreen> createState() => _ServiceTrackingScreenState();
}

class _ServiceTrackingScreenState extends State<ServiceTrackingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _progressController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;

  int currentStep = 0;

  @override
  void initState() {
    super.initState();

    currentStep = _getStepFromStatus(widget.booking.status ?? 'pending');

    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _progressController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _progressController.forward();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  int _getStepFromStatus(String status) {
    switch (status) {
      case 'pending':
        return 0;
      case 'accepted':
        return 1;
      case 'on_the_way':
        return 2;
      case 'in_progress':
        return 3;
      case 'completed':
        return 4;
      case 'cancelled':
        return 5;
      default:
        return 0;
    }
  }

  List<TrackingStep> getTrackingSteps() {
    final providerName = widget.booking.provider?.user?.fullName ?? 'Provider';

    return [
      TrackingStep(
        title: "Booking Confirmed",
        subtitle: "Your service request has been accepted",
        icon: Icons.check_circle_outline,
        time: "—",
      ),
      TrackingStep(
        title: "Provider Assigned",
        subtitle: "$providerName has been assigned to your service",
        icon: Icons.person_outline,
        time: "—",
      ),
      TrackingStep(
        title: "On the Way",
        subtitle: "$providerName is heading to your location",
        icon: Icons.directions_car_outlined,
        time: "—",
      ),
      TrackingStep(
        title: "Service in Progress",
        subtitle: "Your vehicle is being serviced",
        icon: Icons.build_outlined,
        time: "—",
      ),
      TrackingStep(
        title: "Service Completed",
        subtitle: "Service completed successfully",
        icon: Icons.task_alt_outlined,
        time: "—",
      ),
      TrackingStep(
        title: "Service Cancelled",
        subtitle: "Service was cancelled",
        icon: Icons.cancel_outlined,
        time: "—",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final trackingSteps = getTrackingSteps();

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: Icon(Icons.arrow_back_ios, color: KColors.black),
        // ),
        title: Text(
          "Track Service",
          style: TextStyle(
            color: KColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final Uri url = Uri(scheme: "tel", path: "9821101186");
              await launchUrl(url);
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.phone, color: Colors.green[600], size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(KSizes.md),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                "#${widget.booking.id}",
                style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: KSizes.lg),
            _buildServiceInfoCard(),
            SizedBox(height: KSizes.lg),
            _buildLiveStatusCard(trackingSteps),
            SizedBox(height: KSizes.lg),
            _buildProgressTracking(trackingSteps),
            SizedBox(height: KSizes.lg),
            _buildProviderInfoCard(),
            SizedBox(height: KSizes.lg),
            // _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveStatusCard(List<TrackingStep> steps) {
    return Container(
      padding: EdgeInsets.all(KSizes.md),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[600]!, Colors.blue[400]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LIVE TRACKING",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      steps[currentStep].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      steps[currentStep].subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(steps[currentStep].icon, color: Colors.white, size: 32),
            ],
          ),
          if (widget.booking.location?.address != null) ...[
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.white70, size: 18),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    widget.booking.location!.address!,
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
          SizedBox(height: KSizes.md),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  "ETA: 45 minutes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressTracking(List<TrackingStep> steps) {
    return Container(
      padding: EdgeInsets.all(KSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service Progress",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
              color: KColors.black,
            ),
          ),
          SizedBox(height: KSizes.md),
          ...List.generate(steps.length, (index) {
            final step = steps[index];
            final isCompleted = index <= currentStep;
            final isActive = index == currentStep;
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? Colors.blue[600]
                            : Colors.grey[200],
                        shape: BoxShape.circle,
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                              ]
                            : null,
                      ),
                      child: AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: isActive
                                ? _pulseAnimation.value * 0.1 + 0.9
                                : 1.0,
                            child: Icon(
                              step.icon,
                              color: isCompleted
                                  ? Colors.white
                                  : Colors.grey[500],
                              size: 20,
                            ),
                          );
                        },
                      ),
                    ),
                    if (index < steps.length - 1)
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: 2,
                        height: 40,
                        color: isCompleted
                            ? Colors.blue[600]
                            : Colors.grey[200],
                      ),
                  ],
                ),
                SizedBox(width: KSizes.sm),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                step.title,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: isCompleted
                                          ? KColors.black
                                          : Colors.grey[500],
                                    ),
                              ),
                            ),
                            if (isCompleted)
                              Text(
                                step.time,
                                style: Theme.of(context).textTheme.bodySmall!
                                    .copyWith(
                                      color: Colors.blue[600],
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          step.subtitle,
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                color: isCompleted
                                    ? KColors.darkGrey
                                    : Colors.grey[400],
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildServiceInfoCard() {
    final utcDate = DateTime.parse(widget.booking.scheduledAt.toString());
    final localDate = utcDate.toLocal();
    final scheduleDate = DateFormat('MMM dd, yyyy').format(localDate);
    final scheduleTime = DateFormat('h:mm a').format(localDate);

    return Container(
      padding: EdgeInsets.all(KSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Service Image
          Container(
            width: 70.w,
            height: 70.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue[50],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.booking.service?.imageUrl ?? "",
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.car_repair,
                    color: Colors.blue[600],
                    size: 30,
                  );
                },
              ),
            ),
          ),

          SizedBox(width: KSizes.sm),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.booking.service?.title ?? "",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: KColors.black,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  "${widget.booking.vehicle?.brand} ${widget.booking.vehicle?.model}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: KColors.darkGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8),

                Row(
                  children: [
                    Icon(Icons.schedule, size: 16, color: KColors.darkGrey),
                    SizedBox(width: 4),
                    Text(
                      "$scheduleDate • $scheduleTime",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(color: KColors.darkGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "₹${widget.booking.totalAmount}",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.green[600],
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {
              _showCancelDialog();
            },
            icon: Icon(Icons.cancel_outlined),
            label: Text("Cancel Service"),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: BorderSide(color: Colors.red[400]!),
              foregroundColor: Colors.red[600],
            ),
          ),
        ),

        SizedBox(width: KSizes.sm),

        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Handle support
            },
            icon: Icon(Icons.support_agent),
            label: Text("Get Help"),
            style: ElevatedButton.styleFrom(
              backgroundColor: KColors.black,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCancelDialog() {
    showDialog(
      context: context,
      builder: (context) => SizedBox(
        width: KDeviceUtils.getScreenWidth(context),
        child: AlertDialog(
          backgroundColor: KColors.white,
          insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KSizes.xs),
          ),
          title: Text("Cancel Service?"),
          content: Text(
            "Are you sure you want to cancel this service? This action cannot be undone.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Keep Service"),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
                // Handle cancel service
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
              child: Text("Cancel Service"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProviderInfoCard() {
    return Container(
      padding: EdgeInsets.all(KSizes.md),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service Provider",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
              color: KColors.black,
            ),
          ),

          SizedBox(height: KSizes.sm),

          Row(
            children: [
              // Provider Avatar
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[400]!, Colors.blue[600]!],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    widget.booking.provider?.user?.fullName
                            ?.substring(0, 1)
                            .toUpperCase() ??
                        "P",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),

              SizedBox(width: KSizes.sm),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.booking.provider?.user?.fullName ??
                          "Service Provider",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: KColors.black,
                      ),
                    ),

                    SizedBox(height: 4),

                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        SizedBox(width: 4),
                        Text(
                          "${widget.booking.service?.rating} (${widget.booking.service?.reviewCount} reviews)",
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: KColors.darkGrey),
                        ),
                      ],
                    ),

                    SizedBox(height: 4),

                    Text(
                      "${widget.booking.provider?.experienceYears}+ years experience",
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall!.copyWith(color: KColors.darkGrey),
                    ),
                  ],
                ),
              ),

              // Action buttons
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: () async {
                        final Uri url = Uri(scheme: "tel", path: "9821101186");
                        await launchUrl(url);
                      },
                      icon: Icon(Icons.phone, color: Colors.green[600]),
                    ),
                  ),

                  SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TrackingStep {
  final String title;
  final String subtitle;
  final IconData icon;
  final String time;

  TrackingStep({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.time,
  });
}
