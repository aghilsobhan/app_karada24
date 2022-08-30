
import 'package:app_karada24/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'getxController/binding/network_binding.dart';
void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  //await notificationApi.init();
  // Allow access for https in all api

  HttpOverrides.global = MyHttpOverrides();
  return runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          //color set to transperent or set your own color
          statusBarIconBrightness: Brightness.dark,
          //set brightness for icons, like dark background light icons
        )
    );
    return  GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
