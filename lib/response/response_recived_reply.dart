// To parse this JSON data, do
//
//     final responseReciveReply = responseReciveReplyFromJson(jsonString);

import 'dart:convert';

ResponseReciveReply responseReciveReplyFromJson(String str) => ResponseReciveReply.fromJson(json.decode(str));

String responseReciveReplyToJson(ResponseReciveReply data) => json.encode(data.toJson());

class ResponseReciveReply {
  ResponseReciveReply({
    required this.isSuccess,
    this.error,
    required this.data,
  });

  bool isSuccess;
  dynamic error;
  Data data;

  factory ResponseReciveReply.fromJson(Map<String, dynamic> json) => ResponseReciveReply(
    isSuccess: json["isSuccess"],
    error: json["error"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "error": error,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.repId,
    required this.repContent,
    required this.repUserId,
    required this.repUserType,
    required this.reptckId,
    required this.repisPrivate,
    required this.repRegDate,
    required this.reptck,
  });

  int? repId;
  String? repContent;
  int? repUserId;
  int? repUserType;
  int? reptckId;
  bool? repisPrivate;
  DateTime? repRegDate;
  dynamic? reptck;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    repId: json["repId"],
    repContent: json["repContent"],
    repUserId: json["repUserId"],
    repUserType: json["repUserType"],
    reptckId: json["reptckId"],
    repisPrivate: json["repisPrivate"],
    repRegDate: DateTime.parse(json["repRegDate"]),
    reptck: json["reptck"],
  );

  Map<String, dynamic> toJson() => {
    "repId": repId,
    "repContent": repContent,
    "repUserId": repUserId,
    "repUserType": repUserType,
    "reptckId": reptckId,
    "repisPrivate": repisPrivate,
    "repRegDate": repRegDate?.toIso8601String(),
    "reptck": reptck,
  };
}
