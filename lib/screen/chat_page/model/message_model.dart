// /// id : 0
// /// senderId : 0
// /// senderUsername : "SenderUsername"
// /// senderFullname : "SenderFullname"
// /// recieverId : 0
// /// recieverUsername : "RecieverUsername"
// /// recieverFullname : "RecieverFullname"
// /// sendDate : "DateTime"
// /// content : "content"
// /// isNew : false
// /// isSenderDeleted : false
// /// isRecieverDeleted : false
// final String tableMessage="message";
// class MessageFields{
//   static final List<String> values=[
//     id,senderUsername,senderFullname,sendDate,recieverUsername,
//     recieverId,recieverFullname,isSenderDeleted,isRecieverDeleted,
//     isNew,content,type,message,time,senderId
//   ];
//   static final String id="id";
//   static final String senderId="senderId";
//   static final String senderUsername="senderUsername";
//   static final String senderFullname="senderFullname";
//   static final String recieverId="recieverId";
//   static final String recieverUsername="recieverUsername";
//   static final String recieverFullname="recieverFullname";
//   static final String sendDate="sendDate";
//   static final String content="content";
//   static final String isNew="isNew";
//   static final String isSenderDeleted="isSenderDeleted";
//   static final String isRecieverDeleted="isRecieverDeleted";
//   static final String type="type";
//   static final String message="message";
//   static final String time="time";
//
// }
// class MessageModel {
//   MessageModel({
//       this.id,
//       this.senderId,
//       this.senderUsername,
//       this.senderFullname,
//       this.recieverId,
//       this.recieverUsername,
//       this.recieverFullname,
//       this.sendDate,
//       this.content,});
//
//   factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
//       id : json['id'],
//       senderId : json['senderId'],
//       senderUsername : json['senderUsername'],
//       senderFullname : json['senderFullname'],
//       recieverId : json['recieverId'],
//       recieverUsername : json['recieverUsername'],
//       recieverFullname : json['recieverFullname'],
//       sendDate : json['sendDate'],
//       content : json['content'],
//       type : json['type'],
//       message : json['message'],
//       time : json['time'],
//
//   );
//
//   int? id;
//   int? senderId;
//   String? senderUsername;
//   String? type;
//   String? message;
//   String? time;
//   String? senderFullname;
//   int? recieverId;
//   String? recieverUsername;
//   String? recieverFullname;
//   String? sendDate;
//   String? content;
//
// MessageModel copy({
//   int? id,
//   int? senderId,
//   String? senderUsername,
//   String? type,
//   String? message,
//   String? time,
//   String? senderFullname,
//   int? recieverId,
//   String? recieverUsername,
//   String? recieverFullname,
//   String? sendDate,
//   String? content,
//   bool? isNew,
//   bool? isSenderDeleted,
//   bool? isRecieverDeleted,
// })=>MessageModel(
//       id:id??this.id,
//   senderId:senderId??this.senderId,
//   senderUsername:senderUsername??this.senderUsername,
//   type:type??this.type,
//   message:message??this.message,
//   time:time??this.time,
//   senderFullname:senderFullname??this.senderFullname,
//   sendDate:sendDate??this.sendDate,
//   content:content??this.content,
//   recieverFullname:recieverFullname??this.recieverFullname,
//   recieverUsername:recieverUsername??this.recieverUsername,
//   recieverId:recieverId??this.recieverId,
// );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['senderId'] = senderId;
//     map['senderUsername'] = senderUsername;
//     map['senderFullname'] = senderFullname;
//     map['recieverId'] = recieverId;
//     map['recieverUsername'] = recieverUsername;
//     map['recieverFullname'] = recieverFullname;
//     map['sendDate'] = sendDate;
//     map['content'] = content;
//     map['type'] = type;
//     map['message'] = message;
//     map['time'] = time;
//     return map;
//   }
//
// }
