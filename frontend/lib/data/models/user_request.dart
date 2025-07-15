// To parse this JSON data, do
//
//     final userRequest = userRequestFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserRequest userRequestFromJson(String str) => UserRequest.fromJson(json.decode(str));

String userRequestToJson(UserRequest data) => json.encode(data.toJson());

class UserRequest {
    final String fullName;
    final String email;
    final String password;
    final String phoneNumber;

    UserRequest({
        required this.fullName,
        required this.email,
        required this.password,
        required this.phoneNumber,
    });

    factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        fullName: json["fullName"],
        email: json["email"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
    );

    Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "email": email,
        "password": password,
        "phoneNumber": phoneNumber,
    };
}
