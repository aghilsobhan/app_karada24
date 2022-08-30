
import 'package:app_karada24/getxController/requests/request_submited.dart';
import 'package:app_karada24/models/requests/model_request_submited.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../getxController/requests/request_list.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
import '../../materialcolors/materialcolors.dart';
import '../../response/request/response_list_submited.dart';
import '../../widgets/shimmer_load.dart';
import '../../widgets/widget_appbar.dart';
import '../../widgets/widget_errorpage.dart';
import 'component/buttom_requests.dart';
import 'component/search_request.dart';

class RequestsSubmitted extends StatefulWidget {
  const RequestsSubmitted({Key? key}) : super(key: key);

  @override
  _RequestsSubmittedState createState() => _RequestsSubmittedState();
}

class _RequestsSubmittedState extends State<RequestsSubmitted> {
  String query = '';
  GetListRequest _getListRequest = Get.find<GetListRequest>();
  List<DataListSubmitted>? getListRequest=<DataListSubmitted>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backGroundColorD,
      appBar: MyAppBar(title: 'درخواستهای ارسال شده',),
      body: Column(
        children: [
          SearchRequest(
              text: query, onChanged:searchRequests ,hintText: "جستجو..."),
          Obx(() {
            return _getListRequest.isLoading.value == false
                ?query.trim().length<=0? ListViewRequestsSubmitted(Get.find<GetListRequest>().getListInvite!):ListViewRequestsSubmitted(getListRequest)
                : _getListRequest.errorPage.value == false
                ? CustomShimmerWidgetRequest()
                : ErrorPage();
          })

        ],
      ),

    );

  }

  void searchRequests(String query) async{
    if (query.isEmpty) {

      setState(() {
        this.query = query;
        Get.find<GetListRequest>().getListInvite;
      });
    } else {
      final requests =  Get.find<GetListRequest>().getListInvite?.where((element) {
        final titleLowerCaseA = element.srcUserFullname?.toLowerCase();
        final titleLowerCaseB = element.dstUserFullname?.toLowerCase();
        final title=titleLowerCaseA==null?titleLowerCaseB:titleLowerCaseA;
        final searchLowerCase = query.toLowerCase();
        return title?.contains(searchLowerCase) as bool;
      }).toList();
      setState(() {
        this.query = query;
        getListRequest = requests;
      });
    }
  }
  Widget ListViewRequestsSubmitted(List<DataListSubmitted>? getListSubmitted) {
    return Expanded( child:getListSubmitted!.length<=0? Center(
      child: Text(
        'درخواستی وجود ندارد  ',
        style: TextStyle(
          fontFamily: "sans",
          fontSize: 12,
        ),
      ),
    ):
    ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: getListSubmitted.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
                key: const ValueKey(0),

                endActionPane: ActionPane(
                  extentRatio: 0.2,
                  motion: const ScrollMotion(),
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    ButtonStatusCancel(
                      status: "لغو",
                      requestId: getListSubmitted[index].id as int,
                      onchangedCallback: (bool) {if(bool){
                        setState(() {
                          searchRequests('');
                        });
                      }},
                      reqSrcUserId:getListSubmitted[index].srcUserId , reqDstUserId: getListSubmitted[index].dstUserId, cancellerUserId:Get.find<ControllerGetStorageAllData>().userId,

                    ),
                  ],
                ),child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getListSubmitted[index].statusId==1?
                            ButtonStatusWaiting(
                               "در انتظار تایید")
                          :
                      getListSubmitted[index].statusId==4?
                            ButtonStatusConfirm(
                                "تایید شده")
                          :
                      getListSubmitted[index].statusId==5?
                      ButtonStatusWaiting(
                          "رد شده"):
                            ButtonStatusWaiting(
                                "در حال بررسی"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Text(
                                getListSubmitted[index].dstUserFullname.toString(),


                                style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontFamily: 'sans', fontSize:14),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  getListSubmitted[index].description.toString(),
                                  textAlign: TextAlign.end,

                                  style:TextStyle( color: Palette.gradient2, fontFamily: 'sans', fontSize:12,  ),
                                ),
                              ),
                            ],
                          ),

                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: AssetImage(
                             "images/profile.png",
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      )

                    ],
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                  )
                ],
              ),
            ));
          }),
    );
  }
}

