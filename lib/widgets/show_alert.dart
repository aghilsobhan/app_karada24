

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../apiService/request/api_delete_requests.dart';
import '../getxController/requests/request_list.dart';
import '../getxController/storagedata/StrorageAllData.dart';
import '../materialcolors/materialcolors.dart';
AlertShow(BuildContext context,String str)async{
  showDialog(context: context,
    builder: (context)=>AlertDialog(
      content: Directionality(textDirection:TextDirection.rtl,child: Text(str,style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),)),
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
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
              },
              child:  Text("بله",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(primary: Palette.primaryColorD),),

          ],
        ),
      ],
    ),
  );
}
AlertShowDelete(BuildContext context,String str,int requestId)async{
  showDialog(context: context,
    builder: (context)=>AlertDialog(
      content: Directionality(textDirection:TextDirection.rtl,child: Text(str,style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),)),
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
                //DeleteRequest(context, requestId);
              },
              child:  Text("بله",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(primary: Palette.primaryColorD),),

          ],
        ),
      ],
    ),
  );
}
// void DeleteRequest(BuildContext context,int requestId)async{
//   ApiServiceDeleteRequest apiServiceDeleteRequest=ApiServiceDeleteRequest();
//   await apiServiceDeleteRequest.sendRequest(Get.find<ControllerGetStorageAllData>().token,requestId).then((value) {
//     print(value);
//     try{
//       if(value.isSuccess==true){
//         Get.find<GetListRequest>().fetchListRequest(userId!,token!);
//         Navigator.of(context).pop(false);
//         // setState(() {
//         //   statusRequest=false;
//         //
//         //   //widget.send!("isDelete");
//         // });
//
//       }else{
//         // setState(() {
//         //   statusRequest=false;
//         //   // widget.send!("error");
//         //   SnackError(context, "مشکل در برقراری ارتباط");
//         // });
//
//       }
//     }catch(e){
//       // setState(() {
//       //   statusRequest=false;
//       //   // widget.send!("error");
//       // });
//
//
//     }
//
//   }).catchError((er){
//     // setState(() {
//     //   statusRequest=false;
//     //   //  widget.send!("error");
//     // });
//
//   });
// }