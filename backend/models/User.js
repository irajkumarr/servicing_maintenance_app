const mongoose = require("mongoose");
const bcrypt = require("bcryptjs");
const userSchema = new mongoose.Schema(
  {
    fullName: {
      type: String,
      required: [true, "Full name is required"],
      minLength: [3, "Full name must be at least 3 characters long."],
    },
    email: {
      type: String,
      required: [true, "Email is required."],
      unique: true,
      lowercase: true,
      trim: true,
      match: [
        /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$/,
        "Please provide a valid email address.",
      ],
    },
    phoneNumber: {
      type: String,
      unique: true,
      required: [true, "Phone number is required."],
      match: [/^\d{10}$/, "Phone number must be exactly 10 digits."],
    },
    password: {
      type: String,
      required: [true, "Password is required"],
      minLength: [6, "Password must be 6 characters long."],
      maxLength: [50, "Password cannot be more than 50 characters long."],
    },
    profileImage: {
      type: String,
      default: "",
    },
    userType: {
      type: String,
      required: true,
      enum: ["user", "admin"],
      default: "user",
    },
    otp: {
      type: String,
    },
    otpExpiry: {
      type: Date,
    },
    verification: {
      type: Boolean,
      required: true,
      default: false,
    },
  },
  { timestamps: true }
);

userSchema.pre("save", async function (next) {
  const user = this;
  if (!user.isModified(password)) return next();
  try {
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(user.password, salt);
    user.password = hashedPassword;
    next();
  } catch (error) {
    return next(error);
  }
});

userSchema.methods.comparePassword = async function (enteredPassword) {
  try {
    const isMatch = await bcrypt.compare(enteredPassword, this, password);
    return isMatch;
  } catch (error) {
    throw error;
  }
};

const User = mongoose.model("User", userSchema);
module.exports = User;
