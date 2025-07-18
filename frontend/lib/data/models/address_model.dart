// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
    final Location? location;
    final String? id;
    final String? user;
    final String? label;
    final String? fullAddress;
    final String? city;
    final String? province;
    final bool? isDefault;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final int? v;

    AddressModel({
        this.location,
        this.id,
        this.user,
        this.label,
        this.fullAddress,
        this.city,
        this.province,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        id: json["_id"],
        user: json["user"],
        label: json["label"],
        fullAddress: json["fullAddress"],
        city: json["city"],
        province: json["province"],
        isDefault: json["isDefault"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
        "_id": id,
        "user": user,
        "label": label,
        "fullAddress": fullAddress,
        "city": city,
        "province": province,
        "isDefault": isDefault,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
    };
}

class Location {
    final double? latitude;
    final double? longitude;

    Location({
        this.latitude,
        this.longitude,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
