// To parse this JSON data, do
//
//     final modelGetReceivedContact = modelGetReceivedContactFromJson(jsonString);

import 'dart:convert';

ModelGetReceivedContact modelGetReceivedContactFromJson(String str) => ModelGetReceivedContact.fromJson(json.decode(str));

String modelGetReceivedContactToJson(ModelGetReceivedContact data) => json.encode(data.toJson());

class ModelGetReceivedContact {
  ModelGetReceivedContact({
    this.userId,
    this.roleId,
    this.orgId,
  });

  int? userId;
  int? roleId;
  int? orgId;

  factory ModelGetReceivedContact.fromJson(Map<String, dynamic> json) => ModelGetReceivedContact(
    userId: json["userId"],
    roleId: json["roleId"],
    orgId: json["orgId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "roleId": roleId,
    "orgId": orgId,
  };
}
