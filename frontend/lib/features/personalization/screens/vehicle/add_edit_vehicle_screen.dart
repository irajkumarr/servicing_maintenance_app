import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/common/widgets/alert_box/snackbar.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/common/widgets/texts/label_text.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/vehicle_model.dart';
import 'package:frontend/features/dashboard/screens/home/widgets/vehicle_selection_card.dart';
import 'package:frontend/features/personalization/providers/vehicle_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../dashboard/providers/service_provider.dart';

class AddEditVehicleScreen extends StatefulWidget {
  const AddEditVehicleScreen({super.key, this.vehicle});
  final VehicleModel? vehicle;
  @override
  State<AddEditVehicleScreen> createState() => _AddEditVehicleScreenState();
}

class _AddEditVehicleScreenState extends State<AddEditVehicleScreen> {
  // final TextEditingController colorController = TextEditingController();
  final TextEditingController regNoController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.vehicle != null) {
        final vehicleProvider = context.read<VehicleProvider>();
        vehicleProvider.selectVehicleType(
          widget.vehicle!.vehicleType!.capitalize(),
        );
        _selectedBrand = widget.vehicle!.brand ?? "";
        _selectedYear = widget.vehicle!.year.toString();
        _selectedColor = widget.vehicle!.color ?? "";
        _selectedFuelType = widget.vehicle!.fuelType!.capitalize();
        regNoController.text = widget.vehicle!.registrationNumber ?? "";
        modelController.text = widget.vehicle!.model ?? "";
      }
    });
  }

  String? _selectedBrand;
  String? _selectedYear;
  String? _selectedColor;
  String? _selectedFuelType;

  final List<String> carBrands = [
    "Honda",
    "Maruti Suzuki",
    "Hyundai",
    "Tata",
    "Mahindra",
    "Toyota",
    "Ford",
    "Volkswagen",
  ];
  final List<String> bikeBrands = [
    "Royal Enfield",
    "Hero",
    "Honda",
    "Bajaj",
    "TVS",
    "Yamaha",
    "KTM",
    "Suzuki",
  ];
  final List<String> colors = [
    "White",
    "Black",
    "Blue",
    "Yellow",
    "Silver",
    "Red",
    "Grey",
    "Brown",
  ];

  final List<String> years = List.generate(
    25,
    (index) => (DateTime.now().year - index).toString(),
  );
  final List<String> fuelTypes = ['Petrol', 'Diesel', 'Electric', 'Cng'];

  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.camera) {
        var status = await Permission.camera.status;
        if (!status.isGranted) {
          status = await Permission.camera.request();
          if (!status.isGranted) {
            KSnackbar.CustomSnackbar(
              context,
              "Camera permission denied",
              KColors.error,
            );
            return;
          }
        }
      }
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
        setState(() {});
        // if (mounted) context.pop();
      }
    } catch (e) {
      KSnackbar.CustomSnackbar(context, "Failed to pick image", KColors.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final List<String> brands = _vehicleType == 'Car' ? carBrands : bikeBrands;
    final vehicleProvider = context.watch<VehicleProvider>();
    final vehicleType = vehicleProvider.vehicleType;
    final brandList = vehicleType == "Car" ? carBrands : bikeBrands;

    final serviceProvider = context.watch<ServiceProvider>();

    return FullScreenOverlay(
      isLoading: vehicleProvider.isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.vehicle != null ? "Edit Vehicle" : "Add Vehicle",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${widget.vehicle != null ? "Edit" : "Add"} your vehicle details",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: KColors.darkGrey,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(KSizes.md),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(KSizes.sm),
                  border: Border.all(color: KColors.grey),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Vehicle Type
                      LabelText(title: "Vehicle Type"),
                      Row(
                        children: [
                          Expanded(
                            child: VehicleSelectionCard(
                              title: "Car",
                              icon: AntDesign.car_outline,
                              onTap: () {
                                vehicleProvider.selectVehicleType("Car");
                              },
                            ),
                          ),
                          SizedBox(width: KSizes.sm),
                          Expanded(
                            child: VehicleSelectionCard(
                              title: "Bike",
                              icon: Icons.motorcycle_outlined,
                              onTap: () {
                                vehicleProvider.selectVehicleType("Bike");
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: KSizes.md),

                      /// Brand
                      // if (_vehicleType != null) ...[
                      LabelText(title: "Brand"),
                      DropdownButtonFormField<String>(
                        value: _selectedBrand,
                        dropdownColor: KColors.white,
                        items: brandList
                            .map(
                              (brand) => DropdownMenuItem(
                                value: brand,
                                child: Text(brand),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedBrand = value),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Select brand",
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a brand' : null,
                      ),
                      SizedBox(height: KSizes.md),
                      // ],

                      /// Model
                      LabelText(title: "Model"),
                      TextFormField(
                        controller: modelController,
                        decoration: const InputDecoration(
                          hintText: "Enter model name",
                        ),
                        validator: (value) =>
                            KValidator.validateEmptyText("Model", value),
                      ),
                      SizedBox(height: KSizes.md),

                      /// Year
                      LabelText(title: "Year"),
                      DropdownButtonFormField<String>(
                        value: _selectedYear,

                        dropdownColor: KColors.white,
                        items: years
                            .map(
                              (year) => DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedYear = value),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Select year",
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a year' : null,
                      ),
                      SizedBox(height: KSizes.md),

                      /// Registration Number
                      LabelText(title: "Registration Number"),
                      TextFormField(
                        controller: regNoController,
                        decoration: const InputDecoration(
                          hintText: "E.G. MH 01 AB 1234",
                        ),
                        validator: (value) => KValidator.validateEmptyText(
                          "Registration number",
                          value,
                        ),
                      ),
                      SizedBox(height: KSizes.md),

                      /// Color
                      LabelText(title: "Color"),
                      DropdownButtonFormField<String>(
                        value: _selectedColor,

                        dropdownColor: KColors.white,
                        items: colors
                            .map(
                              (color) => DropdownMenuItem(
                                value: color,
                                child: Text(color),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedColor = value),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Select color",
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a color' : null,
                      ),
                      SizedBox(height: KSizes.md),

                      /// Fuel Type
                      LabelText(title: "Fuel Type"),
                      DropdownButtonFormField<String>(
                        value: _selectedFuelType,
                        dropdownColor: KColors.white,
                        items: fuelTypes
                            .map(
                              (fuel) => DropdownMenuItem(
                                value: fuel,
                                child: Text(fuel),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedFuelType = value),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Select fuel type",
                        ),
                        validator: (value) =>
                            value == null ? 'Please select a fuel type' : null,
                      ),
                      SizedBox(height: KSizes.md),

                      /// Vehicle Photo (optional)
                      widget.vehicle != null
                          ? SizedBox()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LabelText(title: "Vehicle Photo (Optional)"),
                                GestureDetector(
                                  onTap: () async {
                                    await _pickImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: KColors.grey),
                                      borderRadius: BorderRadius.circular(
                                        KSizes.sm,
                                      ),
                                      color: KColors.light,
                                    ),
                                    child: _selectedImage != null
                                        ? Image.file(_selectedImage!)
                                        : Center(
                                            child: Icon(
                                              Icons.add_a_photo,
                                              size: 40,
                                              color: KColors.grey,
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
              SizedBox(height: KSizes.defaultSpace),
              CustomButton(
                text: widget.vehicle != null ? "Edit Vehicle" : "Add Vehicle",
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    if (widget.vehicle == null) {
                      final isSuccess = await vehicleProvider.addVehicle(
                        brand: _selectedBrand!,
                        model: modelController.text,
                        year: _selectedYear!,
                        registrationNumber: regNoController.text,
                        fuelType: _selectedFuelType!.toLowerCase(),
                        color: _selectedColor!,
                        isDefault: true,
                        imageFile: _selectedImage,
                      );

                      if (isSuccess) {
                        context.pop();
                        KSnackbar.CustomSnackbar(
                          context,
                          "Vehicle Added",
                          KColors.primary,
                        );
                      } else {
                        KSnackbar.CustomSnackbar(
                          context,
                          vehicleProvider.error?.message ??
                              "Something went wrong",
                          KColors.error,
                        );
                      }
                    } else {
                      final model = {
                        "brand": _selectedBrand!,
                        "model": modelController.text,
                        "year": _selectedYear!,
                        "registrationNumber": regNoController.text,
                        "fuelType": _selectedFuelType!.toLowerCase(),
                        "color": _selectedColor!,
                      };
                      String data = jsonEncode(model);
                      vehicleProvider.updateVehicle(
                        context,
                        widget.vehicle!.id!,
                        data,
                        () async {
                          await vehicleProvider.fetchUserVehicles();
                          context.pop();
                        },
                      );
                    }
                    ;
                  }
                },
                color: KColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
