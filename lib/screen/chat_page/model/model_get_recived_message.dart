
class ModelGetReceivedMessage {
  ModelGetReceivedMessage({
    this.recieverId,
    this.senderId,
    this.orgId,
  });

  int? recieverId;
  int? senderId;
  int? orgId;

  factory ModelGetReceivedMessage.fromJson(Map<String, dynamic> json) => ModelGetReceivedMessage(
    recieverId: json["recieverId"],
    senderId: json["senderId"],
    orgId: json["orgId"],
  );

  Map<String, dynamic> toJson() => {
    "recieverId": recieverId,
    "senderId": senderId,
    "orgId": orgId,
  };
}
