// To parse this JSON data, do
//
//     final responseSendFile = responseSendFileFromJson(jsonString);

import 'dart:convert';

ResponseSendFile responseSendFileFromJson(String str) => ResponseSendFile.fromJson(json.decode(str));

String responseSendFileToJson(ResponseSendFile data) => json.encode(data.toJson());

class ResponseSendFile {
  ResponseSendFile({
    required this.isSuccess,
    required this.error,
    required this.data,
  });

  bool isSuccess;
  List<String> error;
  List<String> data;

  factory ResponseSendFile.fromJson(Map<String, dynamic> json) => ResponseSendFile(
    isSuccess: json["isSuccess"],
      error:json["erorr"]!=null?List<String>.from(json["erorr"].map((x) => x)):<String>[],
      data: json["data"]!=null?List<String>.from(json["data"].map((x) => x)):<String>[],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "error": List<dynamic>.from(error.map((x) => x)),
    "data": List<dynamic>.from(data.map((x) => x)),
  };
}
