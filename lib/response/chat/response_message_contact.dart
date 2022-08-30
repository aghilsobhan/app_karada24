// To parse this JSON data, do
//
//     final responseMessageContact = responseMessageContactFromJson(jsonString);

import 'dart:convert';

import 'package:app_karada24/screen/chat_page/model/model_received_chat.dart';

ResponseMessageContact responseMessageContactFromJson(String str) => ResponseMessageContact.fromJson(json.decode(str));

String responseMessageContactToJson(ResponseMessageContact data) => json.encode(data.toJson());

class ResponseMessageContact {
  ResponseMessageContact({
    this.isSuccess,
    this.errors,
    this.data,
  });

  bool? isSuccess;
  List<String>? errors;
  List<ModelRecivedMessageBool>? data;

  factory ResponseMessageContact.fromJson(Map<String, dynamic> json) => ResponseMessageContact(
    isSuccess: json["isSuccess"],
    errors: json["errors"]!=null?List<String>.from(json["errors"].map((x) => x)):<String>[],
    data:json["data"] !=null ? List<ModelRecivedMessageBool>.from(json["data"].map((x) => ModelRecivedMessageBool.fromJson(x))):<ModelRecivedMessageBool>[],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errors": List<dynamic>.from(errors!.map((x) => x)),
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

