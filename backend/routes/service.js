const {
  handleCreateService,
  handleDeleteService,
  handleGetServices,
  handleGetServiceById,
  handleGetServicesByType,
  handleGetTopRatedServices,
} = require("./../controllers/serviceController");
const express = require("express");
const {
  verifyProvider,
  verifyAdmin,
  verifyAndAuthorize,
} = require("../middlewares/jwt");
const router = express.Router();

const upload = require("./../middlewares/multer");

router.post("/", verifyProvider, upload.single("image"), handleCreateService);
router.get("/", verifyAndAuthorize, handleGetServices);
router.get("/type", verifyAndAuthorize, handleGetServicesByType);
router.get("/top-rated", verifyAndAuthorize, handleGetTopRatedServices);
router.get("/:id", verifyAndAuthorize, handleGetServiceById);
router.delete("/:id", verifyProvider, handleDeleteService);

module.exports = router;
