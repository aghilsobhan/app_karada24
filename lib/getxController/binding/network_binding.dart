
import 'package:app_karada24/getxController/requests/request_list.dart';
import 'package:app_karada24/getxController/requests/request_submited.dart';
import 'package:app_karada24/getxController/requests/requests_received.dart';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/screen/chat_page/controller/chat_controller.dart';
import 'package:app_karada24/screen/chat_page/controller/get_contact_message_controller.dart';
import 'package:app_karada24/screen/chat_page/controller/get_list_contact.dart';

import 'package:get/get.dart';

import '../check_badge_tickets.dart';
import '../internet/getx_network_manager.dart';
import '../list_ticket.dart';
import '../value_department_id.dart';
class Binding extends Bindings{
  // dependence injection attach our class.
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<GetXNetworkManager>(() => GetXNetworkManager());
    Get.lazyPut<GetListTicketing>(() => GetListTicketing());
    Get.lazyPut<GetListRequest>(() => GetListRequest());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<GetListRequestsReceived>(() => GetListRequestsReceived());
    Get.lazyPut<GetListSubmittedRequests>(() => GetListSubmittedRequests());
    Get.lazyPut<GetBadge>(() => GetBadge());
    Get.lazyPut<ValueDepartmentDepId>(() => ValueDepartmentDepId());
    Get.lazyPut<GetUserMessageController>(() => GetUserMessageController());
    Get.lazyPut<GetUserChatController>(() => GetUserChatController());
    Get.lazyPut(() => ControllerGetStorageAllData());
  }
}