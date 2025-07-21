const {
  handleCreateService,
  handleDeleteService,
  handleGetServices,
  handleGetServiceById,
  handleGetServicesByType,
  handleGetTopRatedServices,
  handleRateService,
  handleSearchService,
} = require("./../controllers/serviceController");
const express = require("express");
const {
  verifyProvider,
  verifyAdmin,
  verifyAndAuthorize,
  authorizeAnyRole,
} = require("../middlewares/jwt");
const router = express.Router();

const upload = require("./../middlewares/multer");

router.post("/", verifyProvider, upload.single("image"), handleCreateService);
router.get("/", authorizeAnyRole, handleGetServices);
router.get("/type", authorizeAnyRole, handleGetServicesByType);
router.get("/top-rated", authorizeAnyRole, handleGetTopRatedServices);
router.get("/:id", authorizeAnyRole, handleGetServiceById);
router.delete("/:id", verifyProvider, handleDeleteService);
router.post("/:id/rate", verifyAndAuthorize, handleRateService);
router.get("/search/:search", verifyAndAuthorize, handleSearchService);

module.exports = router;
