// const mongoose = require("mongoose");

// const serviceProviderSchema = new mongoose.Schema(
//   {
//     fullName: {
//       type: String,
//       required: true,
//     },
//     phone: {
//       type: String,
//       required: true,
//       unique: true,
//     },
//     email: {
//       type: String,
//       unique: true,
//     },

//     isVerified: {
//       type: Boolean,
//       default: false,
//     },
//     profileImage: String,
//     experienceYears: Number,
//     servicesOffered: [
//       {
//         type: mongoose.Schema.Types.ObjectId,
//         ref: "Service",
//       },
//     ],
//     address: {
//       type: String,
//     },
//     availabilityStatus: {
//       type: String,
//       enum: ["online", "offline", "busy"],
//       default: "offline",
//     },
//     createdBy: {
//       type: mongoose.Schema.Types.ObjectId,
//       ref: "User",
//     },
//   },
//   { timestamps: true }
// );

// const ServiceProvider = mongoose.model(
//   "ServiceProvider",
//   serviceProviderSchema
// );
// module.exports = ServiceProvider;

const mongoose = require("mongoose");

const serviceProviderSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
      unique: true,
    },
    experienceYears: {
      type: Number,
      default: 0,
    },
    servicesOffered: [
      {
        type: mongoose.Schema.Types.ObjectId,
        ref: "Service",
      },
    ],
    address: {
      type: String,
      default: "",
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
    isVerified: {
      type: Boolean,
      default: false,
    },
  },
  { timestamps: true }
);

const ServiceProvider = mongoose.model(
  "ServiceProvider",
  serviceProviderSchema
);
module.exports = ServiceProvider;
