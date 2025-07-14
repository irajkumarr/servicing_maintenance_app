const express = require("express");
const router = express.Router();
const {
  handleGetUserAddresses,
  handleAddUserAddress,
  handleUpdateAddress,
  handleDeleteAddress,
  handleSetDefaultAddress,
  handleGetDefaultAddress,
} = require("./../controllers/addressController");
const {
  verifyAndAuthorize,
  verifyAdmin,
  authorizeAnyRole,
} = require("./../middlewares/jwt");

router.post("/", verifyAndAuthorize, handleAddUserAddress);
router.get("/", verifyAndAuthorize, handleGetUserAddresses);
router.get("/default", verifyAndAuthorize, handleGetDefaultAddress);
router.delete("/:id", verifyAndAuthorize, handleDeleteAddress);
router.patch("/:id/default", verifyAndAuthorize, handleSetDefaultAddress);
router.put("/:id", verifyAndAuthorize, handleUpdateAddress);

module.exports = router;
