const express = require("express");
const router = express.Router();
const {
  handleCreateBooking,
  handleCancelBooking,
  handleGetAllBookings,
  handleGetBookingById,
  handleGetUserBookings,
  handleTrackBooking,
} = require("./../controllers/bookingController");
const { verifyAndAuthorize, verifyAdmin, verifyAndAuthorizeAll } = require("./../middlewares/jwt");

router.post("/", verifyAndAuthorize, handleCreateBooking);
router.get("/", verifyAdmin, handleGetAllBookings);
router.get("/user", verifyAndAuthorize, handleGetUserBookings);
router.get("/:id", verifyAndAuthorize, handleGetBookingById);
router.put("/:id/cancel", verifyAndAuthorize, handleCancelBooking);
router.get("/:id/track", verifyAndAuthorize, handleTrackBooking);

module.exports=router;
