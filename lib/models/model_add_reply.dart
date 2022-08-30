// To parse this JSON data, do
//
//     final modelSendReply = modelSendReplyFromJson(jsonString);

import 'dart:convert';

ModelSendReply modelSendReplyFromJson(String str) => ModelSendReply.fromJson(json.decode(str));

String modelSendReplyToJson(ModelSendReply data) => json.encode(data.toJson());

class ModelSendReply {
  ModelSendReply({
    required this.repId,
    required  this.repContent,
    required this.repOwnerId,
    required this.repOwnerType,
    required this.repTckId,
    required this.repIsPrivate,
    required this.repSeen,
    required this.repHasFile,
    required this.repDescription,
    required this.repRegDate,
  });


  int? repId;
  String? repContent;
  int? repOwnerId;
  int? repOwnerType;
  int? repTckId;
  int? repIsPrivate;
  bool? repSeen;
  bool? repHasFile;
  String? repDescription;
  String? repRegDate;

  factory ModelSendReply.fromJson(Map<String, dynamic> json) => ModelSendReply(
    repId: json["repId"],
    repContent: json["repContent"],
    repOwnerId: json["repOwnerId"],
    repOwnerType: json["repOwnerType"],
    repTckId: json["repTckId"],
    repIsPrivate: json["repIsPrivate"],
    repSeen: json["repSeen"],
    repHasFile: json["repHasFile"],
    repDescription: json["repDescription"],
    repRegDate: json["repRegDate"],
  );

  Map<String, dynamic> toJson() => {
    "repId": repId,
    "repContent": repContent,
    "repOwnerId": repOwnerId,
    "repOwnerType": repOwnerType,
    "repTckId": repTckId,
    "repIsPrivate": repIsPrivate,
    "repSeen": repSeen,
    "repHasFile": repHasFile,
    "repDescription": repDescription,
  };
}
