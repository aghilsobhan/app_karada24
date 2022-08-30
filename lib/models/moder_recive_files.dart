

class ModelReciveFiles {
  ModelReciveFiles({
    required this.ownerId,
    required this.ownerName,
    required this.serviceName,
  });

  int ownerId;
  String ownerName;
  String serviceName;

  factory ModelReciveFiles.fromJson(Map<String, dynamic> json) => ModelReciveFiles(
    ownerId: json["ownerId"],
    ownerName: json["ownerName"],
    serviceName: json["serviceName"],
  );

  Map<String, dynamic> toJson() => {
    "ownerId": ownerId,
    "ownerName": ownerName,
    "serviceName": serviceName,
  };
}
