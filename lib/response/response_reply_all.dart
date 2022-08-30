// To parse this JSON data, do
//
//     final responseReciveAllReply = responseReciveAllReplyFromJson(jsonString);
//
// import 'dart:convert';
//
// ResponseReciveAllReply responseReciveAllReplyFromJson(String str) => ResponseReciveAllReply.fromJson(json.decode(str));
//
// String responseReciveAllReplyToJson(ResponseReciveAllReply data) => json.encode(data.toJson());
//
// class ResponseReciveAllReply {
//   ResponseReciveAllReply({
//     required this.isSuccess,
//     this.error,
//     required  this.data,
//   });
//
//   bool? isSuccess;
//   dynamic error;
//   Data? data;
//
//   factory ResponseReciveAllReply.fromJson(Map<String, dynamic> json) => ResponseReciveAllReply(
//     isSuccess: json["isSuccess"],
//     error: json["error"],
//     data: Data.fromJson(json["data"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "iSuccess": isSuccess,
//     "error": error,
//     "data": data!.toJson(),
//   };
// }
//
// class Data {
//   Data({
//     required this.tckId,
//     required this.tckTittle,
//     required this.tckBody,
//     required this.tckProId,
//     required this.tckOwnerId,
//     required this.tckCreatedDate,
//     required this.tckStatId,
//     required this.tckTags,
//     required this.tckPriorityId,
//     required this.tckCategoryId,
//     required this.tckIsPrivate,
//     required  this.ticketReplies,
//   });
//
//
//
//   int? tckId;
//   String? tckTittle;
//   String? tckBody;
//   int? tckProId;
//   int? tckOwnerId;
//   DateTime? tckCreatedDate;
//   int? tckStatId;
//   String? tckTags;
//   int? tckPriorityId;
//   int? tckCategoryId;
//   int? tckIsPrivate;
//   bool? tckHasFile;
//   List<TicketReply>? ticketReplies;
//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     tckId: json["tckId"],
//     tckTittle: json["tckTittle"],
//     tckBody: json["tckBody"],
//     tckProId: json["tckProId"],
//     tckOwnerId: json["tckOwnerId"],
//     tckCreatedDate: DateTime.parse(json["tckCreatedDate"]),
//     tckStatId: json["tckStatId"],
//     tckTags: json["tckTags"],
//     tckPriorityId: json["tckPriorityId"],
//     tckCategoryId: json["tckCategoryId"],
//     tckIsPrivate: json["tckIsPrivate"],
//     ticketReplies: List<TicketReply>.from(json["ticketReplies"].map((x) => TicketReply.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "tckId": tckId,
//     "tckTittle": tckTittle,
//     "tckBody": tckBody,
//     "tckProId": tckProId,
//     "tckOwnerId": tckOwnerId,
//     "tckCreatedDate": tckCreatedDate?.toIso8601String(),
//     "tckStatId": tckStatId,
//     "tckTags": tckTags,
//     "tckPriorityId": tckPriorityId,
//     "tckCategoryId": tckCategoryId,
//     "tckIsPrivate": tckIsPrivate,
//     "ticketReplies": List<dynamic>.from(ticketReplies?.map((x) => x.toJson()) as List<dynamic>),
//   };
// }
//
// class TicketReply {
//   TicketReply({
//     required this.repId,
//     required  this.repContent,
//     required this.repOwnerId,
//     required this.repOwnerType,
//     required this.repTckId,
//     required this.repIsPrivate,
//     required this.repRegDate,
//     required this.repHasFile,
//   });
//
//   int? repId;
//   String? repContent;
//   int? repOwnerId;
//   int? repOwnerType;
//   int? repTckId;
//   int? repIsPrivate;
//   bool? repHasFile;
//   DateTime? repRegDate;
//
//   factory TicketReply.fromJson(Map<String, dynamic> json) => TicketReply(
//     repId: json["repId"],
//     repContent: json["repContent"],
//     repOwnerId: json["repOwnerId"],
//     repOwnerType: json["repOwnerType"],
//     repTckId: json["repTckId"],
//     repIsPrivate: json["repIsPrivate"],
//     repHasFile: json["repHasFile"],
//     repRegDate: DateTime.parse(json["repRegDate"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "repId": repId,
//     "repContent": repContent,
//     "repOwnerId": repOwnerId,
//     "repOwnerType": repOwnerType,
//     "repTckId": repTckId,
//     "repIsPrivate": repIsPrivate,
//     "repHasFile": repHasFile,
//     "repRegDate": repRegDate?.toIso8601String(),
//   };
// }
// To parse this JSON data, do
//
//     final responseReciveAllReply = responseReciveAllReplyFromJson(jsonString);

import 'dart:convert';

ResponseReciveAllReply responseReciveAllReplyFromJson(String str) => ResponseReciveAllReply.fromJson(json.decode(str));

String responseReciveAllReplyToJson(ResponseReciveAllReply data) => json.encode(data.toJson());

class ResponseReciveAllReply {
  ResponseReciveAllReply({
    required this.isSuccess,
    this.error,
    required this.data,
  });

  bool isSuccess;
  dynamic error;
  Data data;

  factory ResponseReciveAllReply.fromJson(Map<String, dynamic> json) => ResponseReciveAllReply(
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
    required this.tckId,
    required this.tckTittle,
    required this.tckBody,
    required this.tckProId,
    required this.tckOwnerId,
    required this.tckCreatedDate,
    required this.tckStatId,
    required this.tckTags,
    required this.tckPriorityId,
    required this.tckCategoryId,
    required this.tckIsPrivate,
    required this.tckHasFile,
    required  this.ticketReplies,
  });

  int tckId;
  String tckTittle;
  String tckBody;
  int tckProId;
  int tckOwnerId;
  DateTime tckCreatedDate;
  int tckStatId;
  String tckTags;
  int tckPriorityId;
  int tckCategoryId;
  int tckIsPrivate;
  bool tckHasFile;
  List<TicketReply> ticketReplies;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tckId: json["tckId"],
    tckTittle: json["tckTittle"],
    tckBody: json["tckBody"],
    tckProId: json["tckProId"],
    tckOwnerId: json["tckOwnerId"],
    tckCreatedDate: DateTime.parse(json["tckCreatedDate"]),
    tckStatId: json["tckStatId"],
    tckTags: json["tckTags"],
    tckPriorityId: json["tckPriorityId"],
    tckCategoryId: json["tckCategoryId"],
    tckIsPrivate: json["tckIsPrivate"],
    tckHasFile: json["tckHasFile"],
    ticketReplies: List<TicketReply>.from(json["ticketReplies"].map((x) => TicketReply.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tckId": tckId,
    "tckTittle": tckTittle,
    "tckBody": tckBody,
    "tckProId": tckProId,
    "tckOwnerId": tckOwnerId,
    "tckCreatedDate": tckCreatedDate.toIso8601String(),
    "tckStatId": tckStatId,
    "tckTags": tckTags,
    "tckPriorityId": tckPriorityId,
    "tckCategoryId": tckCategoryId,
    "tckIsPrivate": tckIsPrivate,
    "tckHasFile": tckHasFile,
    "ticketReplies": List<dynamic>.from(ticketReplies.map((x) => x.toJson())),
  };
}

class TicketReply {
  TicketReply({
   required this.repId,
    required  this.repContent,
    required  this.repOwnerId,
    required this.repOwnerType,
    required this.repTckId,
    required this.repIsPrivate,
    required this.repRegDate,
    required this.repHasFile,
  });

  int repId;
  String repContent;
  int repOwnerId;
  int repOwnerType;
  int repTckId;
  int repIsPrivate;
  DateTime repRegDate;
  bool repHasFile;

  factory TicketReply.fromJson(Map<String, dynamic> json) => TicketReply(
    repId: json["repId"],
    repContent: json["repContent"],
    repOwnerId: json["repOwnerId"],
    repOwnerType: json["repOwnerType"],
    repTckId: json["repTckId"],
    repIsPrivate: json["repIsPrivate"],
    repRegDate: DateTime.parse(json["repRegDate"]),
    repHasFile: json["repHasFile"],
  );

  Map<String, dynamic> toJson() => {
    "repId": repId,
    "repContent": repContent,
    "repOwnerId": repOwnerId,
    "repOwnerType": repOwnerType,
    "repTckId": repTckId,
    "repIsPrivate": repIsPrivate,
    "repRegDate": repRegDate.toIso8601String(),
    "repHasFile": repHasFile,
  };
}
