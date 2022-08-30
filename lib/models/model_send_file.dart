// To parse this JSON data, do
//
//     final modelSendFile = modelSendFileFromJson(jsonString);

import 'dart:convert';

ModelSendFile modelSendFileFromJson(String str) => ModelSendFile.fromJson(json.decode(str));

String modelSendFileToJson(ModelSendFile data) => json.encode(data.toJson());

class ModelSendFile {
  ModelSendFile({
    required this.fileIds,
    required this.ownerId,
  });

  List<int> fileIds;
  int? ownerId;

  factory ModelSendFile.fromJson(Map<String, dynamic> json) => ModelSendFile(
    fileIds: List<int>.from(json["fileIds"].map((x) => x)),
    ownerId: json["ownerId"],
  );

  Map<String, dynamic> toJson() => {
    "fileIds": List<dynamic>.from(fileIds.map((x) => x)),
    "ownerId": ownerId,
  };
}
