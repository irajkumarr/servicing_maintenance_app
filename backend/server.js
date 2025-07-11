require("dotenv").config();
const express = require("express");
const app = express();
const mongoose = require("mongoose");

//PORT
const PORT = process.env.PORT || 3000;

//middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

//routes
const authRoutes = require("./routes/auth");
const userRoutes = require("./routes/user");
const serviceProviderRoutes = require("./routes/serviceProvider");
const providerBookingRoutes = require("./routes/providerBooking");
const serviceRoutes = require("./routes/service");

app.use("/", authRoutes);
app.use("/api/users", userRoutes);
app.use("/api/providers", serviceProviderRoutes);
app.use("/api/services", serviceRoutes);
app.use("/api/providers/bookings", providerBookingRoutes);
//database connection
mongoose
  .connect(process.env.MONGODB_CLOUD_URL)
  .then(() => {
    console.log("Connected to MongoDB! ✅");
  })
  .catch((error) => {
    console.error("MongoDB connection error:", error);
    process.exit(1);
  });

//starting server on port
app.listen(PORT, () => {
  console.log(`Server running at PORT ${PORT} 🚀`);
});
