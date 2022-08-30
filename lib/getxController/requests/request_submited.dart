


import 'package:app_karada24/apiService/request/api_service_list_accepts.dart';
import 'package:get/get.dart';
import '../../models/requests/model_request_submited.dart';
import '../../response/request/response_list_submited.dart';
import '../storagedata/StrorageAllData.dart';
class GetListSubmittedRequests extends GetxController{
  RxString? error="".obs;
  var isLoading=true.obs;
  var errorPage=false.obs;
  String? token=Get.find<ControllerGetStorageAllData>().token;
  int? userId=Get.find<ControllerGetStorageAllData>().userId;
  List<DataListSubmitted>? listAllRequest = <DataListSubmitted>[].obs;

  @override
  void onInit() {
    fetchListSubmittedRequests();
    super.onInit();
  }
  void fetchListSubmittedRequests()async {
 try {
      // listAllRequest?.clear();
      isLoading(true);
      errorPage(false);
      await ApiServiceListSubmitted().listAccept( token!,4,Get.find<ControllerGetStorageAllData>().userId as int).then((value){
        try{
          if (value.data != null) {
            listAllRequest=value.data!;
            isLoading(false);
            error?.value="";
          }else{
            if(value.data==null){

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