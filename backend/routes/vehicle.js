const { verifyAndAuthorize } = require("../middlewares/jwt");
const {
  handleCreateVehicle,
  handleGetAllVehicles,
  handleDeleteVehicle,
  handleUpdateVehicle,
  handleSetDefaultVehicle,
} = require("./../controllers/vehicleController");
const express = require("express");
const router = express.Router();
const upload = require("./../middlewares/multer");
router.get("/", verifyAndAuthorize, handleGetAllVehicles);
router.post(
  "/",
  verifyAndAuthorize,
  upload.single("image"),
  handleCreateVehicle
);
router.put("/:id", verifyAndAuthorize, handleUpdateVehicle);
router.delete("/:id", verifyAndAuthorize, handleDeleteVehicle);
router.patch("/:id/default", verifyAndAuthorize, handleSetDefaultVehicle);

module.exports = router;
