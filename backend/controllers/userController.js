const User = require("./../models/User");
const cloudinary = require("./../utils/cloudinary");
//Get User Profile

const handleGetUserProfile = async (req, res) => {
  const userId = req.user.id;
  try {
    const user = await User.findById(
      { _id: userId },
      {
        __v: 0,
        updatedAt: 0,
        createdAt: 0,
      }
    );
    if (!user) {
      return res
        .status(404)
        .json({ status: false, message: "User not found." });
    }
    res.status(200).json(user);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

//Update Profile
const handleUpdateProfile = async (req, res) => {
  const userId = req.user.id;
  const { fullName } = req.body;

  try {
    if (!fullName || fullName.trim().length < 3) {
      return res.status(400).json({
        status: false,
        message: "Full name must be at least 3 characters long.",
      });
    }

    const user = await User.findByIdAndUpdate(
      userId,
      { fullName: fullName.trim() },
      {
        new: true,
        runValidators: true,
        select: "-password -__v -createdAt -updatedAt",
      }
    );

    if (!user) {
      return res.status(404).json({ status: false, message: "User not found" });
    }

    res.status(200).json({
      status: true,
      message: "Profile updated successfully",
      user,
    });
  } catch (error) {
    res.status(500).json({
      status: false,
      message: error.message,
    });
  }
};

//Delete Account
const handleDeleteAccount = async (req, res) => {
  const userId = req.user.id;
  try {
    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ status: false, message: "User not found" });
    }

    await User.findByIdAndDelete(userId);

    res
      .status(200)
      .json({ status: true, message: "Account Deleted successfully" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

// Update User Profile Image (File Upload)
const handleUpdateProfileImage = async (req, res) => {
  try {
    const userId = req.user.id;

    if (!req.file) {
      return res
        .status(400)
        .json({ success: false, message: "No image file uploaded" });
    }

    // Upload file to Cloudinary
    const result = await cloudinary.uploader.upload_stream(
      { folder: "profile_images", resource_type: "auto" },
      async (error, result) => {
        if (error) {
          return res.status(500).json({
            success: false,
            message: "Cloudinary upload failed",
            error,
          });
        }

        // Update user profile image
        const user = await User.findByIdAndUpdate(
          { _id: userId },
          { profileImage: result.secure_url },
          { new: true, runValidators: true }
        );

        if (!user) {
          return res
            .status(404)
            .json({ success: false, message: "User not found" });
        }

        res.status(200).json({
          success: true,
          message: "Profile image updated successfully",
          data: user,
        });
      }
    );

    // Pipe the file buffer to Cloudinary
    result.end(req.file.buffer);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = {
  handleGetUserProfile,
  handleUpdateProfile,
  handleDeleteAccount,
  handleUpdateProfileImage,
};
