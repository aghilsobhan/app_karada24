import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/response/request/response_list_request.dart';
import 'package:app_karada24/response/request/response_list_submited.dart';
import 'package:app_karada24/screen/requests/component/widget_list_view_main.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../getxController/requests/request_list.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
import '../../widgets/shimmer_load.dart';
import '../../widgets/widget_appbar.dart';
import '../../widgets/widget_errorpage.dart';
import 'component/buttom_requests.dart';
import 'component/search_request.dart';

class ListSeeViewRequest extends StatefulWidget {
  ListSeeViewRequest({Key? key}) : super(key: key);

  @override
  _ListSeeViewRequestState createState() => _ListSeeViewRequestState();
}

class _ListSeeViewRequestState extends State<ListSeeViewRequest> {
  String query = '';
  GetListRequest _getListRequest = Get.find<GetListRequest>();
  List<DataListRequest> _getListRequests = <DataListRequest>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.backGroundColorD,
        appBar: MyAppBar(
          title: 'درخواستها',
        ),
        body: Column(
          children: [
            SearchRequest(
                text: query, onChanged: searchRequests, hintText: "جستجو..."),
            Obx(() {
              return _getListRequest.isLoading.value == false
                  ?query.trim().length<=0? ListRequest(Get.find<GetListRequest>().listAllRequest!):ListRequest(_getListRequests)
                  : _getListRequest.errorPage.value == false
                      ? CustomShimmerWidgetRequest()
                      : ErrorPage();
            })
          ],
        ));
  }

  void searchRequests(String query) {
    if (query.isEmpty) {
      setState(() {
        this.query = query;
        //Get.find<GetListRequest>().fetchListRequest(userId!,token!);
          Get.find<GetListRequest>().listAllRequest!;
        // getListInvite?.addAll(widget.listInvite!);
      });
    } else {
      final requests =
          Get.find<GetListRequest>().listAllRequest!.where((element) {
        final titleLowerCase = element.fullname?.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return titleLowerCase?.contains(searchLowerCase) as bool;
      }).toList();
      setState(() {
        this.query = query;
        _getListRequests=requests;
      //  ListRequest(requests);
      });
    }
  }

  Widget ListRequest(List<DataListRequest>? getListRequests) {
    return getListRequests!.length <= 0
        ? Center(
            child: Text(
              "درخواستی وجود ندارد",
              style: TextStyle(
                  fontSize: 14, fontFamily: "sans", color: Colors.black),
            ),
          )
        : ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: getListRequests == null
                ? 0
                : (getListRequests.length > 5
                ? 5
                : getListRequests.length),
            itemBuilder: (BuildContext context, int index) {
              //widget.getListRequest?.sort((a,b)=>b.?.compareTo(a.statusInt as int)as int);
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonStatusAdd(
                          status: "ارسال درخواست",
                          userId: getListRequests[index].userId as int, onchangedCallback: (bool ) {
                            if(bool){
                              setState(() {
                                searchRequests('');
                              });

                            }else{
                              print("test  "+false.toString());
                            }
                        },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  getListRequests[index].fullname.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'sans',
                                      fontSize: 14),
                                ),
                                Container(
                                  width: 150,
                                  child: Text(
                                    getListRequests[index].organName.toString(),
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: Palette.gradient2,
                                      fontFamily: 'sans',
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            CircleAvatar(
                              radius: 25.0,
                              backgroundImage: AssetImage(
                                //  widget.getListRequest![index].profile
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
              );
            });
  }

}

class ListSeeViewSubmit extends StatefulWidget {
  ListSeeViewSubmit({Key? key})
      : super(key: key);

  @override
  _ListSeeViewSubmitState createState() => _ListSeeViewSubmitState();
}

class _ListSeeViewSubmitState extends State<ListSeeViewSubmit> {
  String query = '';
  GetListRequest _getListRequest = Get.find<GetListRequest>();
  List<DataListSubmitted> _getListRequests = <DataListSubmitted>[];
  List<DataListSubmitted> _getListInvite = <DataListSubmitted>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backGroundColorD,
      appBar: MyAppBar(
        title: 'همه درخواستها',
      ),
      body:Column(
        children: [
          SearchRequest(
              text: query, onChanged: searchRequests, hintText: "جستجو..."),
          Obx(() {
            return _getListRequest.isLoading.value == false
                ? query.trim().length<=0?
            ListViewAllMain(getListRequestReceived: Get.find<GetListRequest>().getListRequest!,
              getListSubmitted: Get.find<GetListRequest>().getListInvite!,):
            ListViewAllMain(getListRequestReceived: _getListRequests, getListSubmitted: _getListInvite,)
                : _getListRequest.errorPage.value == false
                ? CustomShimmerWidgetRequest()
                : ErrorPage();
          })
        ],
      ),
    );
  }
  void searchRequests(String query) {
    if (query.isEmpty) {
      setState(() {
        this.query = query;
        Get.find<GetListRequest>().getListRequest!;
        Get.find<GetListRequest>().getListInvite!;
      });
    } else {
      final requests =
      Get.find<GetListRequest>().getListRequest!.where((element) {
        final srcUserFullname = element.srcUserFullname?.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return srcUserFullname?.contains(searchLowerCase) as bool;
      }).toList();
      final invite =
      Get.find<GetListRequest>().getListInvite!.where((element) {
        final dstUserFullname = element.dstUserFullname?.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return dstUserFullname?.contains(searchLowerCase) as bool;
      }).toList();
      setState(() {
        this.query = query;
        _getListInvite=invite;
        _getListRequests=requests;
        //  ListRequest(requests);
      });
    }
  }
//   Widget ListRequest(List<DataListSubmitted>? getListRequests){
//     return getListRequests!.length <= 0
//         ? Center(
//       child: Text(
//         "درخواستی وجود ندارد",
//         style: TextStyle(
//             fontSize: 14, fontFamily: "sans", color: Colors.black),
//       ),
//     )
//         :  ListView.builder(
//         scrollDirection: Axis.vertical,
//         shrinkWrap: true,
//         itemCount:getListRequests.length,
//         itemBuilder: (BuildContext context, int index) {
//           String statusTittle =
//           getListRequests[index].typeTittle.toString();
// //widget.getListRequest?.sort((a,b)=>b.?.compareTo(a.statusInt as int)as int);
//           return Slidable(
//               key: const ValueKey(0),
//
//               endActionPane: ActionPane(
//                 extentRatio: 0.2,
//                 motion: const ScrollMotion(),
//                 children: [
//                   // A SlidableAction can have an icon and/or a label.
//                   ButtonStatusCancel(
//                     status: "لغو",
//                     requestId:getListRequests[index].id as int,
//                     onchangedCallback: (bool) { if(bool){
//                       setState(() {
//                         searchRequests('');
//                       });
//
//                     }},
//                   ),
//                   Container(
//                     height: 150,
//                     width: 45,
//                     decoration: BoxDecoration(
//                       color: Palette.primaryColorD,
//                     ),
//                     child: Icon(Icons.description_rounded,size: 20,color: Colors.white,),
//                   )
//                 ],
//               ),
//            child: Padding(
//             padding: const EdgeInsets.only(top: 1),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     getListRequests[index].statusId == 1 &&
//                         statusTittle.contains("Request")
//                         ?
//                       ButtonStatusWaiting("در انتظار تایید")
//                         :getListRequests[index].statusId == 4 &&
//                         statusTittle.contains("Request")
//                         ?
//                       ButtonStatusConfirm("تایید شده")
//                         :getListRequests[index].statusId ==
//                         5 &&
//                         statusTittle.contains("Request")
//                         ? ButtonStatusWaiting("رد شده")
//                         : getListRequests[index]
//                         .statusId ==
//                         1 &&
//                         statusTittle.contains("Invite")
//                         ? ButtonStatusReceived(
//                       status: 'قبول درخواست',
//                       userId:getListRequests[index]
//                           .id as int,
//                       expertId: getListRequests[index]
//                           .roleId as int,
//                     )
//                         : getListRequests[index]
//                         .statusId ==
//                         4 &&
//                         statusTittle
//                             .contains("Invite")
//                         ?
//                       ButtonStatusConfirm(
//                           "تایید شده")
//                         : ButtonStatusWaiting(
//                         " درحال بررسی"),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             Row(
//                               children:[
//                                 getListRequests[index].roleId==2?
//                                 Icon(Icons.star,color: Colors.blue,size: 15,):
//                                 getListRequests[index].roleId==3?
//                                 Icon(Icons.check_circle,color: Colors.green,size: 15,):
//                                 SizedBox(),
//                                 SizedBox(width: 5,),
//                                 Text(
//                                 (getListRequests[index]
//                                     .dstUserFullname ==
//                                     null)
//                                     ? getListRequests[index]
//                                     .srcUserFullname
//                                     .toString()
//                                     : getListRequests[index]
//                                     .dstUserFullname
//                                     .toString(),
//                                 style: TextStyle(
//                                     color: Colors.black,
//                                     fontWeight: FontWeight.bold,
//                                     fontFamily: 'sans',
//                                     fontSize: 14),
//                               )],
//                             ),
//                             Container(
//                               width: 150,
//                               child: Text(
//                                 getListRequests[index].description
//                                     .toString(),
//                                 textAlign: TextAlign.end,
//                                 style: TextStyle(
//                                   color: Palette.gradient2,
//                                   fontFamily: 'sans',
//                                   fontSize: 12,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         CircleAvatar(
//                           radius:25.0,
//                           backgroundImage: AssetImage(
// //  widget.getListRequest![index].profile
//                             "images/profile.png",
//                           ),
//                           backgroundColor: Colors.transparent,
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 Divider(
//                   indent: 20,
//                   endIndent: 20,
//                 )
//               ],
//             ),
//           ));
//         });
//   }
}
