//
// import 'package:app_karada24/screen/chat_page/customui/replay_card.dart';
//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import '../../../getxController/storagedata/StrorageAllData.dart';
// import '../model/model_received_chat.dart';
// import 'own_message_card.dart';
// class ListMessageChat extends StatefulWidget {
//  final List<ModelRecivedMessage> messages;
//  final  ScrollController scrollController;
//   const ListMessageChat({Key? key, required this.messages, required this.scrollController}) : super(key: key);
//
//   @override
//   _ListMessageChatState createState() => _ListMessageChatState();
// }
//
// class _ListMessageChatState extends State<ListMessageChat> {
//   int? userId = Get.find<ControllerGetStorageAllData>().userId;
//
//   @override
//   Widget build(BuildContext context) {
//      return Expanded(
//
//       child: ListView.builder(
//         controller: widget.scrollController,
//         itemCount: widget.messages.length,
//         itemBuilder: (context, index) {
//          //print(widget.messages.length);
//           if (index == widget.messages.length) {
//             return Container(
//               height: 70,
//             );
//           }
//           if (widget.messages[index].senderId==userId) {
//             return OwnMessageCard(
//               message: widget.messages[index].content.toString(),
//               time: "12:7",
//             );
//           } else {
//
//             return ReplyCard(
//               message: widget.messages[index].content.toString(),
//               time:"12:08",
//             );
//           }
//         },
//       ),
//     );
//   }
// }
