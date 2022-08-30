
import 'package:app_karada24/screen/requests/request_received.dart';
import 'package:app_karada24/screen/requests/requests%20_submitted.dart';
import 'package:app_karada24/screen/requests/see_request.dart';
import 'package:app_karada24/widgets/widget_errorpage.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:get/get.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
import '../../getxController/requests/request_list.dart';
import '../../widgets/shimmer_load.dart';
import 'component/list_request.dart';
import 'component/widget_filter.dart';
import 'component/widget_list_view_main.dart';
class Request extends StatefulWidget {

  const Request({Key? key}) : super(key: key);

  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> with TickerProviderStateMixin {
  String query = '';
  GetListRequest _getListRequest=Get.find<GetListRequest>();
  String? token=Get.find<ControllerGetStorageAllData>().token;
  int? userId=Get.find<ControllerGetStorageAllData>().userId;
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Palette.backGroundColorD,
        appBar: AppBar(
          elevation: 0.0,

          actions: [
            GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return RequestsSubmitted();
                      }));
                },
                child: StyleFilter(title: 'درخواستهای ارسال شده', textColor:  Colors.white,)),
            GestureDetector(onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) {
                    return RequestsReceived();
                  }));
            },
                child: StyleFilter(title: 'درخواستهای دریافتی ', textColor: Colors.white,)),
          ],
          backgroundColor: Palette.backGroundColorD,

        ),
        body: Column(
          children: [
           Obx((){
             return _getListRequest.isLoading.value==false?
             Get.find<GetListRequest>().listAllSubmit!.length<=0&& Get.find<GetListRequest>().listAllRequest!.length<=0 ?
             Column(
               children: [
                 SizedBox(height: (MediaQuery.of(context).size.height/2)-50),
                 Center(
                   child: Text(
                     "درخواستی برای شما ثبت نشده",
                     style: TextStyle(
                         fontFamily: "sans",
                         fontSize: 12,
                         color: Colors.red,
                         ),
                   ),
                 ),

             ]):
             Expanded(
               child: ListView(
                 physics: BouncingScrollPhysics(),

                   children: [

            //    Container(child: ListViewSubmit(getListSubmitted: Get.find<GetListRequest>().listAllSubmit,)),
                     ListViewLimitedMain(),
                     Get.find<GetListRequest>().listAllSubmit!.length>0?
                     GestureDetector(onTap: (){
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) {
                             return ListSeeViewSubmit();
                           }));
                     },
                         child: Align( alignment: Alignment.center,
                             child: Padding(padding: EdgeInsets.all(8),
                                 child: Text("دیدن همه موارد",style: TextStyle(fontFamily: "sans",fontSize: 14,color: Colors.blue),)))):SizedBox(),
                     Container(child:ListViewRequest(getListRequest:Get.find<GetListRequest>().listAllRequest)),
                     Get.find<GetListRequest>().listAllRequest!.length>0? GestureDetector(onTap: (){
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) {
                             return ListSeeViewRequest();
                           }));
                     },
                         child: Align( alignment: Alignment.center,
                             child: Padding(padding: EdgeInsets.all(8),
                                 child: Text("دیدن همه موارد",style: TextStyle(fontFamily: "sans",fontSize: 14,color: Colors.blue),)))):SizedBox()
                   ]),
             ):
             _getListRequest.errorPage.value==false ?CustomShimmerWidgetRequest():ErrorPage();
           }),
          ],
        ),

        // floatingActionButton: FloatingActionButton(onPressed: () {  },
        //   mini: true,
        //   backgroundColor: Palette.primaryColorD,
        //   child: Icon(Icons.person_add),
        //
        // ),
      );

  }
  @override
  void initState() {
    super.initState();
    Get.find<GetListRequest>().fetchListRequest(userId!,token!);
  }

}
