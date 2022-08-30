
import 'dart:convert';

class ModelUploadFile {
  ModelUploadFile({
    required this.fileName,
    required this.fileContent,
    required this.fileTypeId,
    required this.ownerId,
    required  this.ownerName,
    required this.serviceName,
    required this.userId,
    required this.userTypeId,
  });

  String fileName;
  String fileContent;
  int fileTypeId;
  int ownerId;
  String ownerName;
  String serviceName;
  int userId;
  int userTypeId;

  factory ModelUploadFile.fromJson(Map<String, dynamic> json) => ModelUploadFile(
    fileName: json["fileName"],
    fileContent: json["fileContent"],
    fileTypeId: json["fileTypeId"],
    ownerId: json["ownerId"],
    ownerName: json["ownerName"],
    serviceName: json["serviceName"],
    userId: json["userId"],
    userTypeId: json["userTypeId"],
  );

  Map<String, dynamic> toJson() => {
    "fileName": fileName,
    "fileContent": fileContent,
    "fileTypeId": fileTypeId,
    "ownerId": ownerId,
    "ownerName": ownerName,
    "serviceName": serviceName,
    "userId": userId,
    "userTypeId": userTypeId,
  };
}
