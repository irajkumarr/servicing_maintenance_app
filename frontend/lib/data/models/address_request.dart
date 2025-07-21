// To parse this JSON data, do
//
//     final addressRequest = addressRequestFromJson(jsonString);

import 'dart:convert';

AddressRequest addressRequestFromJson(String str) => AddressRequest.fromJson(json.decode(str));

String addressRequestToJson(AddressRequest data) => json.encode(data.toJson());

class AddressRequest {
    final String? label;
    final String? fullAddress;
    final String? city;
    final String? province;
    final Location? location;
    final bool? isDefault;

    AddressRequest({
        this.label,
        this.fullAddress,
        this.city,
        this.province,
        this.location,
        this.isDefault,
    });

    factory AddressRequest.fromJson(Map<String, dynamic> json) => AddressRequest(
        label: json["label"],
        fullAddress: json["fullAddress"],
        city: json["city"],
        province: json["province"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        isDefault: json["isDefault"],
    );

    Map<String, dynamic> toJson() => {
        "label": label,
        "fullAddress": fullAddress,
        "city": city,
        "province": province,
        "location": location?.toJson(),
        "isDefault": isDefault,
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
