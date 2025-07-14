const express = require("express");
const {
  handleAcceptBooking,
  handleGetProviderBookings,
  handleUpdateBookingStatus,
} = require("../controllers/providerBookingController");

const router = express.Router();

const {
  verifyAndAuthorize,
  verifyAdmin,
  authorizeAnyRole,
  verifyProvider,
} = require("./../middlewares/jwt");
router.put("/:id/accept", verifyProvider, handleAcceptBooking);
router.get("/", verifyProvider, handleGetProviderBookings);
router.put("/:id/status", verifyProvider, handleUpdateBookingStatus);

module.exports = router;
