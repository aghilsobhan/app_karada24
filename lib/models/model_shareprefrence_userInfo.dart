// To parse this JSON data, do
//
//     final responseUserInfo = responseUserInfoFromJson(jsonString);

import 'dart:convert';

class ModelUserInfo {
  ModelUserInfo({
    required this.fullname,
    required this.username,
    required this.email,
    required this.phoneNumber,
  });

  String? fullname;
  String? username;
  String? email;
  String? phoneNumber;

  factory ModelUserInfo.fromJson(Map<String, dynamic> json) => ModelUserInfo(
    fullname: json["fullname"],
    username: json["username"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "username": username,
    "email": email,
    "phoneNumber": phoneNumber,
  };
}
