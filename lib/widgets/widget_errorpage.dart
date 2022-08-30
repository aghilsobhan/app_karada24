import 'package:app_karada24/getxController/requests/request_list.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../getxController/list_ticket.dart';
import '../getxController/storagedata/StrorageAllData.dart';
class ErrorPage extends StatefulWidget {
  ErrorPage({Key? key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  String? token=Get.find<ControllerGetStorageAllData>().token;
  @override

  Widget build(BuildContext context) {
    return Container(
      color: Palette.backGroundColorD,
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Image.asset("images/notconnection.png",
                  height: 250,
                  width: 300,),
                SizedBox(height: 20,),
                Text("مشکل در برقراری ارتباط",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
                ElevatedButton(
                  onPressed: () {
                    Get.find<GetListTicketing>().errorPage.value=false;
                    Get.find<GetListTicketing>().errorPage.value=false;
                    Get.find<GetListTicketing>().fetchListTicketing(Get.find<ControllerGetStorageAllData>().userRolId!, token!);
                    Get.find<GetListRequest>().errorPage.value=false;
                    Get.find<GetListRequest>().errorPage.value=false;
                    Get.find<GetListRequest>().fetchListRequest(Get.find<ControllerGetStorageAllData>().userId!,token!);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Palette.primaryColorD,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ), child:  const Text(
                  'تلاش دوباره',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                )
              ])),
    );
  }
}
