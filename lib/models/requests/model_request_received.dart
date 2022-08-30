class ModelRequestsReceived {
  ModelRequestsReceived({
    this.status,
    this.name,
    this.profile,
    this.unit,
    this.statusInt,

  });

  String? status;
  int? statusInt;
  String? name;
  String? profile;
  String? unit;


  factory ModelRequestsReceived.fromJson(Map<String, dynamic> json) => ModelRequestsReceived(
    status: json["status"],
    name: json["name"],
    profile: json["profile"],
    unit: json["unit"],
    statusInt: json["statusInt"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "name": name,
    "profile": profile,
    "unit": unit,
    "statusInt": statusInt,
  };
}