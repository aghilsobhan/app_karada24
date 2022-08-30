// To parse this JSON data, do
//
//     final responseGetFaq = responseGetFaqFromJson(jsonString);

import 'dart:convert';

ResponseGetForgetPassword responseGetFaqFromJson(String str) =>
    ResponseGetForgetPassword.fromJson(json.decode(str));

String responseGetFaqToJson(ResponseGetForgetPassword data) => json.encode(data.toJson());

class ResponseGetForgetPassword {
  ResponseGetForgetPassword({
    required this.isSuccess,
    required this.erorrs,
  });

  bool? isSuccess;
  List<String>? erorrs;
  factory ResponseGetForgetPassword.fromJson(Map<String, dynamic> json) => ResponseGetForgetPassword(
    isSuccess: json["isSuccess"],
    erorrs: json["erorrs"]!=null?List<String>.from(json["erorrs"].map((x) => x)):<String>[],

  );

  Map<String, dynamic> toJson() => {
    "iSuccess": isSuccess,
    "erorrs": erorrs,
  };
}

