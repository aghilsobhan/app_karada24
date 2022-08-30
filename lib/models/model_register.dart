// To parse this JSON data, do
//
//     final modelRegister = modelRegisterFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final modelRegister = modelRegisterFromJson(jsonString);

import 'dart:convert';

ModelRegister modelRegisterFromJson(String str) => ModelRegister.fromJson(json.decode(str));

String modelRegisterToJson(ModelRegister data) => json.encode(data.toJson());

class ModelRegister {
  ModelRegister({
    this.userId,
    this.username,
    this.email,
    this.password,
    this.phoneNumber,
    this.fullname,

  });

  int? userId;
  String? username;
  String? email;
  String? password;
  String? phoneNumber;
  String? fullname;

  factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
    userId: json["userId"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
    phoneNumber: json["phoneNumber"],
    fullname: json["fullname"],

  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "fullname": fullname,

  };
}

// class ModelRegister {
//   ModelRegister({
//      this.username,
//      this.password,
//      this.email,
//      this.phoneNumber,
//
//   });
//
//   String? username;
//   String? password;
//   String? email;
//   String? phoneNumber;
//
//
//   factory ModelRegister.fromJson(Map<String, dynamic> json) => ModelRegister(
//     username: json["username"],
//     password: json["password"],
//     email: json["email"],
//     phoneNumber: json["phoneNumber"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "username": username,
//     "password": password,
//     "email": email,
//     "phoneNumber": phoneNumber,
//   };
// }
