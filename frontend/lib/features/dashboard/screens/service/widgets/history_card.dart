// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:frontend/core/utils/constants/colors.dart';
// import 'package:frontend/core/utils/constants/sizes.dart';
// import 'package:frontend/core/utils/device/device_utility.dart';
// import 'package:frontend/data/models/booking_model.dart';
// import 'package:intl/intl.dart';

// class HistoryCard extends StatelessWidget {
//   const HistoryCard({super.key, required this.booking});
//   final BookingModel booking;
//   @override
//   Widget build(BuildContext context) {
//     final utcDate = DateTime.parse(booking.scheduledAt.toString());
//     final localDate = utcDate.toLocal();

//     // print(DateFormat('yyyy-MM-dd hh:mm a').format(localDate));
//     final scheduleDate = DateFormat('yyyy-MM-dd hh:mm a').format(localDate);
//     return Container(
//       padding: EdgeInsets.all(KSizes.md),
//       margin: EdgeInsets.only(bottom: KSizes.md),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(KSizes.sm),
//         color: Colors.transparent,
//         border: Border.all(color: KColors.grey),
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     width: 55.w,
//                     height: 55.h,
//                     padding: EdgeInsets.all(KSizes.sm),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(KSizes.sm),
//                       color: KColors.grey,
//                     ),
//                     child: Image.network(
//                       booking.service!.imageUrl ?? "",
//                       fit: BoxFit.contain,
//                     ),
//                   ),

//                   SizedBox(width: KSizes.xs),
//                   SizedBox(
//                     width: 170.w,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       spacing: KSizes.xs,
//                       children: [
//                         Text(
//                           booking.service!.title ?? "",
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.bodyLarge!
//                               .copyWith(
//                                 color: KColors.black,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                         ),
//                         Text(
//                           "${booking.vehicle!.brand} ${booking.vehicle!.model}",

//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.bodyLarge!
//                               .copyWith(
//                                 color: KColors.darkGrey,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                         ),
//                         Text(
//                           scheduleDate,

//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                           style: Theme.of(context).textTheme.bodyLarge!
//                               .copyWith(
//                                 color: KColors.darkGrey,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(width: KSizes.xs),
//                   Column(
//                     spacing: KSizes.sm,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Text(
//                         "Rs ${booking.totalAmount}",
//                         style: Theme.of(context).textTheme.titleSmall!.copyWith(
//                           color: KColors.black,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           SizedBox(height: KSizes.md),
//           Row(
//             spacing: KSizes.md,
//             children: [
//               Expanded(
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(KSizes.sm),

//                   onTap: () {},

//                   child: Container(
//                     // width: KDeviceUtils.getScreenWidth(context),
//                     padding: EdgeInsets.all(KSizes.md),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(KSizes.sm),
//                       color: Colors.transparent,
//                       border: Border.all(color: KColors.grey),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "View Details",

//                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           color: KColors.black,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: InkWell(
//                   borderRadius: BorderRadius.circular(KSizes.sm),

//                   onTap: () {},

//                   child: Container(
//                     // width: KDeviceUtils.getScreenWidth(context),
//                     padding: EdgeInsets.all(KSizes.md),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(KSizes.sm),
//                       color: KColors.black,
//                       border: Border.all(color: KColors.black),
//                     ),
//                     child: Center(
//                       child: Text(
//                         "Track Service",

//                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                           color: KColors.white,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/booking_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.booking});
  final BookingModel booking;

  @override
  Widget build(BuildContext context) {
    final utcDate = DateTime.parse(booking.scheduledAt.toString());
    final localDate = utcDate.toLocal();
    final scheduleDate = DateFormat('yyyy-MM-dd').format(localDate);
    final scheduleTime = DateFormat('h:mm a').format(localDate);

    return Container(
      margin: EdgeInsets.only(bottom: KSizes.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: KColors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          // Header with service info
          Padding(
            padding: EdgeInsets.all(KSizes.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Service image
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: KColors.grey.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      booking.service!.imageUrl ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.car_repair,
                          color: KColors.darkGrey,
                          size: 30,
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(width: KSizes.sm),

                // Service details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Service name and status
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              booking.service!.title ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    color: KColors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          _buildStatusChip(booking.status ?? 'pending'),
                        ],
                      ),

                      SizedBox(height: KSizes.xs),

                      // Provider name
                      if (booking.provider?.user?.fullName != null)
                        Text(
                          "Provider: ${booking.provider!.user?.fullName}",
                          style: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                color: KColors.darkGrey,
                                fontWeight: FontWeight.w500,
                              ),
                        ),

                      SizedBox(height: KSizes.xs / 2),

                      // Vehicle info
                      Row(
                        children: [
                          Icon(
                            Icons.directions_car,
                            size: 16,
                            color: KColors.darkGrey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "${booking.vehicle!.brand} ${booking.vehicle!.model}",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: KColors.darkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),

                      SizedBox(height: KSizes.xs / 2),

                      // Date and time
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: KColors.darkGrey,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "$scheduleDate  $scheduleTime",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(
                                  color: KColors.darkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
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
                      "₹${booking.totalAmount}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.green[600],
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (booking.service?.rating != null &&
                        booking.service!.rating! > 0)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 16),
                          SizedBox(width: 2),
                          Text(
                            "${booking.service?.rating}",
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(
                                  color: KColors.darkGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),

          // Divider
          Divider(height: 1, color: KColors.grey.withOpacity(0.2)),

          // Action buttons
          Padding(
            padding: EdgeInsets.all(KSizes.md),
            child: Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.visibility_outlined,
                    label: "View Details",
                    onTap: () => _showDetailsModal(context),
                    isPrimary: false,
                  ),
                ),
                SizedBox(width: KSizes.sm),
                Expanded(
                  child: _buildActionButton(
                    context,
                    icon: Icons.track_changes_outlined,
                    label: "Track Service",
                    onTap: () {
                      // Handle track service
                      context.pushNamed(RoutesConstant.track, extra: booking);
                    },
                    isPrimary: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color backgroundColor;
    Color textColor;
    String displayStatus;

    switch (status.toLowerCase()) {
      case 'completed':
        backgroundColor = Colors.green[50]!;
        textColor = Colors.green[700]!;
        displayStatus = 'Completed';
        break;
      case 'pending':
        backgroundColor = Colors.orange[50]!;
        textColor = Colors.orange[700]!;
        displayStatus = 'Pending';
        break;
      case 'in_progress':
      case 'ongoing':
        backgroundColor = Colors.blue[50]!;
        textColor = Colors.blue[700]!;
        displayStatus = 'In Progress';
        break;
      case 'cancelled':
        backgroundColor = Colors.red[50]!;
        textColor = Colors.red[700]!;
        displayStatus = 'Cancelled';
        break;
      default:
        backgroundColor = Colors.grey[50]!;
        textColor = Colors.grey[700]!;
        displayStatus = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayStatus,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isPrimary ? KColors.black : Colors.transparent,
          border: Border.all(
            color: isPrimary ? KColors.black : KColors.grey.withOpacity(0.3),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isPrimary ? KColors.white : KColors.black,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: isPrimary ? KColors.white : KColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDetailsModal(BuildContext context) {
    final utcDate = DateTime.parse(booking.scheduledAt.toString());
    final localDate = utcDate.toLocal();
    final scheduleDate = DateFormat('yyyy-MM-dd').format(localDate);
    final scheduleTime = DateFormat('h:mm a').format(localDate);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: DraggableScrollableSheet(
          initialChildSize: 0.9,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          expand: false,
          builder: (context, scrollController) => SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handle bar
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.service!.title ?? "",
                              style: Theme.of(context).textTheme.headlineSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: KColors.black,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Provider: ${booking.provider?.user?.fullName ?? 'N/A'}",
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .copyWith(
                                    color: KColors.darkGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      _buildStatusChip(booking.status ?? 'pending'),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Price and rating
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 16,
                        color: KColors.darkGrey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "$scheduleDate",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: KColors.darkGrey,
                        ),
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: KColors.darkGrey,
                      ),
                      SizedBox(width: 4),
                      Text(
                        scheduleTime,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: KColors.darkGrey,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Price section
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green[200]!),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Rs ${booking.totalAmount}",
                          style: Theme.of(context).textTheme.headlineMedium!
                              .copyWith(
                                color: Colors.green[700],
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Details sections
                  _buildDetailSection(
                    context,
                    title: "Service Details",
                    children: [
                      _buildDetailRow(
                        context,
                        "Booking ID",
                        "#${booking.id ?? 'N/A'}",
                      ),
                      _buildDetailRow(
                        context,
                        "Vehicle Type",
                        booking.vehicle?.vehicleType ?? 'Car',
                      ),
                      _buildDetailRow(
                        context,
                        "Duration",
                        booking.service?.estimatedTime ?? '45 mins',
                      ),
                      _buildDetailRow(
                        context,
                        "Payment",
                        booking.paymentStatus ?? 'Online',
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  if (booking.location != null)
                    _buildDetailSection(
                      context,
                      title: "Service Location",
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: KColors.darkGrey,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                booking.location?.address ?? "",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  const SizedBox(height: 24),

                  // Rating section
                  if (booking.status?.toLowerCase() == 'completed')
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.amber[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rate this service:",
                            style: Theme.of(context).textTheme.titleMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  // Handle rating
                                },
                                child: Icon(
                                  index < (booking.service?.rating ?? 0)
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 32,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),

                  const SizedBox(height: 24),

                  // Action buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            context.pop();
                            final pdfData = await generateInvoicePdf(booking);
                            await Printing.layoutPdf(
                              onLayout: (PdfPageFormat format) async => pdfData,
                            );
                          },
                          icon: Icon(Icons.download),
                          label: Text("Invoice"),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: KColors.black,
            ),
          ),
          const SizedBox(height: 12),
          ...children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            "$label:",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: KColors.darkGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: KColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Future<Uint8List> generateInvoicePdf(BookingModel booking) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Padding(
          padding: pw.EdgeInsets.all(24),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "INVOICE",
                style: pw.TextStyle(
                  fontSize: 22,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 16),
              pw.Text(
                "ServiceOnWheels",
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 16),
              pw.Text("Invoice ID: ${booking.id}"),
              pw.Text("Customer: ${booking.user}"),
              pw.Text("Service: ${booking.service?.title}"),
              pw.Text("Status: ${booking.status}"),
              pw.SizedBox(height: 24),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "Total",
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.Text(
                    "Rs. ${booking.totalAmount?.toStringAsFixed(2)}",
                    style: pw.TextStyle(fontSize: 18),
                  ),
                ],
              ),
              pw.SizedBox(height: 24),
              pw.Text(
                "Thank you for choosing our service!",
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );

    return pdf.save();
  }
}
