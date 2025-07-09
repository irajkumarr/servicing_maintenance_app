const mongoose = require("mongoose");

const serviceProviderSchema = new mongoose.Schema(
  {
    fullName: {
      type: String,
      required: true,
    },
    phone: {
      type: String,
      required: true,
      unique: true,
    },
    email: {
      type: String,
      unique: true,
    },

    isVerified: {
      type: Boolean,
      default: false,
    },
    profileImage: String,
    experienceYears: Number,
    servicesOffered: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Service",
      },
    ],
    address: {
      type: String,
    },
    availabilityStatus: {
      type: String,
      enum: ["online", "offline", "busy"],
      default: "offline",
    },
    createdBy: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
    },
  },
  { timestamps: true }
);

const ServiceProvider = mongoose.model(
  "ServiceProvider",
  serviceProviderSchema
);
module.exports = ServiceProvider;
