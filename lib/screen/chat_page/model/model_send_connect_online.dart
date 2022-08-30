// To parse this JSON data, do
//
//     final modelRecivedMessage = modelRecivedMessageFromJson(jsonString);


// class ModelSendContactOnline{
//   static final List<String> values=[
//     id,senderId,recieverId,sendDate,content,
//     isNew,isSenderDeleted,isRecieverDeleted
//   ];
//   static final String id="id";
//   static final String senderId="senderId";
//   static final String recieverId="recieverId";
//   static final String sendDate="sendDate";
//   static final String content="content";
//   static final String isNew="isNew";
//   static final String isSenderDeleted="isSenderDeleted";
//   static final String isRecieverDeleted="isRecieverDeleted";
//
// }

class ModelSendContactOnline {
  ModelSendContactOnline({
this.userId,
    this.fullname,
    this.username
  });

  int? userId;
  String? fullname;
  String? username;

  factory ModelSendContactOnline.fromJson(Map<String, dynamic> json) => ModelSendContactOnline(
    userId: json["userId"],
    fullname: json["fullname"],
    username: json["username"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "fullname": fullname,
    "username": username,

  };
}
