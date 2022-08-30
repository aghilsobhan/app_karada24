
class ModelDeleteRequest {
  ModelDeleteRequest({
    this.requestId,
    this.reqSrcUserId,
    this.reqDstUserId,
    this.cancellerUserId,

  });

  int? requestId;
  int? reqSrcUserId;
  int? reqDstUserId;
  int? cancellerUserId;


  factory ModelDeleteRequest.fromJson(Map<String, dynamic> json) => ModelDeleteRequest(
    requestId: json["requestId"],
    reqSrcUserId: json["reqSrcUserId"],
    reqDstUserId: json["reqDstUserId"],
    cancellerUserId: json["cancellerUserId"],
  );

  Map<String, dynamic> toJson() => {
    "requestId": requestId,
    "reqSrcUserId": reqSrcUserId,
    "reqDstUserId": reqDstUserId,
    "cancellerUserId": cancellerUserId,
  };
}
