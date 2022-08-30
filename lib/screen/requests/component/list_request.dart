import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/response/request/response_list_request.dart';
import 'package:app_karada24/response/request/response_list_submited.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import '../../../getxController/requests/request_list.dart';
import '../../../getxController/storagedata/StrorageAllData.dart';
import 'buttom_requests.dart';

String? token = Get.find<ControllerGetStorageAllData>().token;
int? userId = Get.find<ControllerGetStorageAllData>().userId;

class ListViewRequest extends StatefulWidget {
  final List<DataListRequest>? getListRequest;
  ListViewRequest({Key? key, required this.getListRequest}) : super(key: key);

  @override
  _ListViewRequestState createState() => _ListViewRequestState();
}

class _ListViewRequestState extends State<ListViewRequest> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.getListRequest!.length,
        itemBuilder: (BuildContext context, int index) {
          //widget.getListRequest?.sort((a,b)=>b.?.compareTo(a.statusInt as int)as int);
          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // widget.getListRequest![index].statusInt==2?
                    // Row(
                    //     children:[
                    //       ButtonStatusWaiting(
                    //   widget.getListRequest![index].status.toString()),
                    //   ButtonStatusCancel(
                    //     status: "لغو",
                    //   )
                    // ]):
                    // widget.getListRequest![index].statusInt==3?
                    // Row(
                    //     children:[
                    //       ButtonStatusConfirm(
                    //           widget.getListRequest![index].status.toString()),
                    //       ButtonStatusCancel(
                    //         status: "لغو",
                    //       )
                    //     ]):
                    // widget.getListRequest![index].statusInt==1?ButtonStatusAdd(
                    //    status:widget.getListRequest![index].status.toString(),
                    // ):
                    widget.getListRequest![index].isSend == true
                        ? Row(children: [
                            ButtonStatusWaiting("در انتظار تایید"),
                            // ButtonStatusCancel(
                            //   status: "لغو",
                            //   requestId:
                            //       widget.getListRequest![index].userId as int,
                            //   onchangedCallback: (bool) {},
                            //   reqSrcUserId:widget.getListRequest![index].userId , reqDstUserId: widget.getListRequest![index].d, cancellerUserId:Get.find<ControllerGetStorageAllData>().userId,
                            // )
                          ])
                        : ButtonStatusAdd(
                            status: "ارسال درخواست",
                            userId: widget.getListRequest![index].userId as int,
                            onchangedCallback: (bool) {},
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              widget.getListRequest![index].fullname.toString(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'sans',
                                  fontSize: 14),
                            ),
                            Container(
                              width: 150,
                              child: Text(
                                widget.getListRequest![index].organName
                                    .toString(),
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

class ListViewSubmit extends StatefulWidget {
  final List<DataListSubmitted>? getListSubmitted;
  ListViewSubmit({Key? key, required this.getListSubmitted}) : super(key: key);

  @override
  _ListViewSubmitState createState() => _ListViewSubmitState();
}

class _ListViewSubmitState extends State<ListViewSubmit> {
  @override
  Widget build(BuildContext context) {
    if (widget.getListSubmitted!.isEmpty) {
      return Center(
        child: Text(
          'درخواستی وجود ندارد وجود ندارد ',
          style: TextStyle(
            fontFamily: "sans",
            fontSize: 12,
          ),
        ),
      );
    } else {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: widget.getListSubmitted == null
              ? 0
              : (widget.getListSubmitted!.length > 4
                  ? 4
                  : widget.getListSubmitted!.length),
          itemBuilder: (BuildContext context, int index) {
            String statusTittle =widget.getListSubmitted![index].typeTittle.toString();
            return Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  extentRatio: 0.2,
                  motion: const ScrollMotion(),
                  children: [
                    // A SlidableAction can have an icon and/or a label.
                    ButtonStatusCancel(
                      status: "لغو",
                      requestId: widget.getListSubmitted![index].id as int,
                      onchangedCallback: (bool) {},
                      reqSrcUserId: widget.getListSubmitted![index].srcUserId, reqDstUserId: widget.getListSubmitted![index].dstUserId, cancellerUserId:Get.find<ControllerGetStorageAllData>().userId,
                    ),
                    Container(
                      height: 150,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Palette.primaryColorD,
                      ),
                      child: Icon(
                        Icons.description_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 1),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          widget.getListSubmitted![index].statusId == 1 &&
                                  statusTittle.contains("Request")
                              ? ButtonStatusWaiting("در انتظار تایید")
                              : widget.getListSubmitted![index].statusId == 4 &&
                                      statusTittle.contains("Request")
                                  ? ButtonStatusConfirm("تایید شده")
                                  : widget.getListSubmitted![index].statusId ==
                                              5 &&
                                          statusTittle.contains("Request")
                                      ? ButtonStatusWaiting("رد شده")
                                      : widget.getListSubmitted![index]
                                                      .statusId ==
                                                  1 &&
                                              statusTittle.contains("Invite")
                                          ? ButtonStatusReceived(
                                              status: 'قبول درخواست',
                                              userId: widget
                                                  .getListSubmitted![index]
                                                  .id as int,
                                              expertId: widget
                                                  .getListSubmitted![index]
                                                  .roleId as int,
                                            )
                                          : widget.getListSubmitted![index]
                                                          .statusId ==
                                                      4 &&
                                                  statusTittle
                                                      .contains("Invite")
                                              ? ButtonStatusConfirm("تایید شده")
                                              : ButtonStatusWaiting(
                                                  " درحال بررسی"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    children: [
                                      widget.getListSubmitted![index].roleId ==
                                              2
                                          ? Icon(
                                              Icons.star,
                                              color: Colors.blue,
                                              size: 15,
                                            )
                                          : widget.getListSubmitted![index]
                                                      .roleId ==
                                                  3
                                              ? Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                  size: 15,
                                                )
                                              : SizedBox(),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        (widget.getListSubmitted![index]
                                                    .dstUserFullname ==
                                                null)
                                            ? widget.getListSubmitted![index]
                                                .srcUserFullname
                                                .toString()
                                            : widget.getListSubmitted![index]
                                                .dstUserFullname
                                                .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'sans',
                                            fontSize: 14),
                                      )
                                    ],
                                  ),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      widget
                                          .getListSubmitted![index].description
                                          .toString(),
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
                ));
          });
    }
  }
}
