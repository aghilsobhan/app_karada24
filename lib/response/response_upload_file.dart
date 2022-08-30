
import 'dart:convert';

ResponseUploadFile responseUploadFileFromJson(String str) => ResponseUploadFile.fromJson(json.decode(str));

String responseUploadFileToJson(ResponseUploadFile data) => json.encode(data.toJson());

class ResponseUploadFile {
  ResponseUploadFile({
    required this.isSuccess,
    required this.fileId,
    required this.error,
  });

  bool isSuccess;
  int fileId;
  List<String> error;

  factory ResponseUploadFile.fromJson(Map<String, dynamic> json) => ResponseUploadFile(
    isSuccess: json["isSuccess"],
    fileId: json["fileId"],
      error:json["erorr"]!=null?List<String>.from(json["erorr"].map((x) => x)):<String>[]
  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "fileId": fileId,
    "error": List<dynamic>.from(error.map((x) => x)),
  };
}
