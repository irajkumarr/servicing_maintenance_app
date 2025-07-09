const express = require("express");
const {
  handleCreateUser,
  handleLoginUser,
} = require("../controllers/authController");
const router = express.Router();

router.post("/register", handleCreateUser);
router.post("/login", handleLoginUser);


module.exports=router;