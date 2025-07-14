const Booking = require("./../models/Booking");

const handleGetProviderBookings = async (req, res) => {
  try {
    const bookings = await Booking.find({ provider: req.user.id }).populate(
      "user provider service vehicle"
    );
    res.status(200).json(bookings);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleAcceptBooking = async (req, res) => {
  const bookingId = req.params.id;

  try {
    const booking = await Booking.findById(bookingId);
    if (!booking)
      return res
        .status(404)
        .json({ status: false, message: "Booking not found" });

    if (booking.status !== "pending") {
      return res
        .status(400)
        .json({ status: false, message: "Booking already processed" });
    }

    booking.status = "accepted";
    booking.provider = req.user.id;
    await booking.save();

    res.status(200).json({ status: true, message: "Booking accepted" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleUpdateBookingStatus = async (req, res) => {
  const { status } = req.body;
  const bookingId = req.params.id;

  const validStatuses = [
    "accepted",
    "on_the_way",
    "in_progress",
    "completed",
    "cancelled",
  ];
  if (!validStatuses.includes(status)) {
    return res.status(400).json({ status: false, message: "Invalid status" });
  }

  try {
    const booking = await Booking.findById(bookingId);
    if (!booking)
      return res
        .status(404)
        .json({ status: false, message: "Booking not found" });

    if (String(booking.provider) !== req.user.id) {
      return res.status(403).json({
        status: false,
        message: "Not authorized to update this booking",
      });
    }

    booking.status = status;
    await booking.save();

    res.status(200).json({ status: true, message: "Booking status updated" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleAcceptBooking,
  handleGetProviderBookings,
  handleUpdateBookingStatus,
};
