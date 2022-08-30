

class ResponseGetFiles {
  bool? isSuccess;
  List<String>? error;
  List<DataUpFile>? data;

  ResponseGetFiles({this.isSuccess, this.error, this.data});

  ResponseGetFiles.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    error= json["erorr"]!=null?List<String>.from(json["erorr"].map((x) => x)):<String>[];
    data=json["data"] !=null ? List<DataUpFile>.from(json["data"].map((x) => DataUpFile.fromJson(x))):<DataUpFile>[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =Map<String, dynamic>();
    data['isSuccess'] = isSuccess;
    data['error'] = error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataUpFile {
  int? fileId;
  String? fileName;
  int? ownerId;
  String? serviceName;
  String? ownerName;
bool? isDownload=false;
  DataUpFile(
      {this.fileId,
        this.fileName,
        this.ownerId,
        this.serviceName,
        this.ownerName,
      this.isDownload});

  DataUpFile.fromJson(Map<String, dynamic> json) {
    fileId = json['fileId'];
    fileName = json['fileName'];
    ownerId = json['ownerId'];
    serviceName = json['serviceName'];
    ownerName = json['ownerName'];
    isDownload = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fileId'] = this.fileId;
    data['fileName'] = this.fileName;
    data['ownerId'] = this.ownerId;
    data['serviceName'] = this.serviceName;
    data['ownerName'] = this.ownerName;
    return data;
  }
}


// import 'dart:convert';
//
// ResponseGetListFiles responseGetListFilesFromJson(String str) => ResponseGetListFiles.fromJson(json.decode(str));
//
// String responseGetListFilesToJson(ResponseGetListFiles data) => json.encode(data.toJson());
//
// class ResponseGetListFiles {
//   ResponseGetListFiles({
//     this.isSuccess,
//     this.error,
//     this.data,
//   });
//
//   bool isSuccess;
//   dynamic error;
//   List<Datum> data;
//
//   factory ResponseGetListFiles.fromJson(Map<String, dynamic> json) => ResponseGetListFiles(
//     isSuccess: json["isSuccess"],
//     error: json["error"],
//     data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "isSuccess": isSuccess,
//     "error": error,
//     "data": List<dynamic>.from(data.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
//   Datum({
//     this.fileId,
//     this.fileName,
//     this.ownerId,
//     this.serviceName,
//     this.ownerName,
//   });
//
//   int fileId;
//   String fileName;
//   int ownerId;
//   ServiceName serviceName;
//   OwnerName ownerName;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     fileId: json["fileId"],
//     fileName: json["fileName"],
//     ownerId: json["ownerId"],
//     serviceName: serviceNameValues.map[json["serviceName"]],
//     ownerName: ownerNameValues.map[json["ownerName"]],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "fileId": fileId,
//     "fileName": fileName,
//     "ownerId": ownerId,
//     "serviceName": serviceNameValues.reverse[serviceName],
//     "ownerName": ownerNameValues.reverse[ownerName],
//   };
// }
