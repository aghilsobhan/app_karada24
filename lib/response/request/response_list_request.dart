// To parse this JSON data, do
//
//     final responseListRequest = responseListRequestFromJson(jsonString);

import 'dart:convert';

class ResponseListRequest {
  ResponseListRequest({
    this.isSuccess,
    this.errors,
    this.data,
  });

  bool? isSuccess;
  List<String>? errors;
  List<DataListRequest>? data;

  factory ResponseListRequest.fromJson(Map<String, dynamic> json) => ResponseListRequest(
    isSuccess: json["isSuccess"],
    errors: json["errors"]!=null?List<String>.from(json["errors"].map((x) => x)):<String>[],
    data:json["data"] !=null ? List<DataListRequest>.from(json["data"].map((x) => DataListRequest.fromJson(x))):<DataListRequest>[],

  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errors": errors,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataListRequest {
  DataListRequest({
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
    this.roleId,
    this.roleName,
    this.userDepId,
    this.userDepTittle,
    this.positionId,
    this.positionTittle,
    this.userRequest,
    this.isSend=false
  });

  int? userId;
  String? username;
  String? fullname;
  String? email;
  String? phoneNumber;
  String? password;
  int? contactId;
  String? registerDate;
  int? organId;
  String? organName;
  int? submitUserId;
  int? statId;
  String? statTittle;
  int? roleId;
  String? roleName;
  int? userDepId;
  String? userDepTittle;
  int? positionId;
 String? positionTittle;
  String? userRequest;
  bool? isSend;

  factory DataListRequest.fromJson(Map<String, dynamic> json) => DataListRequest(
    userId: json["userId"],
    username: json["username"],
    fullname: json["fullname"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    password: json["password"],
    contactId: json["contactId"],
    registerDate: json["registerDate"],
    organId: json["organId"],
    organName: json["organName"],
    submitUserId: json["submitUserId"],
    statId: json["statId"],
    statTittle: json["statTittle"],
    roleId: json["roleId"],
    roleName: json["roleName"],
    userDepId: json["userDepId"],
    userDepTittle: json["userDepTittle"],
    positionId: json["positionId"],
    positionTittle: json["positionTittle"],
    userRequest: json["userRequest"],
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
    "roleId": roleId,
    "roleName": roleName,
    "userDepId": userDepId,
    "userDepTittle": userDepTittle,
    "positionId": positionId,
    "positionTittle": positionTittle,
    "userRequest": userRequest,
  };
}
