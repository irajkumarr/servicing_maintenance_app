// To parse this JSON data, do
//
//     final serviceModel = serviceModelFromJson(jsonString);

import 'dart:convert';

List<ServiceModel> serviceModelFromJson(String str) => List<ServiceModel>.from(json.decode(str).map((x) => ServiceModel.fromJson(x)));

String serviceModelToJson(List<ServiceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceModel {
    final String? id;
    final String? title;
    final String? description;
    final String? category;
    final String? type;
    final int? basePrice;
    final String? estimatedTime;
    final String? imageUrl;
    final bool? isActive;
    final ServiceProvider? serviceProvider;
    final int? rating;
    final int? reviewCount;
    final List<String>? ratedBy;

    ServiceModel({
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
    });

    factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        type: json["type"],
        basePrice: json["basePrice"],
        estimatedTime: json["estimatedTime"],
        imageUrl: json["imageUrl"],
        isActive: json["isActive"],
        serviceProvider: json["serviceProvider"] == null ? null : ServiceProvider.fromJson(json["serviceProvider"]),
        rating: json["rating"],
        reviewCount: json["reviewCount"],
        ratedBy: json["ratedBy"] == null ? [] : List<String>.from(json["ratedBy"]!.map((x) => x)),
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
        "serviceProvider": serviceProvider?.toJson(),
        "rating": rating,
        "reviewCount": reviewCount,
        "ratedBy": ratedBy == null ? [] : List<dynamic>.from(ratedBy!.map((x) => x)),
    };
}

class ServiceProvider {
    final String? id;
    final User? user;
    final String? address;
    final String? availabilityStatus;

    ServiceProvider({
        this.id,
        this.user,
        this.address,
        this.availabilityStatus,
    });

    factory ServiceProvider.fromJson(Map<String, dynamic> json) => ServiceProvider(
        id: json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        address: json["address"],
        availabilityStatus: json["availabilityStatus"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user?.toJson(),
        "address": address,
        "availabilityStatus": availabilityStatus,
    };
}

class User {
    final String? id;
    final String? email;
    final String? phoneNumber;

    User({
        this.id,
        this.email,
        this.phoneNumber,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "email": email,
        "phoneNumber": phoneNumber,
    };
}
