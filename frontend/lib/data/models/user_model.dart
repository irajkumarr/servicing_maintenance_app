// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    final String? id;
    final String? fullName;
    final String? email;
    final String? phoneNumber;
    final String? profileImage;
    final String? role;
    final dynamic otp;
    final dynamic otpExpiry;
    final bool? verification;
    final String? userToken;

    UserModel({
        this.id,
        this.fullName,
        this.email,
        this.phoneNumber,
        this.profileImage,
        this.role,
        this.otp,
        this.otpExpiry,
        this.verification,
        this.userToken,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        fullName: json["fullName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        profileImage: json["profileImage"],
        role: json["role"],
        otp: json["otp"],
        otpExpiry: json["otpExpiry"],
        verification: json["verification"],
        userToken: json["userToken"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "email": email,
        "phoneNumber": phoneNumber,
        "profileImage": profileImage,
        "role": role,
        "otp": otp,
        "otpExpiry": otpExpiry,
        "verification": verification,
        "userToken": userToken,
    };
}
