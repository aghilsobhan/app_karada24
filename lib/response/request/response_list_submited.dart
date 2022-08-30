// class ResponseListSubmitted {
//   ResponseListSubmitted({
//     this.isSuccess,
//     this.errors,
//     this.data,
//   });
//
//   bool? isSuccess;
//   List<String>? errors;
//   List<DataListSubmitted>? data;
//
//   factory ResponseListSubmitted.fromJson(Map<String, dynamic> json) => ResponseListSubmitted(
//     isSuccess: json["isSuccess"],
//     errors: json["errors"]!=null?List<String>.from(json["errors"].map((x) => x)):<String>[],
//     data:json["data"] !=null ? List<DataListSubmitted>.from(json["data"].map((x) => DataListSubmitted.fromJson(x))):<DataListSubmitted>[],
//
//   );
//
//   Map<String, dynamic> toJson() => {
//     "isSuccess": isSuccess,
//     "errors": errors,
//     "data": List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
//
// class DataListSubmitted {
//   DataListSubmitted({
//     this.id,
//     this.registerDate,
//     this.confirmedDate,
//     this.typeId,
//     this.typeTittle,
//     this.statusId,
//     this.statusTittle,
//     this.description,
//     this.srcUserId,
//     this.srcUsername,
//     this.srcUserFullname,
//     this.dstUserId,
//     this.dstUsername,
//     this.dstUserFullname,
//     this.response,
//     this.currentUserRoleId,
//     this.currentUserRoleTittle,
//     this.userJobTittle,
//     this.userDepartment,
//     this.isSend=false
//   });
//
//   int? id;
//   String? registerDate;
//   dynamic confirmedDate;
//   int? typeId;
//   String? typeTittle;
//   int? statusId;
//   String? statusTittle;
//   String? description;
//   int? srcUserId;
//   dynamic srcUsername;
//   dynamic srcUserFullname;
//   int? dstUserId;
//   String? dstUsername;
//   dynamic dstUserFullname;
//   dynamic response;
//   int? currentUserRoleId;
//   dynamic currentUserRoleTittle;
//   dynamic userJobTittle;
//   dynamic userDepartment;
//   bool? isSend;
//
//   factory DataListSubmitted.fromJson(Map<String, dynamic> json) => DataListSubmitted(
//     id: json["id"],
//     registerDate: json["registerDate"],
//     confirmedDate: json["confirmedDate"],
//     typeId: json["typeId"],
//     typeTittle: json["typeTittle"],
//     statusId: json["statusId"],
//     statusTittle: json["statusTittle"],
//     description: json["description"],
//     srcUserId: json["srcUserId"],
//     srcUsername: json["srcUsername"],
//     srcUserFullname: json["srcUserFullname"],
//     dstUserId: json["dstUserId"],
//     dstUsername: json["dstUsername"],
//     dstUserFullname: json["dstUserFullname"],
//     response: json["response"],
//     currentUserRoleId: json["currentUserRoleId"],
//     currentUserRoleTittle: json["currentUserRoleTittle"],
//     userJobTittle: json["userJobTittle"],
//     userDepartment: json["userDepartment"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "registerDate": registerDate,
//     "confirmedDate": confirmedDate,
//     "typeId": typeId,
//     "typeTittle": typeTittle,
//     "statusId": statusId,
//     "statusTittle": statusTittle,
//     "description": description,
//     "srcUserId": srcUserId,
//     "srcUsername": srcUsername,
//     "srcUserFullname": srcUserFullname,
//     "dstUserId": dstUserId,
//     "dstUsername": dstUsername,
//     "dstUserFullname": dstUserFullname,
//     "response": response,
//     "currentUserRoleId": currentUserRoleId,
//     "currentUserRoleTittle": currentUserRoleTittle,
//     "userJobTittle": userJobTittle,
//     "userDepartment": userDepartment,
//   };
// }
// To parse this JSON data, do
//
//     final responseListSubmitted = responseListSubmittedFromJson(jsonString);

import 'dart:convert';

ResponseListSubmitted responseListSubmittedFromJson(String str) => ResponseListSubmitted.fromJson(json.decode(str));

String responseListSubmittedToJson(ResponseListSubmitted data) => json.encode(data.toJson());

class ResponseListSubmitted {
  ResponseListSubmitted({
    this.isSuccess,
    this.errors,
    this.data,
  });

  bool? isSuccess;
  List<String>? errors;
  List<DataListSubmitted>? data;

  factory ResponseListSubmitted.fromJson(Map<String, dynamic> json) => ResponseListSubmitted(
    isSuccess: json["isSuccess"],
    errors: json["errors"]!=null?List<String>.from(json["errors"].map((x) => x)):<String>[],
    data:json["data"] !=null ? List<DataListSubmitted>.from(json["data"].map((x) => DataListSubmitted.fromJson(x))):<DataListSubmitted>[],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errors": errors,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataListSubmitted {
  DataListSubmitted({
    this.id,
    this.registerDate,
    this.confirmedDate,
    this.typeId,
    this.typeTittle,
    this.statusId,
    this.statusTittle,
    this.description,
    this.srcUserId,
    this.srcUsername,
    this.srcUserFullname,
    this.dstUserId,
    this.dstUsername,
    this.dstUserFullname,
    this.response,
    this.roleId,
    this.roleTittle,
    this.userJobTittle,
    this.userDepartment,
  });

  int? id;
  DateTime? registerDate;
  dynamic confirmedDate;
  int? typeId;
  String? typeTittle;
  int? statusId;
  String? statusTittle;
  dynamic description;
  int? srcUserId;
  String? srcUsername;
  String? srcUserFullname;
  int? dstUserId;
  dynamic dstUsername;
  dynamic dstUserFullname;
  dynamic response;
  int? roleId;
  String? roleTittle;
  String? userJobTittle;
  String? userDepartment;

  factory DataListSubmitted.fromJson(Map<String, dynamic> json) => DataListSubmitted(
    id: json["id"],
    registerDate: DateTime.parse(json["registerDate"]),
    confirmedDate: json["confirmedDate"],
    typeId: json["typeId"],
    typeTittle: json["typeTittle"],
    statusId: json["statusId"],
    statusTittle: json["statusTittle"],
    description: json["description"],
    srcUserId: json["srcUserId"],
    srcUsername: json["srcUsername"],
    srcUserFullname: json["srcUserFullname"],
    dstUserId: json["dstUserId"],
    dstUsername: json["dstUsername"],
    dstUserFullname: json["dstUserFullname"],
    response: json["response"],
    roleId: json["roleId"],
    roleTittle: json["roleTittle"],
    userJobTittle: json["userJobTittle"],
    userDepartment: json["userDepartment"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "registerDate": registerDate!.toIso8601String(),
    "confirmedDate": confirmedDate,
    "typeId": typeId,
    "typeTittle": typeTittle,
    "statusId": statusId,
    "statusTittle": statusTittle,
    "description": description,
    "srcUserId": srcUserId,
    "srcUsername": srcUsername,
    "srcUserFullname": srcUserFullname,
    "dstUserId": dstUserId,
    "dstUsername": dstUsername,
    "dstUserFullname": dstUserFullname,
    "response": response,
    "roleId": roleId,
    "roleTittle": roleTittle,
    "userJobTittle": userJobTittle,
    "userDepartment": userDepartment,
  };
}
