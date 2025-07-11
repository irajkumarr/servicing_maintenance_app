const express = require("express");
const {
  handleRegisterServiceProvider,
  handleGetServiceProvider,
  handleUpdateProviderStatus,
} = require("../controllers/serviceProviderController");
const { verifyProvider, verifyAdmin } = require("../middlewares/jwt");
const router = express.Router();

router.post("/register", handleRegisterServiceProvider);
router.get("/", verifyAdmin, handleGetServiceProvider);
router.put("/status", verifyProvider, handleUpdateProviderStatus);

module.exports = router;
