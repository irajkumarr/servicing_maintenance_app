// GET /api/providers/
// POST /api/providers/register
// PUT /api/providers/status
// GET /api/providers/bookings
// PUT /api/providers/bookings/:id/accept
// PUT /api/providers/bookings/:id/status
const ServiceProvider = require("./../models/ServiceProvider");
const User = require("./../models/User");

const handleGetServiceProvider = async (req, res) => {
  try {
    const providers = await ServiceProvider.find().populate(
      "user",
      "-password -otp -otpExpiry"
    );
    if (providers.length == 0) {
      return res
        .status(404)
        .json({ status: false, message: "Providers not found" });
    }
    res.status(200).json(providers);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleRegisterServiceProvider = async (req, res) => {
  const { fullName, email, phoneNumber, password, experienceYears, address } =
    req.body;

  try {
    const existingEmail = await User.findOne({ email });
    if (existingEmail) {
      return res
        .status(400)
        .json({ status: false, message: "Email already exists" });
    }

    const existingPhone = await User.findOne({ phoneNumber });
    if (existingPhone) {
      return res
        .status(400)
        .json({ status: false, message: "Phone number already exists" });
    }

    // Step 1: Create User with role 'provider'
    const user = new User({
      fullName,
      email,
      phoneNumber,
      password,
      role: "provider",
    });
    await user.save();

    // Step 2: Create linked service provider profile
    const provider = new ServiceProvider({
      user: user._id,
      experienceYears,
      address,
      servicesOffered: [],
    });
    await provider.save();

    res.status(201).json({
      status: true,
      message: "Service provider registered successfully",
    });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};
const handleUpdateProviderStatus = async (req, res) => {
  const providerId = req.user.id; // from token
  const { availabilityStatus } = req.body;

  if (!["online", "offline", "busy"].includes(availabilityStatus)) {
    return res.status(400).json({ status: false, message: "Invalid status" });
  }

  try {
    const updated = await ServiceProvider.findOneAndUpdate(
      { user: providerId },
      { availabilityStatus },
      { new: true }
    );

    if (!updated) {
      return res
        .status(404)
        .json({ status: false, message: "Provider not found" });
    }

    res.status(200).json({ status: true, message: "Status updated" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleGetServiceProvider,
  handleRegisterServiceProvider,
  handleUpdateProviderStatus,
};
