const User = require("./../models/User");
const { generateToken } = require("./../middlewares/jwt");
const { sendEmailWithOTP } = require("../utils/smtp_function");
const generateOTP = require("../utils/generateOtp");

const handleCreateUser = async (req, res) => {
  const { fullName, email, password, phoneNumber } = req.body;
  try {
    //check user by email
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ status: false, message: "Email already exists" });
    }
    //check user by phone
    const existingUserWithPhone = await User.findOne({ phoneNumber });
    if (existingUserWithPhone) {
      return res
        .status(400)
        .json({ status: false, message: "Phone number already exists" });
    }
    //generating otp
    const otp = generateOTP();
    //generating otp expiry
    const otpExpiry = new Date(Date.now() + 60 * 60 * 1000);

    //create new user
    const newUser = new User({
      fullName,
      email,
      password,
      phoneNumber,
      otp,
      otpExpiry,
    });

    await newUser.save();
    sendEmailWithOTP(email, fullName, otp);
    //send response
    res.status(201).json({
      status: true,
      message: "Account created. Please verify OTP sent to email.",
    });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleLoginUser = async (req, res) => {
  const { email, password } = req.body;
  try {
    //check if email and password are provided
    if (!email || !password) {
      return res.status(400).json({
        status: false,
        message: "Please provide both email and password.",
      });
    }
    //find user in db
    const user = await User.findOne(
      { email },
      { __v: 0, createdAt: 0, updatedAt: 0 }
    );
    //check if user is in db and password is correct
    if (!user || !(await user.comparePassword(password))) {
      return res
        .status(401)
        .json({ status: false, message: "Invalid email or password" });
    }

    if (!user.verification) {
      return res.status(403).json({
        status: false,
        message: "Email not verified. Please verify your account using OTP.",
      });
    }
    //generate payload and token
    const payload = {
      id: user._id,
      role: user.role,
      email: user.email,
    };

    const userToken = generateToken(payload);

    //send response with user details excluding password
    const { password: _, ...others } = user._doc;
    res.status(200).json({ ...others, userToken });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleVerifyUserOTP = async (req, res) => {
  const { email, otp } = req.body;
  try {
    //find user with email
    const user = await User.findOne({ email });
    //check if the user exists or not
    if (!user) {
      return res
        .status(404)
        .json({ status: false, message: "User with email doesnot exists." });
    }
    //check if user has already verify the account
    if (user.verification) {
      return res
        .status(400)
        .json({ status: false, message: "Account already verified" });
    }
    //check if the otp is valid and isnot expired
    if (user.otp !== otp || user.otpExpiry < Date.now()) {
      return res
        .status(400)
        .json({ status: false, message: "Invalid or expired OTP" });
    }
    //update the verification , otp and otp expiry fields
    user.verification = true;
    user.otp = null;
    user.otpExpiry = null;
    //save the user
    await user.save();
    //send the response
    res
      .status(200)
      .json({ status: true, message: "Account verified successfully!" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleResendUserOTP = async (req, res) => {
  const { email } = req.body;

  try {
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(404).json({ status: false, message: "User not found" });
    }

    if (user.verification) {
      return res
        .status(400)
        .json({ status: false, message: "Account already verified" });
    }

    const newOtp = generateOTP();
    const newExpiry = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes

    user.otp = newOtp;
    user.otpExpiry = newExpiry;

    await user.save();
    sendEmailWithOTP(email, user.fullName, newOtp);

    res.status(200).json({ status: true, message: "New OTP sent to email." });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleCreateUser,
  handleLoginUser,
  handleVerifyUserOTP,
  handleResendUserOTP,
};
