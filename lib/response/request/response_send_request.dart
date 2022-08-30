class ResponseSendRequest {
  ResponseSendRequest({
    this.isSuccess,
    this.errors,
    this.data,
  });

  bool? isSuccess;
  List<String>? errors;
  List<String>? data;

  factory ResponseSendRequest.fromJson(Map<String, dynamic> json) => ResponseSendRequest(
    isSuccess: json["isSuccess"],
    errors: json["errors"]!=null?List<String>.from(json["errors"].map((x) => x)):<String>[],
    data: json["data"]!=null?List<String>.from(json["data"].map((x) => x)):<String>[],

  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errors": errors,
    "data":data,
  };
}
class ResponseDeleteRequest {
  ResponseDeleteRequest({
    this.isSuccess,
    this.errors,
    this.data,
  });

  bool? isSuccess;
  List<String>? errors;
  int? data;

  factory ResponseDeleteRequest.fromJson(Map<String, dynamic> json) => ResponseDeleteRequest(
    isSuccess: json["isSuccess"],
    errors: json["errors"]!=null?List<String>.from(json["errors"].map((x) => x)):<String>[],
    data: json["data"],

  );

  Map<String, dynamic> toJson() => {
    "isSuccess": isSuccess,
    "errors": errors,
    "data":data,
  };
}