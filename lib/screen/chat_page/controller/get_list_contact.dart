
import 'package:app_karada24/apiService/chatapi/api_service_list_contactchat.dart';
import 'package:app_karada24/response/chat/response_get_contact.dart';
import 'package:app_karada24/screen/chat_page/model/model_get_contact.dart';
import 'package:get/get.dart';

import '../database/message_database.dart';

class GetUserChatController extends GetxController{
  final  loading=false.obs;
  final errors="".obs;
  List<DataContactChat> listContactChat=<DataContactChat>[].obs;
  Future<void> getFetchData(int orgId,int userId,int roleId)async{
    ModelGetReceivedContact modelGetReceivedContact=ModelGetReceivedContact(
orgId:orgId ,
      userId: userId,
      roleId:roleId
    );
    listContactChat.clear();
    loading.value=true;
    update();
    try{
      ApiServiceListContactChat api=ApiServiceListContactChat();
      await api.listContact(modelGetReceivedContact).then((value) {
        if(value.isSuccess==true && value.data!.length>0){
          // for(int i=0;i<value.data!.length;i++){
          //   MessageDataBase.instance.readMessage(userId ,value.data![i].userId as int).then((value) async {
          //     if(value.isNotEmpty) {
          //       print(value.last.content);
          //       listContactChat[i].endMessage = value.last.content;
          //     }else{
          //       listContactChat[i].endMessage = "ارسال پیام";
          //     }
          //   });
          // }

          listContactChat.addAll(value.data as List<DataContactChat>);
          print( 'is this ${listContactChat[0].newMessage}');
          loading.value=false;
          errors.value="";
          update();
        }else{
          listContactChat=listContactChat;
          loading.value=false;
          errors.value="مخاطبی برای شماثبت نشده است";
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