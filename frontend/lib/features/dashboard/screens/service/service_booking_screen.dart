import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/utils/circular_progress_indicator/custom_loading.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/shimmers/foodlist_shimmer.dart';
import 'package:frontend/core/utils/shimmers/job_detail_shimmer.dart';
import 'package:frontend/data/models/service_booking_model.dart';
import 'package:frontend/features/dashboard/providers/address_provider.dart';
import 'package:frontend/features/dashboard/providers/booking_provider.dart';
import 'package:frontend/features/dashboard/providers/service_provider.dart';
import 'package:frontend/features/dashboard/providers/vehicle_provider.dart';
import 'package:provider/provider.dart';
import 'package:frontend/data/models/vehicle_model.dart';

class ServiceBookingScreen extends StatefulWidget {
  const ServiceBookingScreen({super.key, required this.serviceId});
  final String serviceId;
  @override
  _ServiceBookingScreenState createState() => _ServiceBookingScreenState();
}

class _ServiceBookingScreenState extends State<ServiceBookingScreen> {
  int? selectedVehicleIndex;
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  VehicleModel? selectedVehicle;

  final List<String> timeSlots = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
    '6:00 PM',
    '7:00 PM',
    '8:00 PM',
  ];

  List<String> getAvailableDates() {
    List<String> dates = [];
    DateTime now = DateTime.now();

    for (int i = 0; i < 7; i++) {
      DateTime date = now.add(Duration(days: i));
      if (i == 0) {
        dates.add('Today');
      } else if (i == 1) {
        dates.add('Tomorrow');
      } else {
        dates.add('${date.day} ${_getMonthName(date.month)}');
      }
    }
    return dates;
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  List<String> getAvailableTimeSlots() {
    if (selectedDateIndex == 0) {
      // For today, filter out past times
      DateTime now = DateTime.now();
      int currentHour = now.hour;

      return timeSlots.where((time) {
        int timeHour = _parseTimeToHour(time);
        return timeHour > currentHour;
      }).toList();
    } else {
      // For other days, show all times
      return timeSlots;
    }
  }

  int _parseTimeToHour(String time) {
    String hourStr = time.split(':')[0];
    int hour = int.parse(hourStr);

    if (time.contains('PM') && hour != 12) {
      hour += 12;
    } else if (time.contains('AM') && hour == 12) {
      hour = 0;
    }

    return hour;
  }

  DateTime _parseTimeToDateTime(String time) {
    String hourStr = time.split(':')[0];
    String minuteStr = time.split(':')[1].substring(0, 2);

    int hour = int.parse(hourStr);
    int minute = int.parse(minuteStr);

    if (time.contains('PM') && hour != 12) {
      hour += 12;
    } else if (time.contains('AM') && hour == 12) {
      hour = 0;
    }

    return DateTime(1, 1, 1, hour, minute); // Just for time extraction
  }

  DateTime getScheduledDateTime() {
    DateTime now = DateTime.now();
    DateTime selectedDate;

    // Get the selected date
    if (selectedDateIndex == 0) {
      selectedDate = now; // Today
    } else if (selectedDateIndex == 1) {
      selectedDate = now.add(Duration(days: 1)); // Tomorrow
    } else {
      selectedDate = now.add(Duration(days: selectedDateIndex)); // Future dates
    }

    // Get the selected time
    String selectedTime = getAvailableTimeSlots()[selectedTimeIndex];
    DateTime timeOnly = _parseTimeToDateTime(selectedTime);

    // Combine date and time
    DateTime scheduledDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      timeOnly.hour,
      timeOnly.minute,
    );

    return scheduledDateTime;
  }

  @override
  void initState() {
    super.initState();
    // Fetch vehicles when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<VehicleProvider>(context, listen: false).fetchUserVehicles();
      Provider.of<AddressProvider>(
        context,
        listen: false,
      ).fetchUserDefaultAddress();
      Provider.of<ServiceProvider>(
        context,
        listen: false,
      ).fetchServiceById(widget.serviceId);
    });
  }

  String getVehicleIcon(String vehicleType) {
    switch (vehicleType.toLowerCase()) {
      case 'car':
        return '🚗';

      case 'bike':
        return '🏍️';

      default:
        return '🚗';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> availableDates = getAvailableDates();
    List<String> availableTimeSlots = getAvailableTimeSlots();
    final serviceProvider = context.watch<ServiceProvider>();
    final vehicleProvider = context.watch<VehicleProvider>();
    final addressProvider = context.watch<AddressProvider>();
    final address = addressProvider.defaultAddress;
    final service = serviceProvider.service;
    void _showErrorDialog(String message) {
      showDialog(
        context: context,

        barrierDismissible: false,
        builder: (context) => SizedBox(
          width: KDeviceUtils.getScreenWidth(context),
          child: AlertDialog(
            backgroundColor: KColors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(KSizes.xs),
            ),
            title: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 8),
                Text('Booking Error'),
              ],
            ),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
              ),
            ],
          ),
        ),
      );
    }

    bool _validateBookingData() {
      if (selectedVehicle == null) {
        _showErrorDialog('Please select a vehicle');
        return false;
      }
      if (address == null ||
          address.fullAddress == null ||
          address.fullAddress!.isEmpty) {
        _showErrorDialog('Please add or select a service location');
        return false;
      }

      if (availableTimeSlots.isEmpty) {
        _showErrorDialog('No time slots available for the selected date');
        return false;
      }

      return true;
    }

    if (serviceProvider.isLoading ||
        vehicleProvider.isLoading ||
        addressProvider.isLoading) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(KDeviceUtils.getAppBarHeight()),
          child: Material(
            elevation: 0.2,
            child: AppBar(
              title: Text(
                'Book Service',
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
    if (service == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No service data found.",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ),
      );
    }
    return FullScreenOverlay(
      isLoading: context.watch<BookingProvider>().isLoading,
      child: Scaffold(
        backgroundColor: Colors.grey[50],

        appBar: AppBar(
          title: Text(
            "Book Service",
            style: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service Card
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
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
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text(
                                //  service.title??"",
                                //   style: TextStyle(
                                //     fontSize: 18,
                                //     fontWeight: FontWeight.w600,
                                //   ),
                                // ),
                                // Text(
                                //   'Complete exterior and interior cleaning',
                                //   style: TextStyle(
                                //     color: Colors.grey[600],
                                //     fontSize: 14,
                                //   ),
                                // ),
                                Text(
                                  service.title ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyLarge!
                                      .copyWith(
                                        color: KColors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                Text(
                                  service.description ?? "",

                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelLarge!
                                      .copyWith(
                                        color: KColors.darkGrey,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: KSizes.sm),
                          Text(
                            "Rs ${service.basePrice}",
                            style: Theme.of(context).textTheme.titleSmall!
                                .copyWith(
                                  color: KColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24),

                    // Select Vehicle
                    Text(
                      'Select Vehicle',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),

                    Consumer<VehicleProvider>(
                      builder: (context, vehicleProvider, child) {
                        if (vehicleProvider.error != null) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  color: Colors.red[700],
                                  size: 32,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Failed to load vehicles',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  vehicleProvider.error!.message,
                                  style: TextStyle(
                                    color: Colors.red[600],
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: () =>
                                      vehicleProvider.fetchUserVehicles(),
                                  child: Text('Retry'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[700],
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        if (vehicleProvider.vehicles.isEmpty) {
                          return Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.directions_car,
                                  color: Colors.grey[600],
                                  size: 32,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'No vehicles found',
                                  style: TextStyle(
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Please add a vehicle to your account first.',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(height: 8),
                                CustomButton(
                                  text: "Add Vehicle",
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          );
                        }

                        return Column(
                          children: vehicleProvider.vehicles.asMap().entries.map((
                            entry,
                          ) {
                            int index = entry.key;
                            VehicleModel vehicle = entry.value;

                            return Container(
                              margin: EdgeInsets.only(bottom: 8),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    selectedVehicleIndex = index;
                                    selectedVehicle = vehicle;
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: selectedVehicleIndex == index
                                          ? KColors.primary
                                          : KColors.grey,
                                      width: selectedVehicleIndex == index
                                          ? 1.5
                                          : 1,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        getVehicleIcon(
                                          vehicle.vehicleType ?? 'car',
                                        ),
                                        style: TextStyle(fontSize: 24),
                                      ),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${vehicle.brand} ${vehicle.model}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              vehicle.registrationNumber ??
                                                  'No number',
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (vehicle.year != null)
                                        Text(
                                          vehicle.year.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),

                    SizedBox(height: 24),

                    // Select Date & Time
                    Text(
                      'Select Date & Time',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),

                    // Date Selection
                    Container(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: availableDates.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 8),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: () {
                                setState(() {
                                  selectedDateIndex = index;
                                  selectedTimeIndex = 0; // Reset time selection
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedDateIndex == index
                                      ? KColors.primary
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: selectedDateIndex == index
                                        ? KColors.primary
                                        : Colors.grey[300]!,
                                  ),
                                ),
                                child: Text(
                                  availableDates[index],
                                  style: TextStyle(
                                    color: selectedDateIndex == index
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 16),

                    // Time Selection
                    if (availableTimeSlots.isNotEmpty)
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: availableTimeSlots.asMap().entries.map((
                          entry,
                        ) {
                          int index = entry.key;
                          String time = entry.value;

                          return InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              setState(() {
                                selectedTimeIndex = index;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              decoration: BoxDecoration(
                                color: selectedTimeIndex == index
                                    ? KColors.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: selectedTimeIndex == index
                                      ? KColors.primary
                                      : Colors.grey[300]!,
                                ),
                              ),
                              child: Text(
                                time,
                                style: TextStyle(
                                  color: selectedTimeIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                    if (availableTimeSlots.isEmpty)
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'No more time slots available for today. Please select tomorrow or another day.',
                          style: TextStyle(
                            color: Colors.orange[800],
                            fontSize: 14,
                          ),
                        ),
                      ),

                    SizedBox(height: 24),

                    // // Service Location
                    // Text(
                    //   'Service Location',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // SizedBox(height: 12),

                    // Container(
                    //   padding: EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(12),
                    //     border: Border.all(color: Colors.grey[300]!),
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       Icon(Icons.location_on, color: Colors.grey[600]),
                    //       SizedBox(width: 12),
                    //       Expanded(
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Text(
                    //               address?.label ?? "",
                    //               style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.w600,
                    //               ),
                    //             ),
                    //             Text(
                    //               address?.fullAddress ?? "",
                    //               style: TextStyle(
                    //                 color: Colors.grey[600],
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       TextButton(
                    //         onPressed: () {},
                    //         child: Text(
                    //           'Change',
                    //           style: TextStyle(
                    //             color: KColors.primary,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Service Location
                    Text(
                      'Service Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 12),

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              address == null ||
                                  address.fullAddress == null ||
                                  address.fullAddress!.isEmpty
                              ? Colors.red[300]!
                              : Colors.grey[300]!,
                          width:
                              address == null ||
                                  address.fullAddress == null ||
                                  address.fullAddress!.isEmpty
                              ? 2
                              : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color:
                                address == null ||
                                    address.fullAddress == null ||
                                    address.fullAddress!.isEmpty
                                ? Colors.red[600]
                                : Colors.grey[600],
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  address?.fullAddress != null &&
                                          address!.fullAddress!.isNotEmpty
                                      ? address.label ?? ""
                                      : 'Add Service Location',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        address == null ||
                                            address.fullAddress == null ||
                                            address.fullAddress!.isEmpty
                                        ? Colors.red[700]
                                        : Colors.black,
                                  ),
                                ),
                                Text(
                                  address?.fullAddress != null &&
                                          address!.fullAddress!.isNotEmpty
                                      ? address.fullAddress!
                                      : 'Please select your service location',
                                  style: TextStyle(
                                    color:
                                        address == null ||
                                            address.fullAddress == null ||
                                            address.fullAddress!.isEmpty
                                        ? Colors.red[600]
                                        : Colors.grey[600],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to location selection screen
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => LocationSelectionScreen()));
                            },
                            child: Text(
                              address?.fullAddress != null &&
                                      address!.fullAddress!.isNotEmpty
                                  ? 'Change'
                                  : 'Add',
                              style: TextStyle(
                                color: KColors.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 100), // Space for bottom sheet
                  ],
                ),
              ),
            ),

            // Bottom Price Summary
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Service Charge', style: TextStyle(fontSize: 16)),
                      Text(
                        service.basePrice.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text('Taxes & Fees', style: TextStyle(fontSize: 16)),
                  //     Text('₹54', style: TextStyle(fontSize: 16)),
                  //   ],
                  // ),
                  Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Rs ${service.basePrice.toString()}",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    text: "Confirm Booking",
                    onPressed: availableTimeSlots.isNotEmpty
                        ? () async {
                            // Validate booking data
                            if (!_validateBookingData()) {
                              return;
                            }
                            // Handle booking
                            DateTime scheduledDateTime = getScheduledDateTime();
                            ServiceBookingModel model = ServiceBookingModel(
                              vehicle: selectedVehicle!.id,
                              service: service.id,
                              totalAmount: service.basePrice,
                              location: Location(
                                latitude: address?.location?.latitude,
                                longitude: address?.location?.longitude,
                                address: address?.fullAddress,
                              ),
                              scheduledAt: scheduledDateTime,
                            );
                            String data = serviceBookingModelToJson(model);
                            final bookingProvider = context
                                .read<BookingProvider>();
                            await bookingProvider.bookService(context, data);
                            // print(scheduledDateTime);
                          }
                        : null,
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     onPressed: availableTimeSlots.isNotEmpty
                  //         ? () async {
                  //             // Validate booking data
                  //             if (!_validateBookingData()) {
                  //               return;
                  //             }
                  //             // Handle booking
                  //             DateTime scheduledDateTime =
                  //                 getScheduledDateTime();
                  //             ServiceBookingModel model = ServiceBookingModel(
                  //               vehicle: selectedVehicle!.id,
                  //               service: service.id,
                  //               totalAmount: service.basePrice,
                  //               location: Location(
                  //                 latitude: address?.location?.latitude,
                  //                 longitude: address?.location?.longitude,
                  //                 address: address?.fullAddress,
                  //               ),
                  //               scheduledAt: scheduledDateTime,
                  //             );
                  //             String data = serviceBookingModelToJson(model);
                  //             final bookingProvider = context
                  //                 .read<BookingProvider>();
                  //             await bookingProvider.bookService(context, data);
                  //             // print(scheduledDateTime);
                  //           }
                  //         : null,
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: Colors.blue,
                  //       padding: EdgeInsets.symmetric(vertical: 16),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //     ),
                  //     child: Text(
                  //       'Book Now',
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w600,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
