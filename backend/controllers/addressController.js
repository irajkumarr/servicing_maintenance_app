//get address for user
//add address for user
// delete address
//update address
//make address default

const Address = require("../models/Address");

// GET all addresses for a user
const handleGetUserAddresses = async (req, res) => {
  try {
    const userId = req.user.id;
    const addresses = await Address.find({ user: userId });
    res.status(200).json(addresses);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

// ADD new address
const handleAddUserAddress = async (req, res) => {
  try {
    const userId = req.user.id;
    const { label, fullAddress, city, province, zipCode, location, isDefault } =
      req.body;

    if (isDefault) {
      await Address.updateMany({ user: userId }, { isDefault: false });
    }

    const newAddress = new Address({
      user: userId,
      label,
      fullAddress,
      city,
      province,
      zipCode,
      location,
      isDefault,
    });

    await newAddress.save();
    res.status(201).json({ status: true, message: "Address added" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

// UPDATE address
const handleUpdateAddress = async (req, res) => {
  try {
    const userId = req.user.id;
    const addressId = req.params.id;

    const address = await Address.findById(addressId);

    if (!address || address.user.toString() !== userId) {
      return res
        .status(404)
        .json({ status: false, message: "Address not found or access denied" });
    }

    const updates = req.body;

    if (updates.isDefault) {
      await Address.updateMany({ user: userId }, { isDefault: false });
    }

    Object.assign(address, updates);
    await address.save();

    res
      .status(200)
      .json({ status: true, message: "Address updated", data: address });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

// DELETE address
const handleDeleteAddress = async (req, res) => {
  try {
    const userId = req.user.id;
    const addressId = req.params.id;

    const address = await Address.findById(addressId);

    if (!address || address.user.toString() !== userId) {
      return res
        .status(404)
        .json({ status: false, message: "Address not found or access denied" });
    }

    await Address.deleteOne({ _id: addressId });
    res.status(200).json({ status: true, message: "Address deleted" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

// MAKE address default
const handleSetDefaultAddress = async (req, res) => {
  try {
    const userId = req.user.id;
    const addressId = req.params.id;

    const address = await Address.findById(addressId);

    if (!address || address.user.toString() !== userId) {
      return res
        .status(404)
        .json({ status: false, message: "Address not found or access denied" });
    }

    await Address.updateMany({ user: userId }, { isDefault: false });

    address.isDefault = true;
    await address.save();

    res.status(200).json({ status: true, message: "Address set as default" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

// GET default address for a user
const handleGetDefaultAddress = async (req, res) => {
  try {
    const userId = req.user.id;

    const defaultAddress = await Address.findOne({
      user: userId,
      isDefault: true,
    });

    if (!defaultAddress) {
      return res.status(404).json({
        status: false,
        message: "Default address not found",
      });
    }

    res.status(200).json(defaultAddress);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

module.exports = {
  handleGetUserAddresses,
  handleAddUserAddress,
  handleUpdateAddress,
  handleDeleteAddress,
  handleSetDefaultAddress,
  handleGetDefaultAddress,
};
