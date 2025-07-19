import 'package:flutter/material.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/data/models/booking_model.dart' as bookingModel;
import 'package:frontend/features/dashboard/providers/booking_provider.dart';
import 'package:frontend/features/dashboard/screens/service/widgets/history_card.dart';
import 'package:provider/provider.dart';

class ServiceHistoryScreen extends StatefulWidget {
  const ServiceHistoryScreen({super.key});

  @override
  State<ServiceHistoryScreen> createState() => _ServiceHistoryScreenState();
}

class _ServiceHistoryScreenState extends State<ServiceHistoryScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).fetchUserBookings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Service History",
          style: Theme.of(
            context,
          ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: bookingProvider.isLoading
          ? Center(child: CustomLoading(color: KColors.primary))
          : bookingProvider.error != null
          ? Center(
              child: Text('Error: ${bookingProvider.error?.message ?? ""}'),
            )
          : bookingProvider.bookings.isEmpty
          ? Center(child: Text('No Bookings Yet'))
          : ListView.builder(
              padding: EdgeInsets.all(KSizes.md),
              itemCount: bookingProvider.bookings.length,
              itemBuilder: (context, index) {
                bookingModel.BookingModel booking =
                    bookingProvider.bookings[index];
                return HistoryCard(booking: booking);
              },
            ),
    );
  }
}
