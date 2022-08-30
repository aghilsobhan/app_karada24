import 'package:app_karada24/getxController/check_badge_tickets.dart';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/screen/chat_page/controller/get_list_contact.dart';
import 'package:app_karada24/screen/chat_page/database/message_database.dart';
import 'package:app_karada24/screen/chat_page/model/model_received_chat.dart';
import 'package:app_karada24/screen/chat_page/model/model_send_connect_online.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

class ChatController extends GetxController {
  final show = false.obs;
  FocusNode focusNode = FocusNode();
  final sendButton = false.obs;
  final status = "".obs;
  RxList<ModelRecivedMessage> messages = RxList<ModelRecivedMessage>();
  TextEditingController textEditingController = TextEditingController();
  ScrollController scrollController = ScrollController();

  int? userId = Get.find<ControllerGetStorageAllData>().userId;
  String? fullName = Get.find<ControllerGetStorageAllData>().fullName;
  String? userName = Get.find<ControllerGetStorageAllData>().userName;
  HubConnection? hubConnection;
  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        show.value = false;
        update();
      }
    });
    connect();
    update();
  }

  @override
  void onReady() {
    print("onReady");
    super.onReady();
  }

  @override
  void onClose() {
    print("onClose");
    super.onClose();
  }

  Future<void> connect() async {
    List<ModelSendContactOnline> modelSendContactOnline = [
      ModelSendContactOnline(
          userId: userId, fullname: fullName, username: userName)
    ];
    try {
      print(" ${hubConnection?.connectionId}");
      print(" ${hubConnection?.state}");

      if (hubConnection?.state == null) {
        print(hubConnection?.state);
        print("آی دی  ${hubConnection?.connectionId}");
        hubConnection = await HubConnectionBuilder()
            .withUrl("https://crm.phx.ir/chathub")
            .withAutomaticReconnect(retryDelays: [
          2000,
          8000,
          16000,
          36000,
          60000,
          75000,
          120000
        ]).build();
        hubConnection?.onclose(({error}) {
          connect();
          print("onclose");
        });
        hubConnection?.onreconnecting(({error}) {
          print(error);
          print("1 تلاش برای برقراری ارتباط");
          status.value = "reconnection";
          update();
          if (hubConnection?.state == HubConnectionState.Connected) {
            print("آی دی  ${hubConnection?.connectionId} بعد از شرط");
            print("وضعیت کانکت بعد reconnection");
            print(hubConnection?.state);
            status.value = "success";
            update();
            hubConnection
                ?.invoke("UsersOnConnect", args: modelSendContactOnline)
                .then((value) async {
              print("  بعد از شرط کاربران انلاین");
            }).catchError((onError) {
              print("خطای داخل شرط");
            }).onError((error, stackTrace) {
              print("خطای داخل شرط");
            });
            hubConnection?.on(
                "BroadcastOnline", (users) => {print("BroadcastOnline")});
            hubConnection?.on("RecieveMsg", handleAClientProvidedFunction);
          }
        });
        hubConnection?.onreconnected(({connectionId}) {
          print("اتصال برقرار شد");
          status.value = "success";
          update();
          print(
              " وضعیت اتصال  بعد از onreconnected${hubConnection?.state.toString()}");
        });
        await hubConnection?.start()?.then((value) {
          print("وضعیت قبل از شرط${hubConnection?.state}");
          status.value = "success";
          update();
          hubConnection
              ?.invoke("UsersOnConnect", args: modelSendContactOnline)
              .then((value) async {
            print("  قبل از شرط کاربران انلاین");
          }).catchError((onError) {
            print("catchError داخلی");
          }).onError((error, stackTrace) {
            print("داخلی");
          });
          hubConnection?.on("BroadcastOnline", (users) => {print(users)});
          hubConnection?.on("RecieveMsg", handleAClientProvidedFunction);
          hubConnection?.onreconnecting(({error}) {
            print(error);
            print("2  تلاش برای برقراری ارتباط");
            status.value = "reconnection";
            update();
          });
        });
        hubConnection?.on("RecieveMsg", handleAClientProvidedFunction);
        print(" وضعیت اتصال ${hubConnection?.state.toString()}");
      }
      if (hubConnection?.state == HubConnectionState.Connected) {
        print("آی دی  ${hubConnection?.connectionId} بعد از شرط");
        print("وضعیت کانکت بعد ازشرط");
        print(hubConnection?.state);
        status.value = "success";
        update();
        hubConnection
            ?.invoke("UsersOnConnect", args: modelSendContactOnline)
            .then((value) async {
          print("  بعد از شرط کاربران انلاین");
        }).catchError((onError) {
          print("خطای داخل شرط");
        }).onError((error, stackTrace) {
          print("خطای داخل شرط");
        });
        hubConnection?.on("BroadcastOnline", (users) => {print(users)});
        hubConnection?.on("RecieveMsg", handleAClientProvidedFunction);
      }
      if (hubConnection?.state == HubConnectionState.Disconnected) {
        hubConnection = null;
        connect();
      }
      if (hubConnection?.state == HubConnectionState.Reconnecting) {
        hubConnection?.onreconnecting(({error}) {
          print("4 تلاش برای برقراری ارتباط");
          print("وضعیت Reconnecting ${hubConnection?.state}");
          status.value = "reconnection";
          update();
          if (hubConnection?.state == HubConnectionState.Connected) {
            print("آی دی  ${hubConnection?.connectionId} بعد از شرط");
            print("وضعیت کانکت بعد ازشرط");
            status.value = "success";
            update();
            hubConnection
                ?.invoke("UsersOnConnect", args: modelSendContactOnline)
                .then((value) async {
              print("  بعد از شرط کاربران انلاین");
            }).catchError((onError) {
              print("خطای داخل شرط");
            }).onError((error, stackTrace) {
              print("خطای داخل شرط");
            });
            hubConnection?.on("BroadcastOnline", (users) => {print(users)});
            hubConnection?.on("RecieveMsg", handleAClientProvidedFunction);
          }
        });
      }
      //print(hubConnection);
      update();
    } catch (e) {
      status.value = "failed";
      update();
      throw Exception("connection error " + e.toString());
    }
  }

  void handleAClientProvidedFunction(List<Object>? parameters) async {
    try {
      ModelRecivedMessageBool messageModel = ModelRecivedMessageBool.fromJson(
          parameters![1] as Map<String, dynamic>);
      print("پیام دریافتی");
      ModelRecivedMessage messagea = ModelRecivedMessage(
        senderId: messageModel.senderId,
        senderUsername: messageModel.senderUsername,
        senderFullname: messageModel.senderFullname,
        recieverId: messageModel.recieverId,
        recieverUsername: messageModel.recieverUsername,
        recieverFullname: messageModel.recieverFullname,
        sendDate: messageModel.sendDate,
        content: messageModel.content,
        senderIsNew: messageModel.senderIsNew == true ? 1 : 0,
        recieverIsNew: messageModel.recieverIsNew == true ? 1 : 0,
        senderIsSeen: messageModel.senderIsSeen == true ? 1 : 0,
        recieverIsSeen: messageModel.recieverIsSeen == true ? 1 : 0,
        isSenderDeleted: messageModel.isSenderDeleted == true ? 1 : 0,
        isRecieverDeleted: messageModel.isRecieverDeleted == true ? 1 : 0,
        status: messageModel.status,
      );
      messages.add(messagea);
      Get.find<GetBadge>().CheckedBadgeChat(messagea);


      await MessageDataBase.instance.create(messagea);

      update();
    } catch (e) {
      update();
      print(e);
    }
  }

  void sendMessage(String messageText, int recieverId) async {
    try {
      print("وضعیت ارسال شده" + status.value);
      ModelRecivedMessage messageLocal = ModelRecivedMessage(
          senderId: userId,
          senderUsername: userName,
          senderFullname: fullName,
          recieverId: recieverId,
          recieverUsername: "",
          recieverFullname: "",
          sendDate: DateTime.now(),
          content: messageText,
          senderIsNew: 1,
          recieverIsNew: 1,
          senderIsSeen: 1,
          recieverIsSeen: 0,
          isSenderDeleted: 0,
          isRecieverDeleted: 0,
          status: status.value);
      if (hubConnection?.state == HubConnectionState.Connected) {
        List<ModelRecivedMessageBool> sendMessageToUser = [
          ModelRecivedMessageBool(
              id: 0,
              senderId: userId,
              senderUsername: userName,
              senderFullname: fullName,
              recieverId: recieverId,
              recieverUsername: "",
              recieverFullname: "",
              sendDate: DateTime.now(),
              content: messageText,
              senderIsNew: true,
              recieverIsNew: true,
              senderIsSeen: true,
              recieverIsSeen: true,
              isSenderDeleted: false,
              isRecieverDeleted: false,
              status: status.value)
        ];
        hubConnection
            ?.invoke("SendMessageToUser", args: sendMessageToUser)
            .then((value) async {
          status.value = "success";
          messageLocal.status = "success";
          update();
          print("پیام ارسال شده");
          print(sendMessageToUser[0].toJson());
          print("local");
          await MessageDataBase.instance.create(messageLocal).then((value) {
            messages.add(value);
            print(value.toJson());
          });
          update();
        }).catchError((onError) {
          status.value = "failed";
          messageLocal.status = "failed";
          MessageDataBase.instance.create(messageLocal).then((value) {
            messages.add(value);
          });
          update();
          print("catchError");
        }).onError((error, stackTrace) {
          status.value = "failed";
          messageLocal.status = "failed";
          MessageDataBase.instance.create(messageLocal).then((value) {
            messages.add(value);
          });
          update();
          print(error);
        });
        update();
      } else {
        messageLocal.status = "failed";
        await MessageDataBase.instance.create(messageLocal).then((value) {
          messages.add(value);
        });
        await connect();
      }
    } catch (e) {
      status.value = "failed";
      update();
      print(e);
    }
    update();
  }

  void sendMessageAgain(ModelRecivedMessage modelRecivedMessage) async {
    try {
      if (hubConnection?.state == HubConnectionState.Connected) {
        List<ModelRecivedMessageBool> sendMessageToUser = [
          ModelRecivedMessageBool(
              id: modelRecivedMessage.id,
              senderId: modelRecivedMessage.senderId,
              senderUsername: modelRecivedMessage.senderUsername,
              senderFullname: modelRecivedMessage.senderFullname,
              recieverId: modelRecivedMessage.recieverId,
              recieverUsername: modelRecivedMessage.recieverUsername,
              recieverFullname: modelRecivedMessage.recieverFullname,
              sendDate: DateTime.now(),
              content: modelRecivedMessage.content,
              senderIsNew: modelRecivedMessage.senderIsSeen == 1 ? true : false,
              recieverIsNew:
                  modelRecivedMessage.recieverIsNew == 1 ? true : false,
              senderIsSeen:
                  modelRecivedMessage.senderIsSeen == 1 ? true : false,
              recieverIsSeen:
                  modelRecivedMessage.recieverIsSeen == 1 ? true : false,
              isSenderDeleted:
                  modelRecivedMessage.isSenderDeleted == 1 ? true : false,
              isRecieverDeleted:
                  modelRecivedMessage.isRecieverDeleted == 0 ? true : false)
        ];
        hubConnection
            ?.invoke("SendMessageToUser", args: sendMessageToUser)
            .then((value) async {
          status.value = "success";
          modelRecivedMessage.status = "success";
          update();
          print("send Message Again");
          print(sendMessageToUser[0].toJson());
          modelRecivedMessage.sendDate = DateTime.now();
          print(modelRecivedMessage.toJson());
          await MessageDataBase.instance
              .updateMessage(modelRecivedMessage)
              .then((value) async {
            messages.removeWhere((element) {
              return element.id == modelRecivedMessage.id;
            });
            messages.add(modelRecivedMessage);
            update();
          });
        }).catchError((onError) {
          status.value = "failed";
          // messageLocal.status="failed";
          // messages.add(messageLocal);
          // MessageDataBase.instance.create(messageLocal);
          update();
          print("catchError");
        }).onError((error, stackTrace) {
          status.value = "failed";
          // messageLocal.status="failed";
          // messages.add(messageLocal);
          // MessageDataBase.instance.create(messageLocal);
          update();
          print(error);
        });
        update();
      } else {
        // messageLocal.status="failed";
        // messages.add(messageLocal);
        // MessageDataBase.instance.create(messageLocal);
        await connect();
      }
    } catch (e) {
      status.value = "failed";
      update();
      print(e);
    }
    update();
  }
}
