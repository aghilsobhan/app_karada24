
import 'dart:convert';

import 'package:app_karada24/models/model_error_data.dart';
List<DataTicket> productFromJson(String str) =>
    List<DataTicket>.from(json.decode(str).map((x) => DataTicket.fromJson(x)));

class ResponseGetAllTicket {
  ResponseGetAllTicket({
    required this.isSuccess,
    this.error,
    this.data,
  });

  bool isSuccess;
  List<String>? error;
  List<DataTicket>? data;
  factory ResponseGetAllTicket.fromJson(Map<String, dynamic> json) => ResponseGetAllTicket(
    isSuccess: json["isSuccess"],
    error: json["error"]!=null?List<String>.from(json["error"].map((x) => x)):<String>[],
      data:json["data"] !=null ? List<DataTicket>.from(json["data"].map((x) => DataTicket.fromJson(x))):<DataTicket>[],
    //data: List<DataTicket>.from(json["data"].map((x) => DataTicket.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "error": error,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataTicket{
  DataTicket({
    this.tckId,
    this.tckTittle,
    this.tckBody,
    this.tckProId,
    this.productName,
    this.tckOwnerId,
    this.username,
    this.tckCreatedDate,
    this.tckStatId,
    this.tckOrganId,
    this.statTittle,
    this.tckTags,
    this.tckPriorityId,
    this.prioTittle,
    this.tckCategoryId,
    this.catTittle,
    this.tckisPrivate,
    this.tckHasFile,
    this.newReplyCount,
    this.roleId,
    this.roleTittle,
    this.onwerUsername,
    this.ownerFullname,
    this.responsibleUserId

  });

  int? tckId;
  String? tckTittle;
  String? tckBody;
  int? tckProId;
  String? productName;
  int? tckOwnerId;
  String? username;
  DateTime? tckCreatedDate;
  int? tckStatId;
  int? tckOrganId;
  String? statTittle;
  String? tckTags;
  int? tckPriorityId;
  String? prioTittle;
  int? tckCategoryId;
  String? catTittle;
  int? tckisPrivate;
  bool? tckHasFile;
  int? newReplyCount;
  int? roleId;
  dynamic roleTittle;
  String? onwerUsername;
  String? ownerFullname;
  int? responsibleUserId;

  factory DataTicket.fromJson(Map<String, dynamic> json) => DataTicket(
    tckId: json["tckId"],
    tckTittle: json["tckTittle"],
    tckBody: json["tckBody"],
    tckProId: json["tckProId"],
    productName: json["productName"],
    tckOwnerId: json["tckOwnerId"],
    username: json["username"],
    tckCreatedDate: DateTime.parse(json["tckCreatedDate"]),
    tckStatId: json["tckStatId"],
    statTittle: json["statTittle"],
    tckTags: json["tckTags"],
    tckPriorityId: json["tckPriorityId"],
    prioTittle: json["prioTittle"],
    tckCategoryId: json["tckCategoryId"],
    catTittle: json["catTittle"],
    tckisPrivate: json["tckisPrivate"],
    newReplyCount: json["newReplyCount"],
      tckHasFile:json["tckHasFile"],
    roleId:json["roleId"],
    roleTittle:json["roleTittle"],
    onwerUsername:json["onwerUsername"],
    ownerFullname:json["ownerFullname"],
    responsibleUserId:json["responsibleUserId"],
  );

  Map<String, dynamic> toJson() => {
    "tckId": tckId,
    "tckTittle": tckTittle,
    "tckBody": tckBody,
    "tckProId": tckProId,
    "productName": productName,
    "tckOwnerId": tckOwnerId,
    "username": username,
    "tckCreatedDate": tckCreatedDate?.toIso8601String(),
    "tckStatId": tckStatId,
    "statTittle": statTittle,
    "tckTags": tckTags,
    "tckPriorityId": tckPriorityId,
    "prioTittle": prioTittle,
    "tckCategoryId": tckCategoryId,
    "catTittle": catTittle,
    "tckisPrivate": tckisPrivate,
    "newReplyCount": newReplyCount,
    "tckHasFile":tckHasFile,
    "onwerUsername":onwerUsername,
    "ownerFullname":ownerFullname,
    "responsibleUserId":responsibleUserId
  };
}
