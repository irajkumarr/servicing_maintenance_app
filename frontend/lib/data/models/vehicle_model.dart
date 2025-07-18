// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

List<VehicleModel> vehicleModelFromJson(String str) => List<VehicleModel>.from(json.decode(str).map((x) => VehicleModel.fromJson(x)));

String vehicleModelToJson(List<VehicleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VehicleModel {
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

    VehicleModel({
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
    });

    factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
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
    };
}
