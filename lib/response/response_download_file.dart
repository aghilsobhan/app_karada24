// To parse this JSON data, do
//
//     final responseDownloadFile = responseDownloadFileFromJson(jsonString);

import 'dart:convert';

ResponseDownloadFile responseDownloadFileFromJson(String str) => ResponseDownloadFile.fromJson(json.decode(str));

String responseDownloadFileToJson(ResponseDownloadFile data) => json.encode(data.toJson());

class ResponseDownloadFile {
  ResponseDownloadFile({
    required this.isSuccess,
    this.error,
    required this.data,
  });

  bool isSuccess;
  dynamic error;
  DataDownloadFile data;

  factory ResponseDownloadFile.fromJson(Map<String, dynamic> json) => ResponseDownloadFile(
    isSuccess: json["isSuccess"],
      error: json["erorr"]!=null?List<String>.from(json["erorr"].map((x) => x)):<String>[],
    data: DataDownloadFile.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "error": error,
    "data": data.toJson(),
  };
}

class DataDownloadFile {
  DataDownloadFile({
    required this.fileName,
    required this.fileContent,
    required this.fileTypeId,
  });

  String? fileName;
  String? fileContent;
  int? fileTypeId;

  factory DataDownloadFile.fromJson(Map<String, dynamic> json) => DataDownloadFile(
    fileName: json["fileName"],
    fileContent: json["fileContent"],
    fileTypeId: json["fileTypeId"],
  );

  Map<String, dynamic> toJson() => {
    "fileName": fileName,
    "fileContent": fileContent,
    "fileTypeId": fileTypeId,
  };
}
