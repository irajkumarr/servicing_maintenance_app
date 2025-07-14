// GET /api/vehicles
// POST /api/vehicles
// PUT /api/vehicles/:id
// DELETE /api/vehicles/:id

const Vehicle = require("./../models/Vehicle");
const cloudinary = require("./../utils/cloudinary");

// GET /api/vehicles
const handleGetAllVehicles = async (req, res) => {
  try {
    const vehicles = await Vehicle.find(
      { owner: req.user.id },
      { __v: 0, updatedAt: 0, createdAt: 0 }
    ).sort({
      isDefault: -1,
    });
    res.status(200).json(vehicles);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

// POST /api/vehicles
const handleCreateVehicle = async (req, res) => {
  try {
    const {
      vehicleType,
      brand,
      model,
      year,
      registrationNumber,
      fuelType,
      color,
      isDefault,
    } = req.body;

    const stream = cloudinary.uploader.upload_stream(
      { folder: "servicing_app_images", resource_type: "image" },
      async (error, result) => {
        if (error) {
          return res.status(500).json({
            status: false,
            message: "Cloudinary upload failed",
            error,
          });
        }

        if (isDefault) {
          // unset others
          await Vehicle.updateMany(
            { owner: req.user.id },
            { isDefault: false }
          );
        }

        const vehicle = new Vehicle({
          owner: req.user.id,
          vehicleType,
          brand,
          model,
          year,
          registrationNumber,
          fuelType,
          color,
          vehiclePhoto: result.secure_url,
          isDefault,
        });

        await vehicle.save();
        res.status(201).json({ status: true, message: "Vehicle added" });
      }
    );
    stream.end(req.file.buffer);
  } catch (error) {
    // console.log(error);
    res.status(500).json({ status: false, message: error.message });
  }
};

// PUT /api/vehicles/:id
const handleUpdateVehicle = async (req, res) => {
  try {
    const vehicleId = req.params.id;

    const updateData = { ...req.body };

    if (req.body.isDefault) {
      await Vehicle.updateMany({ owner: req.user.id }, { isDefault: false });
    }

    const updatedVehicle = await Vehicle.findOneAndUpdate(
      { _id: vehicleId, owner: req.user.id },
      updateData,
      { new: true, runValidators: true }
    );

    if (!updatedVehicle) {
      return res
        .status(404)
        .json({ status: false, message: "Vehicle not found" });
    }

    res.status(200).json({ status: true, message: "Vehicle updated" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

// DELETE /api/vehicles/:id
const handleDeleteVehicle = async (req, res) => {
  try {
    const vehicle = await Vehicle.findOneAndDelete({
      _id: req.params.id,
      owner: req.user.id,
    });

    if (!vehicle) {
      return res
        .status(404)
        .json({ status: false, message: "Vehicle not found" });
    }

    res.status(200).json({ status: true, message: "Vehicle deleted" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleSetDefaultVehicle = async (req, res) => {
  try {
    const userId = req.user.id;
    const vehicleId = req.params.id;

    // Ensure the vehicle exists and belongs to the user
    const vehicle = await Vehicle.findOne({ _id: vehicleId, owner: userId });
    if (!vehicle) {
      return res
        .status(404)
        .json({ status: false, message: "Vehicle not found" });
    }

    // Unset all other vehicles
    await Vehicle.updateMany({ owner: userId }, { isDefault: false });

    // Set selected vehicle as default
    vehicle.isDefault = true;
    await vehicle.save();

    res.status(200).json({
      status: true,
      message: "Default vehicle set successfully",
    });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleCreateVehicle,
  handleGetAllVehicles,
  handleDeleteVehicle,
  handleUpdateVehicle,
  handleSetDefaultVehicle,
};
