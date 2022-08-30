
import 'package:app_karada24/apiService/api_service_listtickets.dart';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/response/response_list_tickets.dart';
import 'package:get/get.dart';

import 'check_badge_tickets.dart';

class GetListTicketing extends GetxController{
  RxString? error="".obs;
   var isLoading=true.obs;
   var errorPage=false.obs;
   String? token=Get.find<ControllerGetStorageAllData>().token;
   int? userRolId=Get.find<ControllerGetStorageAllData>().userRolId;
   List<DataTicket>? listSendingTicketing = <DataTicket>[].obs;
   List<DataTicket>? listOpenTicketing = <DataTicket>[].obs;
   List<DataTicket>? listCloseTicketing = <DataTicket>[].obs;
   List<DataTicket>? listReceiveTicketing = <DataTicket>[].obs;
@override
  void onInit() {
  fetchListTicketing(userRolId!, token!);
  super.onInit();
  }

  void fetchListTicketing(int id,String token)async {

    try {
      var badgeShow = false;
      listCloseTicketing!.clear();
      listOpenTicketing!.clear();
      listSendingTicketing!.clear();
      listReceiveTicketing!.clear();
      isLoading(true);
      errorPage(false);

       await ApiServiceListTickets().listTickets(id,Get.find<ControllerGetStorageAllData>().organId, Get.find<ControllerGetStorageAllData>().IsRolId,token).then((ticketing){
         if (ticketing.data!=null) {

           for (int i = 0; i < ticketing.data!.length; i++) {
             if (ticketing.data![i].newReplyCount! > 0) {
               badgeShow = true;
             }
             if (ticketing.data![i].roleId! == 0) {
               listSendingTicketing!.add(ticketing.data![i]);
             }else{
               listReceiveTicketing!.add(ticketing.data![i]);
             }

             if (ticketing.data![i].tckStatId == 3 &&ticketing.data![i].roleId! == 0) {
               listCloseTicketing!.add(ticketing.data![i]);
             } else if(ticketing.data![i].tckStatId != 3  &&ticketing.data![i].roleId! == 0) {
               listOpenTicketing!.add(ticketing.data![i]);
             }
           }
           Get.find<GetBadge>().CheckedBadge(badgeShow);
           error?.value="";
           isLoading(false);
           print('listReceiveTicketing '+listReceiveTicketing!.length.toString());
           print('listSendingTicketing '+listSendingTicketing!.length.toString());
         }else{
           if(ticketing.error!=null){
             error?.value=error!.toString();
             isLoading(true);
             errorPage(true);
           }
         }
      }).catchError((onError){
         error?.value="مشکل در برقراری ارتباط";
         isLoading(true);
         errorPage(true);
      });

    } catch (e){
      error?.value="مشکل در برقراری ارتباط";
      errorPage(true);
      isLoading(true);
    }
  }
}