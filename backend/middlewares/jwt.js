const jwt = require("jsonwebtoken");

const verifyToken = (req, res, next) => {
  const authorization = req.headers.authorization;
  if (!authorization) {
    return res.status(401).json({ status: false, message: "Token not found" });
  }
  const token = authorization.split(" ")[1];
  if (!token) {
    return res.status(401).json({ status: false, message: "Access Denied ❌" });
  }
  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = decoded;
    next();
  } catch (error) {
    return res.status(401).json({ status: false, message: "Invalid token" });
  }
};

const generateToken = (userData) => {
  return jwt.sign(userData, process.env.JWT_SECRET);
};

const verifyAndAuthorize = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.role === "admin" || req.user.role === "user") {
      next();
    } else {
      return res
        .status(401)
        .json({ status: false, message: "Access Denied ❌" });
    }
  });
};
const verifyAndAuthorizeAll = (req, res, next) => {
  verifyToken(req, res, () => {
    if (
      req.user.role === "admin" ||
      req.user.role === "user" ||
      req.user.role === "provider"
    ) {
      next();
    } else {
      return res
        .status(401)
        .json({ status: false, message: "Access Denied ❌" });
    }
  });
};

const verifyAdmin = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.role === "admin") {
      next();
    } else {
      return res
        .status(401)
        .json({ status: false, message: "Access Denied ❌" });
    }
  });
};
const verifyProvider = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.role === "provider") {
      next();
    } else {
      return res
        .status(401)
        .json({ status: false, message: "Access Denied ❌" });
    }
  });
};

module.exports = {
  verifyToken,
  generateToken,
  verifyAndAuthorize,
  verifyAndAuthorizeAll,
  verifyAdmin,
  verifyProvider,
};
