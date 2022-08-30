// To parse this JSON data, do
//
//     final responseRegister = responseRegisterFromJson(jsonString);

import 'dart:convert';

ResponseRegister responseRegisterFromJson(String str) => ResponseRegister.fromJson(json.decode(str));

String responseRegisterToJson(ResponseRegister data) => json.encode(data.toJson());

class ResponseRegister {
  ResponseRegister({
    required this.data,
    required this.isSuccess,
    required this.errors,
  });

  bool isSuccess;
  List<String>? errors;
  int? data;

  factory ResponseRegister.fromJson(Map<String, dynamic> json) => ResponseRegister(
      isSuccess: json["isSuccess"],
      errors:json["errors"]!=null?List<String>.from(json["errors"].map((x) => x)):<String>[],
      data:json["data"]
  );

  Map<String, dynamic> toJson() => {

    "isSuccess": isSuccess,
    "erorrs": List<dynamic>.from(errors!.map((x) => x)),
    "data":data,
  };
}
