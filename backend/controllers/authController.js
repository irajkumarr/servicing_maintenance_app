const User = require("./../models/User");
const { generateToken } = require("./../middlewares/jwt");
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
    //create new user
    const newUser = new User({
      fullName: fullName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    });

    await newUser.save();
    res
      .status(201)
      .json({ status: true, message: "Account Created Successfully!" });
    //send response
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
    const user = await User.findOne({ email });
    //check if user is in db and password is correct
    if (!user || !(await user.comparePassword(password))) {
      return res
        .status(401)
        .json({ status: false, message: "Invalid email or password" });
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

module.exports = {
  handleCreateUser,
  handleLoginUser,
};
