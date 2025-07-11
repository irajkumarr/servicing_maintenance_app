const express = require("express");
const { 
  handleAcceptBooking,
  handleGetProviderBookings,
  handleUpdateBookingStatus, } = require("../controllers/providerBookingController");

const router = express.Router();

router.put("/:id/accept", handleAcceptBooking);
router.get("/", handleGetProviderBookings);
router.put("/:id/status", handleUpdateBookingStatus);

module.exports = router;
