// To parse this JSON data, do
//
//     final responseGetGuestLinkedCustomer = responseGetGuestLinkedCustomerFromJson(jsonString);

import 'dart:convert';


class ResponseGetGuestLinkedCustomer {
  ResponseGetGuestLinkedCustomer({
    this.isSuccess,
    this.errors,
    this.data,
  });

  bool? isSuccess;
  List<dynamic>? errors;
  List<DataGetGuestLinkedCustomer>? data;

  factory ResponseGetGuestLinkedCustomer.fromJson(Map<String, dynamic> json) => ResponseGetGuestLinkedCustomer(
    isSuccess: json["isSuccess"],
    errors: json["errors"]!=null?List<String>.from(json["errors"].map((x) => x)):<dynamic>[],
    data:json["data"] !=null ? List<DataGetGuestLinkedCustomer>.from(json["data"].map((x) => DataGetGuestLinkedCustomer.fromJson(x))):<DataGetGuestLinkedCustomer>[],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errors": errors,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };

}

class DataGetGuestLinkedCustomer {
  DataGetGuestLinkedCustomer({
    this.userId,
    this.userRoleId,
    this.username,
    this.fullname,
    this.organId,
    this.organName,
    this.roleId,
    this.roleName,
    this.userDepId,
    this.userDepTittle,
    this.positionId,
    this.positionTittle,

  });

  int? userId;
  int? userRoleId;
  String? username;
  String? fullname;
  int? organId;
  String? organName;
  int? roleId;
  String? roleName;
  int? userDepId;
  dynamic userDepTittle;
  int? positionId;
  dynamic positionTittle;


  factory DataGetGuestLinkedCustomer.fromJson(Map<String, dynamic> json) => DataGetGuestLinkedCustomer(
    userId: json["userId"],
    userRoleId: json["userRoleId"],
    username: json["username"],
    fullname: json["fullname"],
    roleId: json["roleId"],
    roleName: json["roleName"],
    organId: json["organId"],
    organName: json["organName"],
    userDepId: json["userDepId"],
    userDepTittle: json["userDepTittle"],
    positionId: json["positionId"],
    positionTittle: json["positionTittle"],
  );
  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userRoleId": userRoleId,
    "username": username,
    "fullname": fullname,
    "roleId": roleId,
    "roleName": roleName,
    "organId": organId,
    "organName": organName,
    "userDepId": userDepId,
    "userDepTittle": userDepTittle,
    "positionId": positionId,
    "positionTittle": positionTittle,
  };

}

// To parse this JSON data, do
//
//     final responseGetCustomerLinkedExperts = responseGetCustomerLinkedExpertsFromJson(jsonString);

// ResponseGetCustomerLinkedExperts responseGetCustomerLinkedExpertsFromJson(String str) => ResponseGetCustomerLinkedExperts.fromJson(json.decode(str));
//
// String responseGetCustomerLinkedExpertsToJson(ResponseGetCustomerLinkedExperts data) => json.encode(data.toJson());
//
// class ResponseGetCustomerLinkedExperts {
//   ResponseGetCustomerLinkedExperts({
//     this.isSuccess,
//     this.errors,
//     this.data,
//   });
//
//   bool? isSuccess;
//   List<dynamic>? errors;
//   List<DataGetCustomerLinkedExperts>? data;
//
//   factory ResponseGetCustomerLinkedExperts.fromJson(Map<String, dynamic> json) => ResponseGetCustomerLinkedExperts(
//     isSuccess: json["isSuccess"],
//     errors: json["errors"],
//     data: List<DataGetCustomerLinkedExperts>.from(json["data"].map((x) => DataGetCustomerLinkedExperts.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "isSuccess": isSuccess,
//     "errors": errors,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class DataGetCustomerLinkedExperts {
//   DataGetCustomerLinkedExperts({
//     this.userId,
//     this.username,
//     this.fullname,
//     this.email,
//     this.phoneNumber,
//     this.password,
//     this.contactId,
//     this.registerDate,
//     this.organId,
//     this.organName,
//     this.submitUserId,
//     this.statId,
//     this.statTittle,
//     this.userRoleId,
//     this.roleId,
//     this.roleName,
//     this.userDepId,
//     this.userDepTittle,
//     this.positionId,
//     this.positionTittle,
//     this.userRequest,
//     this.inviterUserFullname,
//   });
//
//   int userId;
//   String username;
//   String fullname;
//   dynamic email;
//   dynamic phoneNumber;
//   dynamic password;
//   int contactId;
//   DateTime registerDate;
//   int organId;
//   dynamic organName;
//   int submitUserId;
//   int statId;
//   String statTittle;
//   int userRoleId;
//   int roleId;
//   String roleName;
//   int userDepId;
//   String userDepTittle;
//   int positionId;
//   String positionTittle;
//   dynamic userRequest;
//   dynamic inviterUserFullname;
//
//   factory DataGetCustomerLinkedExperts.fromJson(Map<String, dynamic> json) => DataGetCustomerLinkedExperts(
//     userId: json["userId"],
//     username: json["username"],
//     fullname: json["fullname"],
//     email: json["email"],
//     phoneNumber: json["phoneNumber"],
//     password: json["password"],
//     contactId: json["contactId"],
//     registerDate: DateTime.parse(json["registerDate"]),
//     organId: json["organId"],
//     organName: json["organName"],
//     submitUserId: json["submitUserId"],
//     statId: json["statId"],
//     statTittle: json["statTittle"],
//     userRoleId: json["userRoleId"],
//     roleId: json["roleId"],
//     roleName: json["roleName"],
//     userDepId: json["userDepId"],
//     userDepTittle: json["userDepTittle"],
//     positionId: json["positionId"],
//     positionTittle: json["positionTittle"],
//     userRequest: json["userRequest"],
//     inviterUserFullname: json["inviterUserFullname"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "userId": userId,
//     "username": username,
//     "fullname": fullname,
//     "email": email,
//     "phoneNumber": phoneNumber,
//     "password": password,
//     "contactId": contactId,
//     "registerDate": registerDate.toIso8601String(),
//     "organId": organId,
//     "organName": organName,
//     "submitUserId": submitUserId,
//     "statId": statId,
//     "statTittle": statTittle,
//     "userRoleId": userRoleId,
//     "roleId": roleId,
//     "roleName": roleName,
//     "userDepId": userDepId,
//     "userDepTittle": userDepTittle,
//     "positionId": positionId,
//     "positionTittle": positionTittle,
//     "userRequest": userRequest,
//     "inviterUserFullname": inviterUserFullname,
//   };
// }

