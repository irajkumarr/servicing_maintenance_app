// GET /api/services
// GET /api/services/:id
// GET /api/services/type
// POST /api/services/
// DELETE /api/services/:id
const Service = require("./../models/Service");
const ServiceProvider = require("./../models/ServiceProvider");

const cloudinary = require("./../utils/cloudinary");

const handleGetServices = async (req, res) => {
  try {
    const services = await Service.find(
      { isActive: true },
      { __v: 0, updatedAt: 0, createdAt: 0 }
    ).populate({
      path: "serviceProvider",
      select: "user address availabilityStatus",
      populate: {
        path: "user",
        select: "name email phoneNumber",
      },
    });
    res.status(200).json(services);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetServiceById = async (req, res) => {
  try {
    const service = await Service.findById(req.params.id, {
      __v: 0,
      updatedAt: 0,
      createdAt: 0,
    }).populate({
      path: "serviceProvider",
      select: "user address availabilityStatus",
      populate: {
        path: "user",
        select: "name email phoneNumber",
      },
    });
    if (!service) {
      return res
        .status(404)
        .json({ status: false, message: "Service not found" });
    }
    res.status(200).json(service);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetServicesByType = async (req, res) => {
  const { type } = req.query;

  if (!["car", "bike", "both"].includes(type)) {
    return res.status(400).json({
      status: false,
      message: "Invalid type. Use 'car', 'bike', or 'both'.",
    });
  }

  try {
    const services = await Service.find(
      { type, isActive: true },
      { __v: 0, updatedAt: 0, createdAt: 0 }
    ).populate({
      path: "serviceProvider",
      select: "user address availabilityStatus",
      populate: {
        path: "user",
        select: "name email phoneNumber",
      },
    });
    res.status(200).json(services);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleCreateService = async (req, res) => {
  const { title, description, category, type, basePrice, estimatedTime } =
    req.body;

  const providerId = req.user.id;

  try {
    const provider = await ServiceProvider.findOne({ user: providerId });
    if (!provider) {
      return res.status(403).json({
        status: false,
        message: "Only registered service providers can create services.",
      });
    }

    if (!req.file) {
      return res
        .status(400)
        .json({ status: false, message: "Image is required" });
    }

    const stream = cloudinary.uploader.upload_stream(
      { folder: "servicing_app_images", resource_type: "image" },
      async (error, result) => {
        if (error) {
          return res.status(500).json({
            status: false,
            message: "Cloudinary upload failed",
            error,
          });
        }

        const newService = new Service({
          title,
          description,
          category,
          type,
          basePrice,
          estimatedTime,
          imageUrl: result.secure_url,
          serviceProvider: provider._id,
        });

        await newService.save();

        provider.servicesOffered.push(newService._id);
        await provider.save();

        res.status(201).json({
          status: true,
          message: "Service created successfully",
        });
      }
    );

    // ✅ Send the buffer to the stream
    stream.end(req.file.buffer);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleDeleteService = async (req, res) => {
  const providerId = req.user.id;
  const serviceId = req.params.id;

  try {
    const service = await Service.findById(serviceId);

    if (!service) {
      return res
        .status(404)
        .json({ status: false, message: "Service not found" });
    }

    const provider = await ServiceProvider.findOne({ user: providerId });

    if (!provider || !service.serviceProvider.equals(provider._id)) {
      return res.status(403).json({
        status: false,
        message: "You are not authorized to delete this service",
      });
    }

    await Service.findByIdAndDelete(serviceId);

    provider.servicesOffered.pull(serviceId);
    await provider.save();

    res
      .status(200)
      .json({ status: true, message: "Service deleted successfully" });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};

const handleGetTopRatedServices = async (req, res) => {
  try {
    const limit = parseInt(req.query.limit) || 5; // default: top 5

    const topServices = await Service.find({ isActive: true })
      .sort({ rating: -1, reviewCount: -1 })
      .limit(limit)
      .select("-__v -createdAt -updatedAt")
      .populate({
        path: "serviceProvider",
        select: "user address availabilityStatus",
        populate: {
          path: "user",
          select: "fullName email phoneNumber",
        },
      });

    res.status(200).json(topServices);
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};
const handleRateService = async (req, res) => {
  const serviceId = req.params.id;
  const { rating } = req.body;

  const userId = req.user.id;
  try {

     if (req.user.role !== "user") {
      return res.status(403).json({
        status: false,
        message: "Only users are allowed to rate services.",
      });
    }
    // Validate rating input
    const parsedRating = Number(rating);
    if (!parsedRating || parsedRating < 1 || parsedRating > 5) {
      return res
        .status(400)
        .json({ status: false, message: "Rating must be between 1 and 5." });
    }

    // Find the service
    const service = await Service.findById(serviceId);
    if (!service) {
      return res
        .status(404)
        .json({ status: false, message: "Service not found." });
    }

    // Check if the user already rated
    if (service.ratedBy.includes(userId)) {
      return res.status(400).json({
        status: false,
        message: "You have already rated this service.",
      });
    }

    // Recalculate average rating
    const totalRating = service.rating * service.reviewCount + parsedRating;
    service.reviewCount += 1;
    service.rating = totalRating / service.reviewCount;
    // Add user to ratedBy
    service.ratedBy.push(userId);

    await service.save();

    res.status(200).json({
      status: true,
      message: "Rating submitted successfully",
    });
  } catch (error) {
    res.status(500).json({ status: false, message: error.message });
  }
};
module.exports = {
  handleCreateService,
  handleDeleteService,
  handleGetServices,
  handleGetServiceById,
  handleGetServicesByType,
  handleGetTopRatedServices,
  handleRateService,
};
