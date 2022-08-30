
class ModelRequest {
  ModelRequest({
    this.userId,
    this.roleId,
    this.organId,

  });

  int? userId;
  int? roleId;
  int? organId;



  factory ModelRequest.fromJson(Map<String, dynamic> json) => ModelRequest(
    userId: json["userId"],
    roleId: json["roleId"],
    organId: json["organId"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "roleId": roleId,
    "organId": organId,
  };
}
