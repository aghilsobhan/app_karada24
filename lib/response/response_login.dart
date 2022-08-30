
// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) => ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    required this.userId,
    required this.userRoleId,
    required this.token,
    required this.refreshToken,
    required this.isSuccess,
    this.erorrs,
    this.isAdmin,
    this.isCustomer,
    this.isExpert,
    this.isGuest,
    this.isSuperAdmin,
    this.validationCode,
    this.roleId,
  });

  int? userId;
  int? userRoleId;
  dynamic token;
  dynamic refreshToken;
  bool? isSuccess;
  List<String>? erorrs;
  bool? isSuperAdmin;
  bool? isAdmin;
  bool? isExpert;
  bool? isCustomer;
  bool? isGuest;
  int? validationCode;
  int?  roleId;
  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
    userId: json["userId"],
      userRoleId: json["userRoleId"],
    token: json["token"],
    refreshToken: json["refreshToken"],
    isSuccess: json["isSuccess"],
      isSuperAdmin: json["isSuperAdmin"],
      isAdmin: json["isAdmin"],
      isExpert: json["isExpert"],
      isCustomer: json["isCustomer"],
      isGuest: json["isGuest"],
      validationCode: json["validationCode"],
      roleId: json["roleId"],
    erorrs:json["erorrs"]!=null?List<String>.from(json["erorrs"].map((x) => x)):<String>[]
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userRoleId": userRoleId,
    "token": token,
    "refreshToken": refreshToken,
    "isSuccess": isSuccess,
    "isSuperAdmin": isSuperAdmin,
    "isAdmin": isAdmin,
    "isExpert": isExpert,
    "isCustomer": isCustomer,
    "isGuest": isGuest,
    "validationCode": validationCode,
    "roleId": roleId,
    "erorrs": List<dynamic>.from(erorrs!.map((x) => x)),
  };
}
