// To parse this JSON data, do
//
//     final modelRecivedMessage = modelRecivedMessageFromJson(jsonString);

final String tableMessage="message";
class MessageFields{
  static final List<String> values=[
   id,senderId,senderUsername,senderFullname,recieverId,recieverUsername,recieverFullname,sendDate,
    content,senderIsNew,recieverIsNew,senderIsSeen,recieverIsSeen,isSenderDeleted,isRecieverDeleted,status
  ];
  static final String id="id";
  static final String senderId="senderId";
  static final String senderUsername="senderUsername";
  static final String senderFullname="senderFullname";
  static final String recieverId="recieverId";
  static final String recieverUsername="recieverUsername";
  static final String recieverFullname="recieverFullname";
  static final String sendDate="sendDate";
  static final String content="content";
  static final String senderIsNew="senderIsNew";
  static final String recieverIsNew="recieverIsNew";
  static final String senderIsSeen="senderIsSeen";
  static final String recieverIsSeen="recieverIsSeen";
  static final String isSenderDeleted="isSenderDeleted";
  static final String isRecieverDeleted="isRecieverDeleted";
  static final String status="status";


}

class ModelRecivedMessage {
  ModelRecivedMessage({
    this.id,
    this.senderId,
    this.senderUsername,
    this.senderFullname,
    this.recieverId,
    this.recieverUsername,
    this.recieverFullname,
    this.sendDate,
    this.content,
    this.senderIsNew,
    this.recieverIsNew,
    this.senderIsSeen,
    this.recieverIsSeen,
    this.isSenderDeleted,
    this.isRecieverDeleted,
    this.status,
  });

  int? id;
  int? senderId;
  String? senderUsername;
  String? senderFullname;
  int? recieverId;
  String? recieverUsername;
  String? recieverFullname;
  DateTime? sendDate;
  String? content;
  int? senderIsNew;
  int? recieverIsNew;
  int? senderIsSeen;
  int? recieverIsSeen;
  int? isSenderDeleted;
  int? isRecieverDeleted;
  String? status;
  ModelRecivedMessage copy({
    int? id,
    int? senderId,
    String? senderUsername,
    String? senderFullname,
    int? recieverId,
    String? recieverUsername,
    String? recieverFullname,
    DateTime? sendDate,
    String? content,
    int? senderIsNew,
    int? recieverIsNew,
    int? senderIsSeen,
    int? recieverIsSeen,
    int? isSenderDeleted,
    int? isRecieverDeleted,
    String? status
})=>ModelRecivedMessage(
      id:id??this.id,
  senderId:senderId??this.senderId,
  senderUsername: senderUsername??this.senderUsername,
    senderFullname: senderFullname??this.senderFullname,
    recieverId:recieverId??this.recieverId,
    recieverUsername:recieverUsername??this.recieverUsername,
    recieverFullname:recieverFullname??this.recieverFullname,
    sendDate:sendDate??this.sendDate,
    content:content??this.content,
    senderIsNew:senderIsNew??this.senderIsNew,
    recieverIsNew:recieverIsNew??this.recieverIsNew,
    senderIsSeen:senderIsSeen??this.senderIsSeen,
    recieverIsSeen:recieverIsSeen??this.recieverIsSeen,
    isSenderDeleted:isSenderDeleted??this.isSenderDeleted,
    isRecieverDeleted:isRecieverDeleted??this.isRecieverDeleted,
    status:status??this.status,

);
  factory ModelRecivedMessage.fromJson(Map<String, dynamic> json) => ModelRecivedMessage(
    id: json["id"],
    senderId: json["senderId"],
    senderUsername: json["senderUsername"],
    senderFullname: json["senderFullname"],
    recieverId: json["recieverId"],
    recieverUsername: json["recieverUsername"],
    recieverFullname: json["recieverFullname"],
    sendDate: DateTime.parse(json["sendDate"]),
    content: json["content"],
    senderIsNew: json["senderIsNew"],
    recieverIsNew: json["recieverIsNew"],
    senderIsSeen: json["senderIsSeen"],
    recieverIsSeen: json["recieverIsSeen"],
    isSenderDeleted: json["isSenderDeleted"],
    isRecieverDeleted: json["isRecieverDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "senderId": senderId,
    "senderUsername": senderUsername,
    "senderFullname": senderFullname,
    "recieverId": recieverId,
    "recieverUsername": recieverUsername,
    "recieverFullname": recieverFullname,
    "sendDate": sendDate?.toIso8601String(),
    "content": content,
    "senderIsNew": senderIsNew,
    "recieverIsNew": recieverIsNew,
    "senderIsSeen": senderIsSeen,
    "recieverIsSeen": recieverIsSeen,
    "isSenderDeleted": isSenderDeleted,
    "isRecieverDeleted": isRecieverDeleted,
  };
}
// To parse this JSON data, do
//
//     final responseReceivedContact = responseReceivedContactFromJson(jsonString);


class ModelRecivedMessageBool {
  ModelRecivedMessageBool({
    this.id,
    this.senderId,
    this.senderUsername,
    this.senderFullname,
    this.recieverId,
    this.recieverUsername,
    this.recieverFullname,
    this.sendDate,
    this.content,
    this.senderIsNew,
    this.recieverIsNew,
    this.senderIsSeen,
    this.recieverIsSeen,
    this.isSenderDeleted,
    this.isRecieverDeleted,
    this.status,
  });

  int? id;
  int? senderId;
  String? senderUsername;
  String? senderFullname;
  int? recieverId;
  String? recieverUsername;
  String? recieverFullname;
  DateTime? sendDate;
  String? content;
  bool? senderIsNew;
  bool? recieverIsNew;
  bool? senderIsSeen;
  bool? recieverIsSeen;
  bool? isSenderDeleted;
  bool? isRecieverDeleted;
  String? status;

  factory ModelRecivedMessageBool.fromJson(Map<String, dynamic> json) => ModelRecivedMessageBool(
    id: json["id"],
    senderId: json["senderId"],
    senderUsername: json["senderUsername"],
    senderFullname: json["senderFullname"],
    recieverId: json["recieverId"],
    recieverUsername: json["recieverUsername"],
    recieverFullname: json["recieverFullname"],
    sendDate: DateTime.parse(json["sendDate"]),
    content: json["content"],
    senderIsNew: json["senderIsNew"],
    recieverIsNew: json["recieverIsNew"],
    senderIsSeen: json["senderIsSeen"],
    recieverIsSeen: json["recieverIsSeen"],
    isSenderDeleted: json["isSenderDeleted"],
    isRecieverDeleted: json["isRecieverDeleted"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "senderId": senderId,
    "senderUsername": senderUsername,
    "senderFullname": senderFullname,
    "recieverId": recieverId,
    "recieverUsername": recieverUsername,
    "recieverFullname": recieverFullname,
    "sendDate": sendDate?.toIso8601String(),
    "content": content,
    "senderIsNew": senderIsNew,
    "recieverIsNew": recieverIsNew,
    "senderIsSeen": senderIsSeen,
    "recieverIsSeen": recieverIsSeen,
    "isSenderDeleted": isSenderDeleted,
    "isRecieverDeleted": isRecieverDeleted,
    "status": status,
  };
}

// class ModelRecivedMessageBool {
//   ModelRecivedMessageBool({
//     this.id,
//     this.senderId,
//     this.recieverId,
//     this.sendDate,
//     this.content,
//     this.isSenderDeleted,
//     this.isRecieverDeleted,
//     this.status
//   });
//
//   int? id;
//   int? senderId;
//   String? senderUsername;
//   String? senderFullname;
//   int? recieverId;
//   String? recieverUsername;
//   String? recieverFullname;
//   DateTime? sendDate;
//   String? content;
//   bool? senderIsNew;
//   bool? recieverIsNew;
//   bool? senderIsSeen;
//   bool? recieverIsSeen;
//   bool? isSenderDeleted;
//   bool? isRecieverDeleted;
//   String? status;
//   ModelRecivedMessageBool copy({
//     int? id,
//     int? senderId,
//     int? recieverId,
//     DateTime? sendDate,
//     String? content,
//     bool? isNew,
//     bool? isSenderDeleted,
//     bool? isRecieverDeleted,
//     String? status,
//   })=>ModelRecivedMessageBool(
//     id:id??this.id,
//     senderId:senderId??this.senderId,
//     sendDate:sendDate??this.sendDate,
//     content:content??this.content,
//     recieverId:recieverId??this.recieverId,
//     isNew:isNew??this.isNew,
//     isSenderDeleted:isSenderDeleted??this.isSenderDeleted,
//     isRecieverDeleted:isRecieverDeleted??this.isRecieverDeleted,
//     status:status??this.status,
//   );
//   factory ModelRecivedMessageBool.fromJson(Map<String, dynamic> json) => ModelRecivedMessageBool(
//     id: json["id"],
//     senderId: json["senderId"],
//     recieverId: json["recieverId"],
//     sendDate: DateTime.parse(json["sendDate"]),
//     content: json["content"],
//     isNew: json["isNew"],
//     isSenderDeleted: json["isSenderDeleted"],
//     isRecieverDeleted: json["isRecieverDeleted"],
//     status: json["status"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "senderId": senderId,
//     "recieverId": recieverId,
//     "sendDate": sendDate?.toIso8601String(),
//     "content": content,
//     "isNew": isNew,
//     "isSenderDeleted": isSenderDeleted,
//     "isRecieverDeleted": isRecieverDeleted,
//     "status": status,
//   };
// }