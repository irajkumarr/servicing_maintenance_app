const express = require("express");
const upload = require("./../middlewares/multer");
const {
  handleGetUserProfile,
  handleDeleteAccount,
  handleUpdateProfile,
  handleUpdateProfileImage,
} = require("../controllers/userController");
const router = express.Router();

router.get("/", handleGetUserProfile);
router.put("/", handleUpdateProfile);
router.delete("/", handleDeleteAccount);
router.put(
  "/profileImage/",
  upload.single("profileImage"),
  handleUpdateProfileImage
);
module.exports = router;
