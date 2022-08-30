// To parse this JSON data, do
//
//     final modelSubmittedRequests = modelSubmittedRequestsFromJson(jsonString);

import 'dart:convert';


class ModelSendRequests {
  ModelSendRequests({
    this.typeId,
    this.description,
    this.srcUserId,
    this.dstUserId,
  });

  int? typeId;
  String? description;
  int? srcUserId;
  int? dstUserId;

  factory ModelSendRequests.fromJson(Map<String, dynamic> json) => ModelSendRequests(
    typeId: json["typeId"],
    description: json["description"],
    srcUserId: json["srcUserId"],
    dstUserId: json["dstUserId"],
  );

  Map<String, dynamic> toJson() => {
    "typeId": typeId,
    "description": description,
    "srcUserId": srcUserId,
    "dstUserId": dstUserId,
  };
}
class ModelReceivedRequests {
  ModelReceivedRequests({
    this.userId,
  this.requestId
  });

  int? userId;
  int? requestId;


  factory ModelReceivedRequests.fromJson(Map<String, dynamic> json) => ModelReceivedRequests(
    userId: json["userId"],
    requestId: json["requestId"],

  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "requestId": requestId,
  };
}