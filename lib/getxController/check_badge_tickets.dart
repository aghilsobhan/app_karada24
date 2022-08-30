import 'package:app_karada24/screen/chat_page/controller/get_list_contact.dart';
import 'package:app_karada24/screen/chat_page/model/model_received_chat.dart';
import 'package:get/get.dart';

class GetBadge extends GetxController{
  var isBadge=false.obs;
  RxList<ModelRecivedMessage> badgeNew = RxList<ModelRecivedMessage>();
  GetUserChatController getListContact = Get.find<GetUserChatController>();
  void CheckedBadge(bool value){
    isBadge.value=value;
  }
  Future<void> CheckedBadgeChat(ModelRecivedMessage value)async{
    badgeNew.add(value);

  }

}