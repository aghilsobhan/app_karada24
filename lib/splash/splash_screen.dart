import 'package:flutter/material.dart';
import 'package:app_karada24/Dashboard/menu_dashboard.dart';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/screen/login/login_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigationPage();
  }

  @override
  Widget build(BuildContext context) {
final obx=GetStorage();
    return Scaffold(
      backgroundColor:Colors.white,
        body: Center(
          child: Image.asset(
            "images/loading.gif",
            height: 350.0,
            width: 350.0,
          ),
        ),
      );
  }
// check login is true or false  and The corresponding page opens
  _navigationPage() async {
    try{
      await Get.find<ControllerGetStorageAllData>().readTokens();
      await Get.find<ControllerGetStorageAllData>().readProfile();
      await Get.find<ControllerGetStorageAllData>().readIsRolId();
       String? token=Get.find<ControllerGetStorageAllData>().token;
      int? userRolId=Get.find<ControllerGetStorageAllData>().userRolId;
      await Future.delayed(const Duration(seconds:11), () {});
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (BuildContext context) {
          if (token != null && userRolId!=null) {
             return  MenuDashboardT();
          } else {
            return  LoginPage();
          }
        },
      ));
    }catch(e){
      print(e.toString());
    }

  }
}
