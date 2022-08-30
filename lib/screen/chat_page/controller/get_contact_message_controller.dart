import 'package:app_karada24/apiService/chatapi/api_service_get_message.dart';
import 'package:app_karada24/screen/chat_page/database/message_database.dart';
import 'package:app_karada24/screen/chat_page/model/model_get_recived_message.dart';
import 'package:app_karada24/screen/chat_page/model/model_received_chat.dart';
import 'package:get/get.dart';

class GetUserMessageController extends GetxController{
  final  loading=false.obs;
  final errors="".obs;
  List<ModelRecivedMessage> listMessage=<ModelRecivedMessage>[];
  ModelRecivedMessage modelRecivedMessage=ModelRecivedMessage();
  Future<void> getFetchData(ModelGetReceivedMessage modelGetReceivedMessage)async{
    loading.value=true;
    update();
    try{
      ApiServiceListMessage api=ApiServiceListMessage();
     await api.listMessages(modelGetReceivedMessage).then((value) {
        if(value.isSuccess==true){
          value.data!.forEach((element) async {
            ModelRecivedMessage messageLocal=ModelRecivedMessage(
                senderId: element.senderId,
                senderUsername: element.senderUsername,
                senderFullname: element.senderFullname,
                recieverId:element.recieverId,
                recieverUsername:element.recieverUsername,
                recieverFullname: element.recieverFullname,
                sendDate:element.sendDate,
                content: element.content,
                senderIsNew: element.senderIsNew == true ? 1 : 0,
                recieverIsNew: element.recieverIsNew == true ? 1 : 0,
                senderIsSeen: element.senderIsSeen == true ? 1 : 0,
                recieverIsSeen: element.recieverIsSeen == true ? 1 : 0,
                isSenderDeleted: element.isSenderDeleted == true ? 1 : 0,
                isRecieverDeleted: element.isRecieverDeleted == true ? 1 : 0,
                status: element.status);
            listMessage.add(messageLocal);
            await MessageDataBase.instance.create(messageLocal);
          });
          loading.value=false;
          errors.value="";
          update();
        }else{
          listMessage=listMessage;
          loading.value=false;
          errors.value="پیامی برای این مخاطب وجود ندارد";
          update();
        }

      }).onError((error, stackTrace) {
        loading.value=false;
        errors.value=" خطا در دریافت اطلاعات "+error.toString();
        update();
      }).catchError((onError){
        errors.value=" خطا در دریافت اطلاعات "+onError;
        loading.value=false;
        update();
      });
    }catch(e){
      errors.value=" خطا در دریافت اطلاعات "+e.toString();
      loading.value=false;
      update();
    }

  }
}