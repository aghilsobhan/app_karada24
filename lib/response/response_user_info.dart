// To parse this JSON data, do
//
//     final responseUserInfo = responseUserInfoFromJson(jsonString);

import 'dart:convert';

ResponseUserInfo responseUserInfoFromJson(String str) => ResponseUserInfo.fromJson(json.decode(str));

String responseUserInfoToJson(ResponseUserInfo data) => json.encode(data.toJson());

class ResponseUserInfo {
  ResponseUserInfo({
    this.userId,
    this.username,
    this.fullname,
    this.email,
    this.phoneNumber,
    this.password,
    this.contactId,
    this.registerDate,
    this.organId,
    this.organName,
    this.submitUserId,
    this.statId,
    this.statTittle,
    this.userRoleId,
    this.roleId,
    this.roleName,
    this.userDepId,
    this.userDepTittle,
    this.positionId,
    this.positionTittle,
    this.userRequest,
    this.inviterUserFullname,
  });

  int? userId;
  String? username;
  String? fullname;
  String? email;
  dynamic phoneNumber;
  String? password;
  int? contactId;
  String? registerDate;
  int? organId;
  String? organName;
  int? submitUserId;
  int? statId;
  dynamic statTittle;
  int? userRoleId;
  int? roleId;
  dynamic roleName;
  int? userDepId;
  dynamic userDepTittle;
  int? positionId;
  dynamic positionTittle;
  dynamic userRequest;
  dynamic inviterUserFullname;

  factory ResponseUserInfo.fromJson(Map<String, dynamic> json) => ResponseUserInfo(
    userId: json["userId"],
    username: json["username"],
    fullname: json["fullname"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    password: json["password"],
    contactId: json["contactId"],
    registerDate:json["registerDate"],
    organId: json["organId"],
    organName: json["organName"],
    submitUserId: json["submitUserId"],
    statId: json["statId"],
    statTittle: json["statTittle"],
    userRoleId: json["userRoleId"],
    roleId: json["roleId"],
    roleName: json["roleName"],
    userDepId: json["userDepId"],
    userDepTittle: json["userDepTittle"],
    positionId: json["positionId"],
    positionTittle: json["positionTittle"],
    userRequest: json["userRequest"],
    inviterUserFullname: json["inviterUserFullname"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "username": username,
    "fullname": fullname,
    "email": email,
    "phoneNumber": phoneNumber,
    "password": password,
    "contactId": contactId,
    "registerDate": registerDate,
    "organId": organId,
    "organName": organName,
    "submitUserId": submitUserId,
    "statId": statId,
    "statTittle": statTittle,
    "userRoleId": userRoleId,
    "roleId": roleId,
    "roleName": roleName,
    "userDepId": userDepId,
    "userDepTittle": userDepTittle,
    "positionId": positionId,
    "positionTittle": positionTittle,
    "userRequest": userRequest,
    "inviterUserFullname": inviterUserFullname,
  };
}
