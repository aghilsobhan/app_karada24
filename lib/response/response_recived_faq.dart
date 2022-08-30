// To parse this JSON data, do
//
//     final responseGetFaq = responseGetFaqFromJson(jsonString);

import 'dart:convert';

ResponseGetFaq responseGetFaqFromJson(String str) =>
    ResponseGetFaq.fromJson(json.decode(str));

String responseGetFaqToJson(ResponseGetFaq data) => json.encode(data.toJson());

class ResponseGetFaq {
  ResponseGetFaq({
    required this.iSuccess,
    required this.error,
    required this.data,
  });

  bool iSuccess;
  List<String> error;
  List<DatFaq> data;
  factory ResponseGetFaq.fromJson(Map<String, dynamic> json) => ResponseGetFaq(
        iSuccess: json["iSuccess"],
    error: json["error"]!=null?List<String>.from(json["error"].map((x) => x)):<String>[],
      data:json["data"] !=null ? List<DatFaq>.from(json["data"].map((x) => DatFaq.fromJson(x))):<DatFaq>[],
    // error: List<String>.from(json["error"].map((x) => x)),
    // data: List<DatFaq>.from(json["data"].map((x) => DatFaq.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "iSuccess": iSuccess,
        "error": error,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DatFaq {
  DatFaq({
    required this.faqId,
    required this.faqTittle,
    required this.faqStartShow,
    required this.faqEndShow,
    required this.faqProId,
    required this.faqBody,
    required this.faqUserId,
    required this.faqRegDate,
    required this.faqStatusId,
    this.expanded = false,
  });
  bool? expanded;
  int? faqId;
  String? faqTittle;
  DateTime? faqStartShow;
  DateTime? faqEndShow;
  int? faqProId;
  String? faqBody;
  int? faqUserId;
  DateTime? faqRegDate;
  int? faqStatusId;

  factory DatFaq.fromJson(Map<String, dynamic> json) => DatFaq(
        faqId: json["faqId"],
        faqTittle: json["faqTittle"],
        faqStartShow: DateTime.parse(json["faqStartShow"]),
        faqEndShow: DateTime.parse(json["faqEndShow"]),
        faqProId: json["faqProId"],
        faqBody: json["faqBody"],
        faqUserId: json["faqUserId"],
        faqRegDate: DateTime.parse(json["faqRegDate"]),
        faqStatusId: json["faqStatusId"],
      );

  Map<String, dynamic> toJson() => {
        "faqId": faqId,
        "faqTittle": faqTittle,
        "faqStartShow": faqStartShow?.toIso8601String(),
        "faqEndShow": faqEndShow?.toIso8601String(),
        "faqProId": faqProId,
        "faqBody": faqBody,
        "faqUserId": faqUserId,
        "faqRegDate": faqRegDate?.toIso8601String(),
        "faqStatusId": faqStatusId,
      };
}
