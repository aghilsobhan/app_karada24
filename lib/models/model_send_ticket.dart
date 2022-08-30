

class ModelSendTicket {
  ModelSendTicket({
   required this.tckTittle,
    required this.tckBody,
    required this.tckProId,
    required this.tckParentId,
    required  this.tckOwnerId,
    required  this.tckOrganId,
    required  this.tckTags,
    required  this.tckpriorityId,
    required  this.tckCategoryId,
    required this.tckIsPrivate,
    required this.tckHasFile,
    required this.responsibleUserId,
  });

  String? tckTittle;
  String? tckBody;
  int? tckProId;
  int? tckParentId;
  int? tckOwnerId;
  int? tckOrganId;
  String? tckTags;
  int? tckpriorityId;
  int? tckCategoryId;
  int? tckIsPrivate;
  bool? tckHasFile;
  int? responsibleUserId;



  factory ModelSendTicket.fromJson(Map<String, dynamic> json) => ModelSendTicket(
    tckTittle: json["tckTittle"],
    tckBody: json["tckBody"],
    tckProId: json["tckProId"],
    tckParentId: json["tckParentId"],
    tckOwnerId: json["tckOwnerId"],
    tckOrganId: json["tckOrganId"],
    tckTags: json["tckTags"],
    tckpriorityId: json["tckpriorityId"],
    tckCategoryId: json["tckCategoryId"],
    tckIsPrivate: json["tckIsPrivate"],
    tckHasFile: json["tckHasFile"],
    responsibleUserId: json["responsibleUserId"],
  );

  Map<String, dynamic> toJson() => {
    "tckTittle": tckTittle,
    "tckBody": tckBody,
    "tckProId": tckProId,
    "tckParentId": tckParentId,
    "tckOwnerId": tckOwnerId,
    "tckOrganId": tckOrganId,
    "tckTags": tckTags,
    "tckpriorityId": tckpriorityId,
    "tckCategoryId": tckCategoryId,
    "tckIsPrivate": tckIsPrivate,
    "tckHasFile": tckHasFile,
    "responsibleUserId": responsibleUserId,
  };
}
