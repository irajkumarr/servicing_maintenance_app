const express = require("express");
const {
  handleCreateUser,
  handleLoginUser,
  handleVerifyUserOTP,
  handleResendUserOTP,
} = require("../controllers/authController");
const router = express.Router();

const rateLimit = require("express-rate-limit");

const otpRateLimiter = rateLimit({
  windowMs: 10 * 60 * 1000, // 10 minutes
  max: 3, // Limit each IP to 3 requests per windowMs
  message: {
    status: false,
    message: "Too many OTP requests. Try again after 10 minutes.",
  },
});

router.post("/register", handleCreateUser);
router.post("/login", handleLoginUser);
router.post("/verify-otp", handleVerifyUserOTP);
router.post("/resend-otp", otpRateLimiter, handleResendUserOTP);

module.exports = router;
