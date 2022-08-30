import 'package:app_karada24/apiService/request/api_delete_requests.dart';
import 'package:app_karada24/apiService/request/api_service_sendRequest.dart';
import 'package:app_karada24/models/requests/model_delete_request.dart';
import 'package:app_karada24/models/requests/model_sendrequest.dart';
import 'package:app_karada24/utility/snackbar_error.dart';
import 'package:app_karada24/widgets/show_alert.dart';
import 'package:app_karada24/widgets/widget_errorpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../apiService/request/api_service_received_request.dart';
import '../../../getxController/requests/request_list.dart';
import '../../../getxController/storagedata/StrorageAllData.dart';
import '../../../materialcolors/materialcolors.dart';
import '../../../value/style_more.dart';

class ButtonStatusAdd extends StatefulWidget {
  final String status;
  final int userId;
  final Function(bool) onchangedCallback;
  const ButtonStatusAdd(
      {Key? key,
      required this.status,
      required this.userId, required this.onchangedCallback,})
      : super(key: key);

  @override
  _ButtonStatusAddState createState() => _ButtonStatusAddState();
}

class _ButtonStatusAddState extends State<ButtonStatusAdd> {
  bool statusRequest = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      
          SendRequest();
      
      },
      child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Container(
            width: 120,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Palette.primaryColorD,
              border: Border.all(
                color: Color.fromRGBO(255, 255, 255, 1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 12)
              ],
            ),
            child: statusRequest == true
                ? Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                      height: 15.0,
                      width: 15.0,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.person_add_alt_1_sharp,
                            size: 16,
                            color: Colors.white,
                          )),
                      Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text(
                            widget.status.toString().trim(),
                            style: StylesMore.styleText,
                          )),
                    ],
                  ),
          )),
    );
  }

  void SendRequest() async {
    ModelSendRequests modelSendRequests = ModelSendRequests(
        description: "توضیحات",
        typeId: Get.find<ControllerGetStorageAllData>().IsRolId==4?1:2,
        srcUserId: Get.find<ControllerGetStorageAllData>().userId,
        dstUserId: widget.userId);
    print(modelSendRequests.toJson());
    setState(() {
      statusRequest = true;
    });
    ApiServiceSendRequest apiServiceSendRequest = ApiServiceSendRequest();
    await apiServiceSendRequest
        .sendRequest(
            Get.find<ControllerGetStorageAllData>().token, modelSendRequests)
        .then((value) {
      print(value);
      try {
        if (value.isSuccess == true) {
          setState(() {
            statusRequest = false;
             widget.onchangedCallback(true);
            Get.find<GetListRequest>().fetchListRequest(Get.find<ControllerGetStorageAllData>().userId!,Get.find<ControllerGetStorageAllData>().token!);
          });
        }
      } catch (e) {
        setState(() {});
        statusRequest = false;

      }
    }).catchError((er) {
      setState(() {});
      statusRequest = false;

    });
  }
}
class ButtonStatusReceived extends StatefulWidget {
  final String status;
  final int userId;
  final int expertId;
  const ButtonStatusReceived(
      {Key? key,
      required this.status,
      required this.userId,
      required this.expertId})
      : super(key: key);

  @override
  _ButtonStatusReceivedState createState() => _ButtonStatusReceivedState();
}

class _ButtonStatusReceivedState extends State<ButtonStatusReceived> {
  bool statusRequest = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ReceivedRequest();
          statusRequest = true;
        });
      },
      child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Container(
            width: 120,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.blue,
              border: Border.all(
                color: Color.fromRGBO(255, 255, 255, 1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 12)
              ],
            ),
            child: statusRequest == true
                ? Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                      height: 15.0,
                      width: 15.0,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.person_add_alt_1_sharp,
                            size: 14,
                            color: Colors.white,
                          )),
                      Padding(
                          padding: EdgeInsets.only(right: 6),
                          child: Text(
                            widget.status.toString().trim(),
                            style: StylesMore.styleText,
                          )),
                    ],
                  ),
          )),
    );
  }

  void ReceivedRequest() async {
    ModelReceivedRequests modelReceivedRequests = ModelReceivedRequests(
        userId: Get.find<ControllerGetStorageAllData>().userId,
        requestId: widget.userId);
    print(modelReceivedRequests.toJson());
    ApiServiceReceivedRequest apiServiceSendRequest = ApiServiceReceivedRequest();
    await apiServiceSendRequest
        .sendRequest(Get.find<ControllerGetStorageAllData>().token,
            modelReceivedRequests)
        .then((value) {
      try {
        if (value.isSuccess == true) {
          setState(() {
            Get.find<GetListRequest>().fetchListRequest(Get.find<ControllerGetStorageAllData>().userId!,Get.find<ControllerGetStorageAllData>().token!);
            statusRequest = false;
            if(widget.expertId==2){
              Get.find<ControllerGetStorageAllData>().saveIsRolId(3);
              Get.find<ControllerGetStorageAllData>().readIsRolId();
            }

          });
        } else if(value.isSuccess==false){
          setState(() {
            statusRequest = false;
            if(value.errors!=null){
              SnackError(context, value.errors![0]);
            }else{
              SnackError(context, "مشکل در برقراری ارتباط");
            }

          });
        }
      } catch (e) {
        setState(() {
          statusRequest = false;
        });
      }
    }).catchError((er) {
      setState(() {
        statusRequest = false;
      });
    });
  }
}

class ButtonStatusCancel extends StatefulWidget {
  final String status;
  final int? requestId;
  final int? reqSrcUserId;
  final int? reqDstUserId;
  final int? cancellerUserId;
  final Function(bool) onchangedCallback;
  const ButtonStatusCancel(
      {Key? key, required this.status, required this.requestId, required this.onchangedCallback, required this.reqSrcUserId, required this.reqDstUserId, required this.cancellerUserId})
      : super(key: key);

  @override
  _ButtonStatusCancelState createState() => _ButtonStatusCancelState();
}

class _ButtonStatusCancelState extends State<ButtonStatusCancel> {
  bool statusRequest = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          CancellRequest();
        });
      },
      child: Container(
        width:40,
        height: 45,
        color: Colors.red,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.all(Radius.circular(5)),
        //   color: Palette.secondColorLight,
        //   border: Border.all(
        //     color: Color.fromRGBO(255, 255, 255, 1),
        //     width: 1,
        //   ),
        //   boxShadow: [
        //     BoxShadow(
        //         color: Color.fromRGBO(0, 0, 0, 0.25),
        //         offset: Offset(0, 4),
        //         blurRadius: 12)
        //   ],
        // ),
        child: statusRequest == true
            ? Center(
                child: SizedBox(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                  height: 15.0,
                  width: 15.0,
                ),
              )
            : Icon(
          Icons.delete_forever,
          size: 20,
          color: Colors.white,
        ),
        // Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Padding(
        //               padding: EdgeInsets.only(left: 6),
        //               child: Icon(
        //                 Icons.close,
        //                 size: 14,
        //                 color: Colors.white,
        //               )),
        //           // Padding(
        //           //     padding: EdgeInsets.only(right: 6),
        //           //     child: Text(
        //           //       widget.status.toString().trim(),
        //           //       style: StylesMore.styleText,
        //           //     )),
        //         ],
        //       ),
      ),
    );
  }

  void CancellRequest() async {
    showDialog(context: context,
        builder: (context)=>AlertDialog(
      content: Directionality(textDirection:TextDirection.rtl,child: Text("آیا از حذف درخواست مطمئن هستید؟",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),)),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed:() {
              Navigator.of(context).pop(false);
            }, child:  Text("خیر",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(primary: Palette.primaryColorD)),
            ElevatedButton(
              onPressed: () {
                DeleteRequest(context,widget.requestId);
              },
              child:  Text("بله",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(primary: Palette.primaryColorD),),

          ],
        ),
      ],
        ));
  }
  void DeleteRequest(BuildContext context,int? requestId)async{
    ModelDeleteRequest modelDeleteRequest=ModelDeleteRequest(
      requestId: requestId,
      reqSrcUserId:widget.reqSrcUserId ,
      reqDstUserId: widget.reqDstUserId,
      cancellerUserId:widget.cancellerUserId ,
    );
    ApiServiceDeleteRequest apiServiceDeleteRequest=ApiServiceDeleteRequest();
    await apiServiceDeleteRequest.sendRequest(Get.find<ControllerGetStorageAllData>().token,modelDeleteRequest).then((value) {
      print(value);
      try{
        if(value.isSuccess==true){
          if(value.data!=null){
            if(value.data==4){
              Get.find<ControllerGetStorageAllData>().saveIsRolId(4);
              Get.find<ControllerGetStorageAllData>().readIsRolId();
              Alert(
                id: "2",
                context: context,
                desc:"حساب کاربری شما به کاربر عادی تغییر یافت در صورت درخواست کارشناسان به کاربر پاسخگو تبدیل میشوید",
                buttons: [
                  DialogButton(
                    child: const Text(
                      'تایید',
                      style: TextStyle(
                          fontSize: 12, fontFamily: 'sans', color: Colors.white),
                    ),
                    onPressed: () {
                      Alert(context: context).dismiss();
                      Navigator.of(context).pop(false);
                    },
                    color: Palette.activeColor,
                  )
                ],
                style: const AlertStyle(
                  isCloseButton: false,
                  descStyle: TextStyle(fontFamily: 'sans', fontSize: 12),
                ),
                image: Image.asset(
                  "images/warning.png",
                  width: 45,
                  height: 45,
                ),
              ).show();
            }

          }else{
            Navigator.of(context).pop(false);
          }
          Get.find<GetListRequest>().fetchListRequest(Get.find<ControllerGetStorageAllData>().userId!,Get.find<ControllerGetStorageAllData>().token!);

          widget.onchangedCallback(true);
        }else{
          widget.onchangedCallback(false);


        }
      }catch(e){
        widget.onchangedCallback(false);



      }

    }).catchError((er){
      widget.onchangedCallback(false);

    });
  }
}
// class StatusDelete{
//
//
//   Future<bool> DeleteRequest(BuildContext context,int requestId) async {
//     bool hasDelete=false;
//     showDialog(context: context,
//         builder: (context)=>AlertDialog(
//           content: Directionality(textDirection:TextDirection.rtl,child: Text("آیا از حذف درخواست مطمئن هستید؟",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),)),
//           actions: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ElevatedButton(onPressed:() {
//                   hasDelete=false;
//                   Navigator.of(context).pop(false);
//
//                 }, child:  Text("خیر",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
//                     style: ElevatedButton.styleFrom(primary: Palette.primaryColorD)),
//                 ElevatedButton(
//                   onPressed: () {
//                     DeleteRequests(context, requestId).then((value) {
//                       hasDelete=value;
//                     });
//                   },
//                   child:  Text("بله",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
//                   style: ElevatedButton.styleFrom(primary: Palette.primaryColorD),),
//
//               ],
//             ),
//           ],
//         ));
//     return hasDelete;
//   }
//   Future<bool> DeleteRequests(context,int requestId)async{
//     bool hasDelete=false;
//     ApiServiceDeleteRequest apiServiceDeleteRequest=ApiServiceDeleteRequest();
//     await apiServiceDeleteRequest.sendRequest(Get.find<ControllerGetStorageAllData>().token,requestId).then((value) {
//       print(value);
//       try{
//         if(value.isSuccess==true){
//           Get.find<GetListRequest>().fetchListRequest(Get.find<ControllerGetStorageAllData>().userId!,Get.find<ControllerGetStorageAllData>().token!);
//           Navigator.of(context).pop(false);
//          hasDelete=true;
//         }else{
//          // widget.onchangedCallback(false);
//           hasDelete=false;
//
//         }
//       }catch(e){
//        // widget.onchangedCallback(false);
//
//         hasDelete=false;
//
//       }
//
//     }).catchError((er){
//       //widget.onchangedCallback(false);
//       hasDelete=false;
//     });
//     return hasDelete;
//   }
// }

Widget ButtonStatusWaiting(String status) {
  return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Container(
        width: 120,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white70,
          border: Border.all(
            color: Color.fromRGBO(255, 255, 255, 1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
                blurRadius: 12)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.update,
                  size: 18,
                  color: Palette.bottomNavSelected,
                )),
            Padding(
                padding: EdgeInsets.only(right: 6),
                child: Text(
                  status.toString().trim(),
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'sans', fontSize: 12),
                )),
          ],
        ),
      ));
}

Widget ButtonStatusConfirm(String status) {
  return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Container(
        width: 120,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white70,
          border: Border.all(
            color: Color.fromRGBO(255, 255, 255, 1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                offset: Offset(0, 4),
                blurRadius: 12)
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(left: 6),
                child: Icon(
                  Icons.check_circle,
                  size: 18,
                  color: Palette.iconSnack,
                )),
            Padding(
                padding: EdgeInsets.only(right: 6),
                child: Text(
                  status.toString().trim(),
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'sans', fontSize: 12),
                )),
          ],
        ),
      ));
}
