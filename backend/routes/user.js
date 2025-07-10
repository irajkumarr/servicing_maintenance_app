const express = require("express");
const upload = require("./../middlewares/multer");
const {
  handleGetUserProfile,
  handleDeleteAccount,
  handleUpdateProfile,
  handleUpdateProfileImage,
} = require("../controllers/userController");
const { verifyAndAuthorize } = require("../middlewares/jwt");
const router = express.Router();

router.get("/", verifyAndAuthorize, handleGetUserProfile);
router.put("/", verifyAndAuthorize, handleUpdateProfile);
router.delete("/", verifyAndAuthorize, handleDeleteAccount);
router.put(
  "/profile-image",
  verifyAndAuthorize,
  upload.single("profileImage"),
  handleUpdateProfileImage
);
module.exports = router;
