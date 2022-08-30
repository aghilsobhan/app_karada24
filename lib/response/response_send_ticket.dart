// To parse this JSON data, do
//
//     final responseSendTicket = responseSendTicketFromJson(jsonString);

import 'dart:convert';

ResponseSendTicket responseSendTicketFromJson(String str) => ResponseSendTicket.fromJson(json.decode(str));

String responseSendTicketToJson(ResponseSendTicket data) => json.encode(data.toJson());

class ResponseSendTicket {
  ResponseSendTicket({
    required this.isSuccess,
    required this.error,
    required this.data,
  });

  bool isSuccess;
  List<dynamic> error;
  DataReciveSendTicket data;

  factory ResponseSendTicket.fromJson(Map<String, dynamic> json) => ResponseSendTicket(
    isSuccess: json["isSuccess"],
      error:json["error"]!=null?List<String>.from(json["error"].map((x) => x)):<String>[],
    data: DataReciveSendTicket.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "error": List<dynamic>.from(error.map((x) => x)),
    "data": data.toJson(),
  };
}

class DataReciveSendTicket {
  DataReciveSendTicket({
    required this.tckId,
    required this.tckTittle,
    required this.tckBody,
    required this.tckProId,
    required this.tckuserId,
    required this.tckCreatedDate,
    required this.tckstatId,
    required this.tckTags,
    required this.tckpriorityId,
    required this.tckCategoryId,
    required this.tckisPrivate,
    this.tckCategory,
    this.tckpriority,
    this.tckstat,
    required this.ticketReplies,
    this.ticketVisitors,
    this.ticketReferrals,
  });

  int? tckId;
  String? tckTittle;
  String? tckBody;
  int? tckProId;
  int? tckuserId;
  DateTime? tckCreatedDate;
  int? tckstatId;
  String? tckTags;
  int? tckpriorityId;
  int? tckCategoryId;
  bool? tckisPrivate;
  dynamic tckCategory;
  dynamic tckpriority;
  dynamic tckstat;
  List<dynamic>? ticketReplies;
  dynamic ticketVisitors;
  dynamic ticketReferrals;


  factory DataReciveSendTicket.fromJson(Map<String, dynamic> json) => DataReciveSendTicket(
    tckId: json["tckId"],
    tckTittle: json["tckTittle"],
    tckBody: json["tckBody"],
    tckProId: json["tckProId"],
    tckuserId: json["tckuserId"],
    tckCreatedDate: DateTime.parse(json["tckCreatedDate"]),
    tckstatId: json["tckstatId"],
    tckTags: json["tckTags"],
    tckpriorityId: json["tckpriorityId"],
    tckCategoryId: json["tckCategoryId"],
    tckisPrivate: json["tckisPrivate"],
    tckCategory: json["tckCategory"],
    tckpriority: json["tckpriority"],
    tckstat: json["tckstat"],
    ticketReplies: List<dynamic>.from(json["ticketReplies"].map((x) => x)),
    ticketVisitors: json["ticketVisitors"],
    ticketReferrals: json["ticketReferrals"],
  );

  Map<String, dynamic> toJson() => {
    "tckId": tckId,
    "tckTittle": tckTittle,
    "tckBody": tckBody,
    "tckProId": tckProId,
    "tckuserId": tckuserId,
    "tckCreatedDate": tckCreatedDate?.toIso8601String(),
    "tckstatId": tckstatId,
    "tckTags": tckTags,
    "tckpriorityId": tckpriorityId,
    "tckCategoryId": tckCategoryId,
    "tckisPrivate": tckisPrivate,
    "tckCategory": tckCategory,
    "tckpriority": tckpriority,
    "tckstat": tckstat,
    "ticketReplies": List<dynamic>.from(ticketReplies?.map((x) => x) as List<dynamic>) ,
    "ticketVisitors": ticketVisitors,
    "ticketReferrals": ticketReferrals,
  };
}
