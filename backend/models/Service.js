const mongoose = require("mongoose");

const serviceSchema = new mongoose.Schema(
  {
    title: {
      type: String,
      required: true,
    },
    description: {
      type: String,
    },
    category: {
      type: String,
      enum: [
        "wash",
        "repair",
        "tire_change",
        "oil_change",
        "battery",
        "general_checkup",
      ],
      required: true,
    },
    basePrice: {
      type: Number,
      required: true,
    },
    estimatedTime: {
      type: String,
    },
    imageUrl: {
      type: String,
    },
    isActive: {
      type: Boolean,
      default: true,
    },
    serviceProvider: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "ServiceProvider",
      required: true,
    },
    rating: {
      type: Number,
      default: 0,
      min: 1,
      max: 5,
    },
    reviewCount: {
      type: Number,
      default: 0,
    },
  },
  { timestamps: true }
);

const Service = mongoose.model("Service", serviceSchema);
module.exports = Service;
