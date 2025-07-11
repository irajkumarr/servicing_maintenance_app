const {
  handleCreateService,
  handleDeleteService,
  handleGetServices,
  handleGetServiceById,
  handleGetServicesByType,
  handleGetTopRatedServices,
  handleRateService,
} = require("./../controllers/serviceController");
const express = require("express");
const {
  verifyProvider,
  verifyAdmin,
  verifyAndAuthorize,
  verifyAndAuthorizeAll,
} = require("../middlewares/jwt");
const router = express.Router();

const upload = require("./../middlewares/multer");

router.post("/", verifyProvider, upload.single("image"), handleCreateService);
router.get("/", verifyAndAuthorizeAll, handleGetServices);
router.get("/type", verifyAndAuthorizeAll, handleGetServicesByType);
router.get("/top-rated", verifyAndAuthorizeAll, handleGetTopRatedServices);
router.get("/:id", verifyAndAuthorizeAll, handleGetServiceById);
router.delete("/:id", verifyProvider, handleDeleteService);
router.post("/:id/rate", verifyAndAuthorize, handleRateService);

module.exports = router;
