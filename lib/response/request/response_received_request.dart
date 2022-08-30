class ResponseAcceptRequest {
  ResponseAcceptRequest({
    this.isSuccess,
    this.errors,
    this.data,
  });

  bool? isSuccess;
  List<String>? errors;
  dynamic data;

  factory ResponseAcceptRequest.fromJson(Map<String, dynamic> json) => ResponseAcceptRequest(
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