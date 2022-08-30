
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../getxController/requests/request_list.dart';
import '../../../getxController/storagedata/StrorageAllData.dart';
import '../../../materialcolors/materialcolors.dart';
import '../../../response/request/response_list_submited.dart';
import '../../../widgets/shimmer_load.dart';
import '../../../widgets/widget_errorpage.dart';
import 'buttom_requests.dart';

class ListViewAllMain extends StatelessWidget {
 final List<DataListSubmitted>? getListRequestReceived;
 final List<DataListSubmitted>? getListSubmitted;
   ListViewAllMain({Key? key,required this.getListRequestReceived,required this.getListSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
     [
       ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,

          itemCount:getListRequestReceived!.length,

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
                      requestId: getListRequestReceived![index].id as int,
                      onchangedCallback: (bool) {if(bool){

                      }},
                      reqSrcUserId: getListRequestReceived![index].srcUserId, reqDstUserId: getListRequestReceived![index].dstUserId, cancellerUserId:Get.find<ControllerGetStorageAllData>().userId,

                    ),
                  ],
                ),child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      getListRequestReceived![index].statusId==1?
                      ButtonStatusReceived(
                        status: 'قبول درخواست',
                        userId: getListRequestReceived![index].id as int,
                        expertId: getListRequestReceived![index].roleId as int,
                      ):
                      getListRequestReceived![index].statusId==4?
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
                                (getListRequestReceived![index].srcUserFullname==null)? "نا مشخص":getListRequestReceived![index].srcUserFullname as String,


                                style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontFamily: 'sans', fontSize:14),
                              ),
                              Container(
                                width: 150,
                                child: Text(
                                  getListRequestReceived![index].description.toString(),
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
       ListView.builder(
           scrollDirection: Axis.vertical,
           shrinkWrap: true,
           itemCount:  getListSubmitted!.length,
           itemBuilder: (BuildContext context, int index) {
             // getListSubmitted?.sort((a,b)=>b.statusInt?.compareTo(a.statusInt as int)as int);
             return Slidable(
                 key: const ValueKey(0),

                 endActionPane: ActionPane(
                   extentRatio: 0.2,
                   motion: const ScrollMotion(),
                   children: [
                     // A SlidableAction can have an icon and/or a label.
                     ButtonStatusCancel(
                       status: "لغو",
                       requestId: getListSubmitted![index].id as int,
                       onchangedCallback: (bool) {if(bool){
                       }},
                       reqSrcUserId: getListSubmitted![index].srcUserId, reqDstUserId: getListSubmitted![index].dstUserId, cancellerUserId:Get.find<ControllerGetStorageAllData>().userId,

                     ),
                   ],
                 ),child: Padding(
               padding: const EdgeInsets.only(top: 10),
               child: Column(
                 children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       getListSubmitted![index].statusId==1?
                       ButtonStatusWaiting(
                           "در انتظار تایید")
                           :
                       getListSubmitted![index].statusId==4?
                       ButtonStatusConfirm(
                           "تایید شده")
                           :
                       getListSubmitted![index].statusId==5?
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
                                 getListSubmitted![index].dstUserFullname.toString(),


                                 style:TextStyle(color:Colors.black,fontWeight: FontWeight.bold, fontFamily: 'sans', fontSize:14),
                               ),
                               Container(
                                 width: 150,
                                 child: Text(
                                   getListSubmitted![index].description.toString(),
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
           }),],
    );
  }
}
class ListViewLimitedMain extends StatelessWidget {

  ListViewLimitedMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetListRequest _getListRequest = Get.find<GetListRequest>();
    List<DataListSubmitted>? getListRequestReceived= Get.find<GetListRequest>().getListRequest!;
    List<DataListSubmitted>? getListSubmitted= Get.find<GetListRequest>().getListInvite!;

  return  Obx(()
    {
     return _getListRequest.isLoading.value == false ? Column(
        children:
        [
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount:getListRequestReceived == null
                  ? 0
                  : (getListRequestReceived.length > 2
                  ? 2
                  : getListRequestReceived.length),

              itemBuilder: (BuildContext context, int index) {

                return Slidable(
                    key: const ValueKey(0),

                    endActionPane: ActionPane(
                      extentRatio: 0.2,
                      motion: const ScrollMotion(),
                      children: [
                        // SlidableAction(
                        //   flex: 1,
                        //   onPressed:(context) {
                        //     doNothing(context,getListRequestReceived[index].id as int,);
                        //   },
                        //   backgroundColor: Color(0xFFFE4A49),
                        //   foregroundColor: Colors.white,
                        //   icon: Icons.filter_alt,
                        //   label: 'Delete',
                        // ),
                        // A SlidableAction can have an icon and/or a label.
                        ButtonStatusCancel(
                          status: "لغو",
                          requestId: getListRequestReceived[index].id as int,
                          onchangedCallback: (bool) {if(bool){

                          }},
                          reqSrcUserId: getListRequestReceived[index].srcUserId, reqDstUserId: getListRequestReceived[index].dstUserId, cancellerUserId:Get.find<ControllerGetStorageAllData>().userId,

                        ),
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
                                      getListRequestReceived[index].userJobTittle==null?"پشتیبانی" :getListRequestReceived[index].userJobTittle.toString(),
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
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: getListSubmitted == null
                  ? 0
                  : (getListSubmitted.length > 2
                  ? 2
                  : getListSubmitted.length),
              reverse: true,
              itemBuilder: (BuildContext context, int index) {

                // getListSubmitted?.sort((a,b)=>b.statusInt?.compareTo(a.statusInt as int)as int);
                return Slidable(
                    key: const ValueKey(0),

                    endActionPane: ActionPane(


                      motion: const ScrollMotion(),
                      extentRatio:0.2,

                      children: [

                        // SlidableAction(
                        //   flex: 1,
                        //   onPressed:(context) {
                        //     doNothing(context,getListRequestReceived[index].id as int,);
                        //   },
                        //   backgroundColor: Color(0xFFFE4A49),
                        //   foregroundColor: Colors.white,
                        //   icon: Icons.delete_forever,
                        // ),
                        // A SlidableAction can have an icon and/or a label.
                        ButtonStatusCancel(
                          status: "لغو",
                          requestId: getListSubmitted[index].id as int,
                          onchangedCallback: (bool) {if(bool){
                          }},
                          reqSrcUserId: getListSubmitted[index].srcUserId, reqDstUserId: getListSubmitted[index].dstUserId, cancellerUserId:Get.find<ControllerGetStorageAllData>().userId,
                        ),
                      ],
                    ),
                    child: Padding(
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
        ],
      ):_getListRequest.errorPage.value == false
         ? CustomShimmerWidgetRequest()
         : ErrorPage();},
    );

  }
  // Future<bool> doNothing(BuildContext context,int requestId) async{
  //   return await StatusDelete().DeleteRequest(context, requestId);
  // }
}