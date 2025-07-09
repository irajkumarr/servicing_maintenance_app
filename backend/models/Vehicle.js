const carBrands = [
  "Honda",
  "Maruti Suzuki",
  "Hyundai",
  "Tata",
  "Mahindra",
  "Toyota",
  "Ford",
  "Volkswagen",
];
const bikeBrands = [
  "Royal Enfield",
  "Hero",
  "Honda",
  "Bajaj",
  "TVS",
  "Yamaha",
  "KTM",
  "Suzuki",
];

const vehicleSchema = new mongoose.Schema(
  {
    owner: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
    vehicleType: {
      type: String,
      enum: ["car", "bike"],
      required: true,
    },
    brand: {
      type: String,
      required: true,
      validate: {
        validator: function (value) {
          if (this.vehicleType === "car") return carBrands.includes(value);
          if (this.vehicleType === "bike") return bikeBrands.includes(value);
          return true;
        },
        message: (props) =>
          `${props.value} is not a valid brand for the selected vehicle type`,
      },
    },
    model: { type: String, required: true },
    year: { type: Number, required: true },
    registrationNumber: {
      type: String,
      required: true,
      unique: true,
    },
    fuelType: {
      type: String,
      enum: ["petrol", "diesel", "electric", "cng"],
      required: true,
    },
    color: { type: String },
    vehiclePhoto: String,
    isDefault: { type: Boolean, default: false },
  },
  { timestamps: true }
);

const Vehicle = mongoose.model("Vehicle", vehicleSchema);
module.exports = Vehicle;
