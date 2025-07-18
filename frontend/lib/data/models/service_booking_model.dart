// To parse this JSON data, do
//
//     final serviceBookingModel = serviceBookingModelFromJson(jsonString);

import 'dart:convert';

ServiceBookingModel serviceBookingModelFromJson(String str) => ServiceBookingModel.fromJson(json.decode(str));

String serviceBookingModelToJson(ServiceBookingModel data) => json.encode(data.toJson());

class ServiceBookingModel {
    final String? vehicle;
    final String? service;
    final DateTime? scheduledAt;
    final Location? location;
    final int? totalAmount;

    ServiceBookingModel({
        this.vehicle,
        this.service,
        this.scheduledAt,
        this.location,
        this.totalAmount,
    });

    factory ServiceBookingModel.fromJson(Map<String, dynamic> json) => ServiceBookingModel(
        vehicle: json["vehicle"],
        service: json["service"],
        scheduledAt: json["scheduledAt"] == null ? null : DateTime.parse(json["scheduledAt"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        totalAmount: json["totalAmount"],
    );

    Map<String, dynamic> toJson() => {
        "vehicle": vehicle,
        "service": service,
        "scheduledAt": scheduledAt?.toIso8601String(),
        "location": location?.toJson(),
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
