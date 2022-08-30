
class ResponseAllHelp {
  ResponseAllHelp({
    required this.iSuccess,
    required this.error,
    required this.data,
  });

  bool? iSuccess;
 List<dynamic>? error;
  List<DataHelp>? data;

  factory ResponseAllHelp.fromJson(Map<String, dynamic> json) => ResponseAllHelp(
    iSuccess: json["iSuccess"],
    error:json["error"]!=null?List<dynamic>.from(json["error"].map((x) => x)):<dynamic>[],
    data:json["data"]!=null? List<DataHelp>.from(json["data"].map((x) => DataHelp.fromJson(x))):<DataHelp>[],
  );

  Map<String, dynamic> toJson() => {
    "iSuccess": iSuccess,
    "error": error,
    "data": List<dynamic>.from(data?.map((x) => x.toJson()) as  List<dynamic> ),
  };
}

class DataHelp {
  DataHelp({
    required this.hlpId,
    required this.hlpTittle,
    required this.hlpStartShow,
    required this.hlpEndShow,
    required this.hlpProId,
    required this.hlpBody,
    required this.hlpUserId,
    required this.hlpRegDate,
    required this.hlpStatusId,

  });
  int? hlpId;
  String? hlpTittle;
  DateTime? hlpStartShow;
  DateTime? hlpEndShow;
  int? hlpProId;
  String? hlpBody;
  int? hlpUserId;
  DateTime? hlpRegDate;
  int? hlpStatusId;

  factory DataHelp.fromJson(Map<String, dynamic> json) => DataHelp(
    hlpId: json["hlpId"],
    hlpTittle: json["hlpTittle"],
    hlpStartShow: DateTime.parse(json["hlpStartShow"]),
    hlpEndShow: DateTime.parse(json["hlpEndShow"]),
    hlpProId: json["hlpProId"],
    hlpBody: json["hlpBody"],
    hlpUserId: json["hlpUserId"],
    hlpRegDate: DateTime.parse(json["hlpRegDate"]),
    hlpStatusId: json["hlpStatusId"],
  );

  Map<String, dynamic> toJson() => {
    "hlpId": hlpId,
    "hlpTittle": hlpTittle,
    "hlpStartShow": hlpStartShow?.toIso8601String(),
    "hlpEndShow": hlpEndShow?.toIso8601String(),
    "hlpProId": hlpProId,
    "hlpBody": hlpBody,
    "hlpUserId": hlpUserId,
    "hlpRegDate": hlpRegDate?.toIso8601String(),
    "hlpStatusId": hlpStatusId,
  };
}
