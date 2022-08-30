


import 'package:app_karada24/apiService/request/api_service_list_accepts.dart';
import 'package:app_karada24/apiService/request/api_service_list_request.dart';
import 'package:get/get.dart';

import '../../models/requests/model_request.dart';
import '../../response/request/response_list_request.dart';
import '../../response/request/response_list_submited.dart';
import '../storagedata/StrorageAllData.dart';
class GetListRequest extends GetxController{
  RxString? error="".obs;
  var isLoading=true.obs;
  var errorPage=false.obs;
  String? token=Get.find<ControllerGetStorageAllData>().token;
  int? userId=Get.find<ControllerGetStorageAllData>().userId;
  List<DataListRequest>? listAllRequest = <DataListRequest>[].obs;
  List<DataListSubmitted>? listAllSubmit = <DataListSubmitted>[].obs;
  List<DataListSubmitted>? getListInvite=<DataListSubmitted>[].obs;
  List<DataListSubmitted>? getListRequest=<DataListSubmitted>[].obs;
  List<DataListSubmitted>? getListChatUser=<DataListSubmitted>[].obs;

  @override
  void onInit() {
    listAllRequest!.clear();
    listAllSubmit!.clear();
    getListInvite!.clear();
    getListRequest!.clear();
    getListChatUser!.clear();
    fetchListRequest(userId!,token!);
    super.onInit();
  }

  void fetchListRequest(int id,String tokens)async {

try {
 listAllRequest!.clear();
  listAllSubmit!.clear();
  getListInvite!.clear();
  getListRequest!.clear();
 getListChatUser!.clear();
  isLoading(true);
  errorPage(false);
  await ApiServiceListRequest().listRequest( tokens,4,id).then((value)async{
    try{

      if (value.data!.length>0) {
        listAllRequest=value.data!;

     await fetchListSubmittedRequests(id,tokens);
      }else{
        if(value.data!.length<=0){
          listAllRequest?.clear();
        await  fetchListSubmittedRequests(id,tokens);

        }
      }
    }catch(e){
      error?.value="مشکل در برقراری ارتباط";
      errorPage(true);
      isLoading(true);
    }

  }).catchError((onError){
    error?.value="مشکل در برقراری ارتباط";
    isLoading(true);
    errorPage(true);
  }).onError((errors, stackTrace) {
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
  Future<void> fetchListSubmittedRequests(int id,String tokens)async {
    getListInvite!.clear();
    getListRequest!.clear();
    getListChatUser!.clear();
    try {
      int? isRol=Get.find<ControllerGetStorageAllData>().IsRolId;

      await ApiServiceListSubmitted().listAccept( tokens,4,id).then((value){
     // String  checked=listAllSubmit![0].typeTittle.toString();
    //  print(checked);
        try{
          if (value.data!.length>0) {

            listAllSubmit=value.data!;
            isLoading(false);
            error?.value="";
            try{
            for(int i=0;i<listAllSubmit!.length;i++){
                if(isRol==4&& listAllSubmit![i].typeId==2)
                {
                  getListRequest!.add(listAllSubmit![i]);

                }else if( isRol==3&&listAllSubmit![i].typeId==1){
                  getListRequest!.add(listAllSubmit![i]);
                }else if( isRol==3&&listAllSubmit![i].typeId==2&&listAllSubmit![i].roleId==2){
                  getListRequest!.add(listAllSubmit![i]);
                }
                if(isRol==4&& listAllSubmit![i].typeId==1)
                {
                  getListInvite!.add(listAllSubmit![i]);

                }else if( isRol==3&&listAllSubmit![i].typeId==2&&listAllSubmit![i].roleId!=2){
                  getListInvite!.add(listAllSubmit![i]);
                }
              }
              for(int i=0;i<getListInvite!.length;i++){
                if(getListInvite![i].statusId==4){
                  getListChatUser!.add(getListInvite![i]);
                }
              }
              for(int i=0;i<getListRequest!.length;i++){
                if(getListRequest![i].statusId==4){
                  getListChatUser!.add(getListRequest![i]);
                }
              }
              print("getListInvite"+getListInvite!.length.toString());
              print("getListRequest"+getListRequest!.length.toString());
            }catch(e){
              print(e);
            }
          }else{
            if(value.data!.length<=0){
              isLoading(false);
              error?.value="لیست دیتا خالیست";
            }
          }
        }catch(e){
          error?.value="مشکل در برقراری ارتباط";
          errorPage(true);
          isLoading(true);
        }

      }).catchError((onError){
        error?.value="مشکل در برقراری ارتباط";
        isLoading(true);
        errorPage(true);
      }).onError((errors, stackTrace) {
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