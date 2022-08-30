class ModelBodyTicket {
  ModelBodyTicket({
    this.title,
    this.productId,
    this.productName,
    this.priorityId,
    this.priorityName,

  });

  String? title;
  int? productId;
  String? productName;
  String? priorityName;
  int? priorityId;


  factory ModelBodyTicket.fromJson(Map<String, dynamic> json) => ModelBodyTicket(
    title: json["title"],
    productName: json["productName"],
    productId: json["productId"],
    priorityName: json["priorityName"],
    priorityId: json["priorityId"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "productName": productName,
    "productId": productId,
    "priorityName": priorityName,
    "priorityId": priorityId,
  };
}