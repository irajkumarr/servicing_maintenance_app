const express = require("express");
const {
  handleRegisterServiceProvider,
  handleGetServiceProvider,
} = require("../controllers/serviceProviderController");
const router = express.Router();

router.post("/register", handleRegisterServiceProvider);
router.get("/", handleGetServiceProvider);

module.exports = router;
