const express = require("express");
const {
  handleRegisterServiceProvider,
  handleGetServiceProvider,
  handleUpdateProviderStatus,
} = require("../controllers/serviceProviderController");
const router = express.Router();

router.post("/register", handleRegisterServiceProvider);
router.get("/", handleGetServiceProvider);
router.put("/status", handleUpdateProviderStatus);

module.exports = router;
