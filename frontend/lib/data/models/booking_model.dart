// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
    final Location? location;
    final String? id;
    final String? user;
    final Provider? provider;
    final Vehicle? vehicle;
    final Service? service;
    final DateTime? scheduledAt;
    final String? status;
    final String? paymentStatus;
    final int? totalAmount;

    BookingModel({
        this.location,
        this.id,
        this.user,
        this.provider,
        this.vehicle,
        this.service,
        this.scheduledAt,
        this.status,
        this.paymentStatus,
        this.totalAmount,
    });

    factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        id: json["_id"],
        user: json["user"],
        provider: json["provider"] == null ? null : Provider.fromJson(json["provider"]),
        vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
        service: json["service"] == null ? null : Service.fromJson(json["service"]),
        scheduledAt: json["scheduledAt"] == null ? null : DateTime.parse(json["scheduledAt"]),
        status: json["status"],
        paymentStatus: json["paymentStatus"],
        totalAmount: json["totalAmount"],
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "user": user,
        "provider": provider?.toJson(),
        "vehicle": vehicle?.toJson(),
        "service": service?.toJson(),
        "scheduledAt": scheduledAt?.toIso8601String(),
        "status": status,
        "paymentStatus": paymentStatus,
        "totalAmount": totalAmount,
    };
}

class Location {
    final double? latitude;
    final double? longitude;
    final String? address;

    Location({
        this.latitude,
        this.longitude,
        this.address,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
    };
}

class Provider {
    final String? id;
    final User? user;
    final int? experienceYears;
    final List<String>? servicesOffered;
    final String? address;
    final String? availabilityStatus;
    final bool? isVerified;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    Provider({
        this.id,
        this.user,
        this.experienceYears,
        this.servicesOffered,
        this.address,
        this.availabilityStatus,
        this.isVerified,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        experienceYears: json["experienceYears"],
        servicesOffered: json["servicesOffered"] == null ? [] : List<String>.from(json["servicesOffered"]!.map((x) => x)),
        address: json["address"],
        availabilityStatus: json["availabilityStatus"],
        isVerified: json["isVerified"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "experienceYears": experienceYears,
        "servicesOffered": servicesOffered == null ? [] : List<dynamic>.from(servicesOffered!.map((x) => x)),
        "address": address,
        "availabilityStatus": availabilityStatus,
        "isVerified": isVerified,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class User {
    final String? id;
    final String? fullName;
    final String? email;
    final String? phoneNumber;

    User({
        this.id,
        this.fullName,
        this.email,
        this.phoneNumber,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
    };
}

class Service {
    final String? id;
    final String? title;
    final String? description;
    final String? category;
    final String? type;
    final int? basePrice;
    final String? estimatedTime;
    final String? imageUrl;
    final bool? isActive;
    final String? serviceProvider;
    final int? rating;
    final int? reviewCount;
    final List<String>? ratedBy;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    Service({
        this.id,
        this.title,
        this.description,
        this.category,
        this.type,
        this.basePrice,
        this.estimatedTime,
        this.imageUrl,
        this.isActive,
        this.serviceProvider,
        this.rating,
        this.reviewCount,
        this.ratedBy,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        type: json["type"],
        basePrice: json["basePrice"],
        estimatedTime: json["estimatedTime"],
        imageUrl: json["imageUrl"],
        isActive: json["isActive"],
        serviceProvider: json["serviceProvider"],
        rating: json["rating"],
        reviewCount: json["reviewCount"],
        ratedBy: json["ratedBy"] == null ? [] : List<String>.from(json["ratedBy"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "description": description,
        "category": category,
        "type": type,
        "basePrice": basePrice,
        "estimatedTime": estimatedTime,
        "imageUrl": imageUrl,
        "isActive": isActive,
        "serviceProvider": serviceProvider,
        "rating": rating,
        "reviewCount": reviewCount,
        "ratedBy": ratedBy == null ? [] : List<dynamic>.from(ratedBy!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Vehicle {
    final String? id;
    final String? owner;
    final String? vehicleType;
    final String? brand;
    final String? model;
    final int? year;
    final String? registrationNumber;
    final String? fuelType;
    final String? color;
    final String? vehiclePhoto;
    final bool? isDefault;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    Vehicle({
        this.id,
        this.owner,
        this.vehicleType,
        this.brand,
        this.model,
        this.year,
        this.registrationNumber,
        this.fuelType,
        this.color,
        this.vehiclePhoto,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["_id"],
        owner: json["owner"],
        vehicleType: json["vehicleType"],
        brand: json["brand"],
        model: json["model"],
        year: json["year"],
        registrationNumber: json["registrationNumber"],
        fuelType: json["fuelType"],
        color: json["color"],
        vehiclePhoto: json["vehiclePhoto"],
        isDefault: json["isDefault"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "owner": owner,
        "vehicleType": vehicleType,
        "brand": brand,
        "model": model,
        "year": year,
        "registrationNumber": registrationNumber,
        "fuelType": fuelType,
        "color": color,
        "vehiclePhoto": vehiclePhoto,
        "isDefault": isDefault,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}
