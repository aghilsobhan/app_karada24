
import 'package:app_karada24/getxController/requests/requests_received.dart';
import 'package:app_karada24/models/requests/model_request_received.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../getxController/requests/request_list.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
import '../../materialcolors/materialcolors.dart';
import '../../response/request/response_list_request.dart';
import '../../response/request/response_list_submited.dart';
import '../../widgets/shimmer_load.dart';
import '../../widgets/widget_appbar.dart';
import '../../widgets/widget_errorpage.dart';
import 'component/buttom_requests.dart';
import 'component/search_request.dart';

class RequestsReceived extends StatefulWidget {

  const RequestsReceived({Key? key}) : super(key: key);

  @override
  _RequestsReceivedState createState() => _RequestsReceivedState();
}

class _RequestsReceivedState extends State<RequestsReceived> {
  String query = '';
  String? token=Get.find<ControllerGetStorageAllData>().token;
  int? userId=Get.find<ControllerGetStorageAllData>().userId;
  GetListRequest _getListRequest = Get.find<GetListRequest>();
  List<DataListSubmitted> getListRequests = <DataListSubmitted>[];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Palette.backGroundColorD,
      appBar: MyAppBar(title: 'درخواستهای دریافتی',),
      body: Column(
        children: [
          SearchRequest(
              text: query,onChanged: searchRequests, hintText: "جستجو..."),
          Obx(() {
            return _getListRequest.isLoading.value == false
                ?query.trim().length<=0? ListViewRequestReceived(Get.find<GetListRequest>().getListRequest!):ListViewRequestReceived(getListRequests)
                : _getListRequest.errorPage.value == false
                ? CustomShimmerWidgetRequest()
                : ErrorPage();
          })
        ],
      ),

    );

  }
  Widget ListViewRequestReceived(List<DataListSubmitted>? getListRequestReceived){
    return Expanded(
      child:getListRequestReceived!.length<=0? Center(
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

          itemCount: getListRequestReceived.length,

          itemBuilder: (BuildContext context, int index) {
          //  getListRequestReceived.sort((a,b)=>b.statusInt?.compareTo(a.statusInt as int)as int);
            return Slidable(
                key: const ValueKey(0),

                endActionPane: ActionPane(
                  extentRatio: 0.2,
                  motion: const ScrollMotion(),
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    ButtonStatusCancel(
                      status: "لغو",
                      requestId: getListRequestReceived[index].id as int,
                      onchangedCallback: (bool) {if(bool){
                        setState(() {
                          searchRequests('');
                        });
                      }},
                      reqSrcUserId:getListRequestReceived[index].srcUserId , reqDstUserId: getListRequestReceived[index].dstUserId, cancellerUserId: userId,
                    ),
                    Container(
                      height: 150,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Palette.primaryColorD,
                      ),
                      child: Icon(Icons.description_rounded,size: 20,color: Colors.white,),
                    )
                  ],
                ),child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getListRequestReceived[index].statusId==1?
                      ButtonStatusReceived(
                        status: 'قبول درخواست',
                        userId: getListRequestReceived[index].id as int,
                        expertId: getListRequestReceived[index].roleId as int,
                      ):
                      getListRequestReceived[index].statusId==4?
                            ButtonStatusConfirm(
                                "تایید شده"):
                            ButtonStatusWaiting(
                                "در حال بررسی"),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Text(
                                (getListRequestReceived[index].srcUserFullname==null)? "نا مشخص":getListRequestReceived[index].srcUserFullname as String,


                                style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontFamily: 'sans', fontSize:14),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  getListRequestReceived[index].description.toString(),
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
  void searchRequests(String query) {
    if (query.isEmpty) {

      setState(() {
        this.query = query;
        Get.find<GetListRequest>().getListRequest!;
       // getListInvite?.addAll(widget.listInvite!);
      });
    } else {
      final requests =  Get.find<GetListRequest>().getListRequest?.where((element) {
        final titleLowerCaseA = element.srcUserFullname?.toLowerCase();
        final titleLowerCaseB = element.dstUserFullname?.toLowerCase();
        final title=titleLowerCaseA==null?titleLowerCaseB:titleLowerCaseA;
        final searchLowerCase = query.toLowerCase();
        return title?.contains(searchLowerCase) as bool;
      }).toList();
      setState(() {
        this.query = query;
        getListRequests = requests!;
      });
    }
  }
}

