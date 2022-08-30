// To parse this JSON data, do
//
//     final responseReceivedContact = responseReceivedContactFromJson(jsonString);

import 'dart:convert';

import 'package:app_karada24/screen/chat_page/model/model_received_chat.dart';

ResponseReceivedContactChat responseReceivedContactFromJson(String str) => ResponseReceivedContactChat.fromJson(json.decode(str));

String responseReceivedContactToJson(ResponseReceivedContactChat data) => json.encode(data.toJson());

class ResponseReceivedContactChat {
  ResponseReceivedContactChat({
    this.isSuccess,
    this.errors,
    this.data,
  });

  bool? isSuccess;
  List<dynamic>? errors;
  List<DataContactChat>? data;

  factory ResponseReceivedContactChat.fromJson(Map<String, dynamic> json) => ResponseReceivedContactChat(
    isSuccess: json["isSuccess"],
    errors: json["errors"]!=null?List<String>.from(json["errors"].map((x) => x)):<String>[],
    data:json["data"] !=null ? List<DataContactChat>.from(json["data"].map((x) => DataContactChat.fromJson(x))):<DataContactChat>[],
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errors": errors,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataContactChat {
  DataContactChat({
    this.userId,
    this.roleId,
    this.username,
    this.fullname,
    this.newMessage
  });

  int? userId;
  int? roleId;
  String? username;
  String? fullname;
  List<ModelRecivedMessage>? newMessage=<ModelRecivedMessage>[];
  factory DataContactChat.fromJson(Map<String, dynamic> json) => DataContactChat(
    userId: json["userId"],
    roleId: json["roleId"],
    username: json["username"],
    fullname: json["fullname"],
    newMessage:json["newMessage"] !=null ? List<ModelRecivedMessage>.from(json["newMessage"].map((x) => DataContactChat.fromJson(x))):<ModelRecivedMessage>[],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "roleId": roleId,
    "username": username,
    "fullname": fullname,
  };
}
