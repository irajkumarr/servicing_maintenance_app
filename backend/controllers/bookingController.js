// POST /api/bookings
// GET /api/bookings
// /api/bookings/user/:userId
// GET /api/bookings/:id
// PUT /api/bookings/:id/cancel
// GET /api/bookings/:id/track

const Booking = require("./../models/Booking");
const Service = require("./../models/Service");
const Vehicle = require("./../models/Vehicle");

const handleGetAllBookings = async (req, res) => {
  try {
    if (req.user.role !== "admin") {
      return res.status(403).json({ status: false, message: "Access denied" });
    }

    const bookings = await Booking.find()
      .populate("user", "fullName email")
      .populate("vehicle")
      .populate("service")
      .populate({
        path: "provider",
        populate: {
          path: "user",
          select: "fullName email phoneNumber",
        },
      });

    res.status(200).json(bookings);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleCreateBooking = async (req, res) => {
  try {
    const { vehicle, service, scheduledAt, location, totalAmount } = req.body;

    const userId = req.user.id;
    if (req.user.role !== "user") {
      return res.status(403).json({ status: false, message: "Access denied" });
    }
    const serviceData = await Service.findById(service);
    if (!serviceData) {
      return res
        .status(404)
        .json({ status: false, message: "Service not found" });
    }

    const vehicleData = await Vehicle.findById(vehicle);
    if (!vehicleData) {
      return res
        .status(404)
        .json({ status: false, message: "Vehicle not found" });
    }

    const booking = new Booking({
      user: userId,
      provider: serviceData.serviceProvider,
      vehicle,
      service,
      scheduledAt,
      location,
      totalAmount,
    });

    await booking.save();
    res.status(201).json({
      status: true,
      message: "Booking Confirmed!",
      bookingId: booking._id,
    });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetUserBookings = async (req, res) => {
  const userId = req.user.id;

  // Only allow self or admin
  if (req.user.id !== userId && req.user.role !== "admin") {
    return res.status(403).json({ status: false, message: "Access denied" });
  }

  try {
    const bookings = await Booking.find(
      { user: userId },
      { __v: 0, updatedAt: 0, createdAt: 0 }
    )
      .populate("vehicle")
      .populate("service")
      .populate({
        path: "provider",
        populate: {
          path: "user",
          select: "fullName email phoneNumber",
        },
      });

    res.status(200).json(bookings);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetBookingById = async (req, res) => {
  const { id } = req.params;

  try {
    // const booking = await Booking.findById(id)
    const booking = await Booking.findById(id, {
      __v: 0,
      updatedAt: 0,
      createdAt: 0,
    })
      // .populate("user", "fullName email")
      .populate("vehicle")
      .populate("service")
      .populate({
        path: "provider",
        populate: {
          path: "user",
          select: "fullName email phoneNumber",
        },
      });

    if (!booking) {
      return res
        .status(404)
        .json({ status: false, message: "Booking not found" });
    }

    // Only user, provider, or admin can see
    const userId = req.user.id;
    if (
      req.user.role !== "admin" &&
      booking.user._id.toString() !== userId &&
      booking.provider?._id.toString() !== userId
    ) {
      return res.status(403).json({ status: false, message: "Access denied" });
    }

    res.status(200).json(booking);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleTrackBooking = async (req, res) => {
  const { id } = req.params;

  try {
    const booking = await Booking.findById(id).select("status location");
    if (!booking) {
      return res
        .status(404)
        .json({ status: false, message: "Booking not found" });
    }

    res.status(200).json(booking);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleCancelBooking = async (req, res) => {
  const { id } = req.params;
  const { cancelReason } = req.body;

  try {
    const booking = await Booking.findById(id);
    if (!booking) {
      return res
        .status(404)
        .json({ status: false, message: "Booking not found" });
    }

    // Only user or admin can cancel
    if (booking.user.toString() !== req.user.id && req.user.role !== "admin") {
      return res.status(403).json({ status: false, message: "Access denied" });
    }

    if (booking.status === "cancelled" || booking.status === "completed") {
      return res
        .status(400)
        .json({ status: false, message: "Cannot cancel this booking" });
    }

    booking.status = "cancelled";
    booking.cancelReason = cancelReason || "Cancelled by user";
    await booking.save();

    res.status(200).json({ status: true, message: "Booking cancelled" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleCreateBooking,
  handleCancelBooking,
  handleGetAllBookings,
  handleGetBookingById,
  handleGetUserBookings,
  handleTrackBooking,
};
