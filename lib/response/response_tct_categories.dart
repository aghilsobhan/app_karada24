
import 'dart:convert';

class ResponseTctCategories {
  ResponseTctCategories({
    required this.isSussecc,
    required  this.errors,
    required this.data,
  });

  bool isSussecc;
  List<dynamic>? errors;
  List<DataTctCategories>? data;

  factory ResponseTctCategories.fromJson(Map<String, dynamic> json) => ResponseTctCategories(
    isSussecc: json["isSussecc"],
    errors:json["errors"]!=null?List<dynamic>.from(json["error"].map((x) => x)):<dynamic>[],
    data: List<DataTctCategories>.from(json["data"].map((x) => DataTctCategories.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "isSussecc": isSussecc,
    "errors": errors,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataTctCategories {
  int? id;
  int? depId;
  int? parentId;
  String? name;

  DataTctCategories({required this.depId, required this.parentId, required this.name, required this.id});

  DataTctCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    depId = json['depId'];
    parentId = json['parentId'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['depId'] = this.depId;
    data['parentId'] = this.parentId;
    data['name'] = this.name;
    return data;
  }
}