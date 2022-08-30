import 'package:app_karada24/models/requests/model_request_received.dart';
import 'package:get/get.dart';
class GetListRequestsReceived extends GetxController{
  RxString? error="".obs;
  var isLoading=true.obs;
  var errorPage=false.obs;
  // String? token=Get.find<ControllerGetStorageAllData>().token;
  // int? userId=Get.find<ControllerGetStorageAllData>().userId;
  List<ModelRequestsReceived>? listAllRequest = <ModelRequestsReceived>[].obs;

  @override
  void onInit() {
    fetchListRequestsReceived();
    super.onInit();
  }

  void fetchListRequestsReceived()async {
    try {
      listAllRequest!.clear();
      isLoading(true);
      errorPage(false);
      listAllRequest?.add(ModelRequestsReceived(name: "عقیل سبحانی",profile: "images/profile.png",status: "قبول درخواست",unit: "فنی(برنامه نویسی موبایل , برنامه نویسی وب)",statusInt: 2));
      listAllRequest?.add(ModelRequestsReceived(name: "حمیدرضا شاهنظری",profile: "images/profile.png",status: "قبول درخواست",unit: "فنی(برنامه نویسی موبایل)",statusInt: 2),);
      listAllRequest?.add(ModelRequestsReceived(name: "مجتبی شیروانی",profile: "images/profile.png",status: "قبول درخواست",unit: "فنی(برنامه نویسی وب)",statusInt: 2));
      listAllRequest?.add(ModelRequestsReceived(name: "پریسا باقری",profile: "images/profile.png",status: "تایید شده",unit: "اداری(مالیات)",statusInt: 1));
      listAllRequest?.add(ModelRequestsReceived(name: "مجتبی شیروانی",profile: "images/profile.png",status: "تایید شده",unit: "فنی(برنامه وب)",statusInt: 1));
      listAllRequest?.add(ModelRequestsReceived(name: "معصومه نادی",profile: "images/profile.png",status: "تایید شده",unit: "اداری",statusInt: 1));
    } catch (e){
      error?.value="مشکل در برقراری ارتباط";
      errorPage(true);
      isLoading(true);
    }
  }
}