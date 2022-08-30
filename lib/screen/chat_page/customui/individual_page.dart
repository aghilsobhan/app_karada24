import 'package:app_karada24/getxController/check_badge_tickets.dart';
import 'package:app_karada24/response/chat/response_get_contact.dart';
import 'package:app_karada24/response/request/response_list_submited.dart';
import 'package:app_karada24/screen/chat_page/controller/get_contact_message_controller.dart';
import 'package:app_karada24/screen/chat_page/customui/bottomsheet.dart';
import 'package:app_karada24/screen/chat_page/database/message_database.dart';
import 'package:app_karada24/screen/chat_page/model/model_get_recived_message.dart';
import 'package:app_karada24/screen/chat_page/model/model_received_chat.dart';
import 'package:app_karada24/utility/widget_loading_page.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/screen/chat_page/controller/chat_controller.dart';
import 'package:app_karada24/screen/chat_page/customui/own_message_card.dart';
import 'package:app_karada24/screen/chat_page/customui/replay_card.dart';
import 'package:get/get.dart';
import '../view/appbar_page_chat.dart';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

class IndividualPage extends StatefulWidget {
  final DataContactChat dataContactChat;

  IndividualPage({Key? key, required this.dataContactChat})
      : super(key: key);


  @override
  _IndividualPageState createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  int? userId = Get.find<ControllerGetStorageAllData>().userId;
  ChatController chatController = Get.find<ChatController>();
  GetUserMessageController getUserMessageController = Get.find<GetUserMessageController>();
  GetBadge getBadge = Get.find<GetBadge>();
  bool loading = true;
  late Future<void> getMessageDataBase;
  late List<ModelRecivedMessage> _listData = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
            "images/bgchat.jpg",
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBarChatPage(
            name:  widget.dataContactChat.fullname.toString(),
            // isConnect: widget.dataContactChat.username.toString()
            //     .toString(),
            image: "images/peyma.jpg",),
          body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            child: WillPopScope(
              child: Obx(() {
                return Column(
                  children: [
                    // Expanded(
                    //   child: GroupedListView<ModelRecivedMessage,String>(
                    //     shrinkWrap: true,
                    //     physics: BouncingScrollPhysics(),
                    //     controller: chatController.scrollController,
                    //     padding: const EdgeInsets.only(left: 8, right: 8),
                    //     elements: chatController.messages,
                    //     groupBy: (element) => element.sendDate.toString().split(" ").first,
                    //     groupComparator:  (value1, value2)=>value2.compareTo(value1),
                    //     useStickyGroupSeparators: true,
                    //     stickyHeaderBackgroundColor: Colors.transparent,
                    //     groupSeparatorBuilder: (String value) => Padding(
                    //       padding: const EdgeInsets.only(top: 5.0),
                    //       child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.center,
                    //           children: <Widget>[
                    //             Container(
                    //               decoration: BoxDecoration(
                    //                 color: Colors.white,
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               child: Padding(
                    //                 padding: const EdgeInsets.only(left: 5, right: 5),
                    //                 child: Text(
                    //                   value,
                    //                   textAlign: TextAlign.center,
                    //                   style: const TextStyle(
                    //                       fontSize: 12,
                    //                       fontFamily: 'sans',
                    //                       color: Colors.blueGrey),
                    //                 ),
                    //               ),
                    //             ),
                    //           ]),
                    //     ),
                    //     itemBuilder: (c, element) {
                    //       var sendDate = element
                    //           .sendDate;
                    //       String time = DateFormat('kk:mm').format(sendDate!);
                    //       return
                    //         element.senderId != userId
                    //             ?
                    //         ReplyCard(
                    //           message:
                    //           element.content
                    //               .toString(),
                    //           time: time,
                    //         )
                    //             : element.senderId ==
                    //             userId
                    //             ?
                    //         Row(
                    //           mainAxisAlignment: MainAxisAlignment.end,
                    //           children: [
                    //
                    //             OwnMessageCard(
                    //               message:
                    //               element.content
                    //                   .toString(),
                    //               time: time.toString(),
                    //               status: element.status.toString(),
                    //             ),
                    //             element.status.toString().contains("failed")? Padding(
                    //               padding: const EdgeInsets.only(right: 4.0),
                    //               child: GestureDetector(onTap: () {
                    //                 try {
                    //                   element.sendDate=DateTime.now();
                    //                   chatController.sendMessageAgain(element);
                    //
                    //                   chatController
                    //                       .textEditingController
                    //                       .clear();
                    //                   chatController.sendButton.value =
                    //                   false;
                    //
                    //                   chatController.update();
                    //                 } catch (e) {
                    //                   print(e);
                    //                 }
                    //               },child: Icon(Icons.error,color: Colors.red,size: 20,)),
                    //             ):SizedBox(),
                    //           ],
                    //         )
                    //             : Container();
                    //     },
                    //   ),
                    // ),
                  Expanded(
                      child: ListView.builder(
                        itemCount: chatController.messages.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          var reveersIndex=chatController.messages.length-1-index;
                          var sendDate = chatController.messages[reveersIndex]
                              .sendDate;
                          String time = DateFormat('kk:mm').format(sendDate!);
                         // chatController.messages.sort((a, b) => a.sendDate!.minute.compareTo(b.sendDate!.minute));
                          return
                            chatController.messages[reveersIndex].senderId != userId
                                ?
                            ReplyCard(
                              message:
                              chatController.messages[reveersIndex].content
                                  .toString(),
                              time: time,
                            )
                                : chatController.messages[reveersIndex].senderId ==
                                userId
                                ?
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                OwnMessageCard(
                                  message:
                                  chatController.messages[reveersIndex].content
                                      .toString(),
                                  time: time.toString(),
                                  status: chatController.messages[reveersIndex].status.toString(),
                                ),
                                chatController.messages[reveersIndex].status.toString().contains("failed")? Padding(
                                  padding: const EdgeInsets.only(right: 4.0),
                                  child: GestureDetector(onTap: () {
                                    try {
                                      chatController.messages[reveersIndex].sendDate=DateTime.now();
                                        chatController.sendMessageAgain(chatController.messages[reveersIndex]);

                                      chatController
                                            .textEditingController
                                            .clear();
                                        chatController.sendButton.value =
                                        false;

                                      chatController.update();
                                    } catch (e) {
                                      print(e);
                                    }
                                  },child: Icon(Icons.error,color: Colors.red,size: 20,)),
                                ):SizedBox(),
                              ],
                            )
                                : Container();
                        },
                      ),
                    ),
                    getUserMessageController.loading.value==false?
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                    maxWidth: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 60,
                                  ),
                                  child: Directionality(
                                    textDirection: ui.TextDirection.rtl,
                                    child: Card(

                                      margin: EdgeInsets.only(left: 8,top: 8,bottom: 8,right: 2),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Obx(
                                            () =>
                                            TextFormField(
                                              controller:
                                              chatController
                                                  .textEditingController,
                                              focusNode: chatController
                                                  .focusNode,
                                              textAlignVertical:
                                              TextAlignVertical.center,
                                              keyboardType: TextInputType
                                                  .multiline,
                                              maxLines: 5,
                                              minLines: 1,
                                              onChanged: (value) {
                                                if (value.length > 0) {
                                                  chatController.sendButton
                                                      .value =
                                                  true;
                                                  chatController.update();
                                                } else {
                                                  chatController.sendButton
                                                      .value =
                                                  false;
                                                  chatController.update();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "پیام جدید",
                                                hintStyle:
                                                TextStyle(color: Colors.grey),
                                                prefixIcon: IconButton(
                                                  icon: Icon(
                                                    chatController.show.value
                                                        ? Icons.keyboard
                                                        : Icons
                                                        .emoji_emotions_outlined,
                                                    color: Palette
                                                        .primaryColorD,
                                                  ),
                                                  onPressed: () {},
                                                  iconSize: 20,
                                                ),
                                                suffixIcon: Row(
                                                  mainAxisSize: MainAxisSize
                                                      .min,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(
                                                        Icons.attach_file,
                                                        color: Palette
                                                            .primaryColorD,
                                                      ),
                                                      onPressed: () {
                                                        showModalBottomSheet(
                                                            backgroundColor:
                                                                Colors.transparent,
                                                            context: context,
                                                            builder: (builder) =>
                                                                BottomSheetChat());
                                                      },
                                                      iconSize: 20,
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                          Icons.camera_alt,
                                                          color:
                                                          Palette
                                                              .primaryColorD),
                                                      onPressed: () {
                                                        // Navigator.push(
                                                        //     context,
                                                        //     MaterialPageRoute(
                                                        //         builder: (builder) =>
                                                        //             CameraApp()));
                                                      },
                                                      iconSize: 20,
                                                    ),
                                                  ],
                                                ),
                                                contentPadding: EdgeInsets.all(
                                                    3),
                                              ),
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                    left: 2,
                                    top: 8
                                  ),
                                  child: Obx(() {
                                    return CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Palette.primaryColorD,
                                      child: IconButton(
                                        icon: Icon(
                                          chatController.sendButton.value
                                              ? Icons
                                              .send
                                              : Icons.mic,
                                          color: Colors.white,
                                          size: 20,
                                        ),

                                        onPressed: () {
                                          try {
                                            if (chatController
                                                .sendButton.value) {
                                              chatController.sendMessage(
                                                  chatController
                                                      .textEditingController
                                                      .text,
                                                  widget
                                                      .dataContactChat
                                                      .userId as int);

                                              chatController
                                                  .textEditingController
                                                  .clear();
                                              chatController.sendButton.value =
                                              false;
                                            }
                                            chatController.update();
                                          } catch (e) {
                                            print(e);
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ),
                              ],
                            ),
                            chatController.show.value
                                ? SizedBox()
                                : Container(),
                          ],
                        ),
                      ),
                    ):SizedBox(),
                  ],
                );
              }),
              onWillPop: () {
                if (chatController.show.value) {
                  chatController.show.value = false;
                  chatController.update();
                } else {
                  Navigator.pop(context);
                }
                return Future.value(false);
              },
            ),
          ),
        )
      ],
    );
  }



  @override
  void initState() {
    super.initState();

    getMessageDataBase = _getMessageDataBase();

  }
  Future<void> _getMessageDataBase() async {
    try {
      getUserMessageController.errors.value="";
      chatController.messages.clear();
      widget.dataContactChat.newMessage!.clear();
      print( "initState "+widget.dataContactChat.newMessage!.toString());
      await MessageDataBase.instance.readMessage(userId as int,widget.dataContactChat.userId as int).then((value) async {
        if(value.isEmpty){
          getUserMessageController.listMessage.clear();
          ModelGetReceivedMessage modelGetReceivedMessage=ModelGetReceivedMessage(
            recieverId:widget
                .dataContactChat
                .userId ,
            senderId:userId ,
            orgId: 4,
          );
          await Get.find<GetUserMessageController>().getFetchData(modelGetReceivedMessage);
          chatController.messages.addAll(getUserMessageController.listMessage);
        }else{

          print("value is por");
          chatController.messages.addAll(value);
        }

      });
    } catch (e) {
      print(e);

    }
  }
}
