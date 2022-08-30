
import 'package:app_karada24/screen/chat_page/database/message_database.dart';
import 'package:app_karada24/screen/chat_page/model/model_received_chat.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/descriptionproduct/description_product.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/screen/login/login_page.dart';
import 'package:app_karada24/screen/mainpage/profile.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
class DrawerWidget extends StatefulWidget {
   DrawerWidget({Key? key}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  final String _url = 'https://phx.ir/';
  String? tokenLogin=Get.find<ControllerGetStorageAllData>().token;
  String? fullName=Get.find<ControllerGetStorageAllData>().fullName??"نام و نام خانوادگی";
  String? email=Get.find<ControllerGetStorageAllData>().email??"ایمیل";
  String? mobil=Get.find<ControllerGetStorageAllData>().phoneNumber??"موبایل";
  late SharedPreferences sharedPreferences;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late bool isTouchingS=false,isTouchingP=false,isTouchingGh=false,isTouchingsAb=false,isTouchingQ=false,isTouchingE = false;
  @override
  Widget build(BuildContext context) {
    return  Directionality(
      key: _scaffoldKey,
     textDirection: TextDirection.rtl,
      child: Drawer(
backgroundColor: Palette.backGroundColorD,
        child: ListView(
          children: [
            drawerHeader(),
            const SizedBox(height: 20,),

            Listener(
              onPointerDown: (event) => setState(() {
                isTouchingP = true;
              }),
              onPointerUp: (event) => setState(() {
                isTouchingP = false;
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return Profile();
                      });
                    });
              }),
              child: Container(
                  height:45,color: isTouchingP==false?Palette.backGroundColorD:Colors.grey[300], child:  _createDrawerItemProfile(icon:  Icons.person,text: "پروفایل" )),
            ),
             const Divider(),
            Listener(
              onPointerDown: (event) => setState(() {
                isTouchingsAb = true;
              }),
              onPointerUp: (event) => setState(() {
                isTouchingsAb = false;
                _launchURL();
              }),
              child: Container(
                  height:45,color: isTouchingsAb==false?
              Palette.backGroundColorD:Colors.grey[300],
                child: _createDrawerItemAbout(icon: "images/karadatext.png",
                    text: "درباره ققنوس" ),),
            ),
            const Divider(),

            Listener(
              onPointerDown: (event) => setState(() {
                isTouchingQ = true;
              }),
              onPointerUp: (event) => setState(() {
                isTouchingQ = false;
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(builder: (context, setState) {
                        return DescriptionProduct();
                      });
                    });
              }),
              child: Container(
                  height:45,color: isTouchingQ==false?Palette.backGroundColorD:Colors.grey[300], child: _createDrawerItemFaq(icon:  Icons.question_answer,text: "سوالات متداول" )),
            ),

            const Divider(),
            Listener(

                onPointerDown: (event) => setState(() {
              isTouchingS = true;
            }),
                onPointerUp: (event) => setState(() {
                  isTouchingS = false;
                  showSnackBarAsBottomSheet(context);
                }),child: Container(height:45,color: isTouchingS==false?Palette.backGroundColorD:Colors.grey[300],child: _createDrawerItemSetting(icon:  Icons.settings,text: "تنظیمات" ))),
            const Divider(),

        Listener(
            onPointerDown: (event) => setState(() {
              isTouchingE = true;
            }),
            onPointerUp: (event) => setState(() {
              isTouchingE = false;
              exitAppToLogin();
            }),
          child: Container(
              height:45,color: isTouchingE==false?Palette.backGroundColorD:Colors.grey[300],
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Row(
                children: <Widget>[
                  Icon(Icons.exit_to_app,size: 18,),
                  Padding(
                    padding:const EdgeInsets.only(right: 8.0),
                    child: Text("خروج از حساب کاربری",style:const TextStyle(color:Colors.black, fontFamily: 'sans', fontSize:12),),
                  )
                ],
              ),
            ),
          ),
        ),
          ],
        ),
      ),
    );
  }
  exitAppToLogin()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    showDialog(context: context,
      builder: (context)=>AlertDialog(
        content: Directionality(textDirection:TextDirection.rtl,child: Text("آیا میخواهید از برنامه خارج شوید؟",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),)),
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
                  GetStorage().erase();
                  MessageDataBase.instance.delete();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                             LoginPage()),  (Route<dynamic> route) => false,);
                },
                child:  Text("بله",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
                style: ElevatedButton.styleFrom(primary: Palette.primaryColorD),),

            ],
          ),
        ],
      ),
    );
  }
  Widget drawerHeader(){
    DateTime now =  DateTime.now();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DrawerHeader(
          decoration:const BoxDecoration(
                            gradient: LinearGradient(
                                begin:Alignment(
                                    0.8185951709747314, 0.45850691199302673),
                                end:  Alignment(
                                    -0.45850691199302673, 0.3032980263233185),
                                colors: [
                                  Palette.primaryColorGradientDark,
                                  Palette.primaryColorD
                                ]),
                          ),
          child:Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                 const CircleAvatar(
                    radius: 25.0,
                    backgroundImage: AssetImage(
                      'images/profile.png',
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                   Text(fullName!,style:TextStyle(color: Colors.white,fontFamily: "sans",fontSize: 12),),
                  const SizedBox(height: 7,),
                   Text(email!,style:TextStyle(color: Palette.gradient2,fontFamily: "sans",fontSize: 10),),
                  const SizedBox(height: 7,),
                  Text("امروز: "+now.toPersianDate(),style:const TextStyle(color: Palette.gradient2,fontFamily: "sans",fontSize: 10))
                ],
              )
           ],

          ),
      ),
    );
  }
  Widget _createDrawerItemProfile(
      {required IconData icon, required String text}) {


   return   GestureDetector(
     onTap: () => setState(() {

     }),
     child: Padding(
       padding: EdgeInsets.only(right: 8),
       child: Row(
            children: <Widget>[
              Icon(icon,size: 18,),
              Padding(
                padding:const EdgeInsets.only(right: 8.0),
                child: Text(text,style:const TextStyle(color:Colors.black, fontFamily: 'sans', fontSize:12),),
              )
            ],
          ),
     ),
   );

  }
  // Widget _createDrawerItemTerm(
  //     {required IconData icon, required String text}) {
  //
  //
  //   return   GestureDetector(
  //     onTap: () => setState(() {
  //
  //     }),
  //     child: Padding(
  //       padding: EdgeInsets.only(right: 8),
  //       child: Row(
  //         children: <Widget>[
  //           Icon(icon,size: 18,),
  //           Padding(
  //             padding:const EdgeInsets.only(right: 8.0),
  //             child: Text(text,style:const TextStyle(color:Colors.black, fontFamily: 'sans', fontSize:12),),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  //
  // }
  Widget _createDrawerItemFaq(
      {required IconData icon, required String text}) {
    return   GestureDetector(
      onTap: () => setState(() {
        // if (widget.tokenLogin==null || widget.tokenLogin=="")
        // {showSnackBarAsBottomSheet(context);}
        //else{
        print(tokenLogin);

       // }

      }),
      child: Padding(
        padding: EdgeInsets.only(right: 8),
        child: Row(
          children: <Widget>[
            Icon(icon,size: 18,),
            Padding(
              padding:const EdgeInsets.only(right: 8.0),
              child: Text(text,style:const TextStyle(color:Colors.black, fontFamily: 'sans', fontSize:12),),
            )
          ],
        ),
      ),
    );

  }
  // Widget _createDrawerItemHelp(
  //     {required IconData icon, required String text}) {
  //   return   GestureDetector(
  //     onTap: () => setState(() {
  //       showModalBottomSheet(
  //           backgroundColor: Colors.transparent,
  //           isScrollControlled: true,
  //           context: context,
  //           builder: (BuildContext context) {
  //             return StatefulBuilder(builder: (context, setState) {
  //               return Profile();
  //             });
  //           });
  //     }),
  //     child: Padding(
  //       padding: EdgeInsets.only(right: 8),
  //       child: Row(
  //         children: <Widget>[
  //           Icon(icon,size: 18,),
  //           Padding(
  //             padding:const EdgeInsets.only(right: 8.0),
  //             child: Text(text,style:const TextStyle(color:Colors.black, fontFamily: 'sans', fontSize:12),),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }
  Widget _createDrawerItemAbout(      {required String icon, required String text}) {
    return   GestureDetector(
      onTap: () => setState(() {

      }),
      child: Padding(
        padding: EdgeInsets.only(right: 8),
        child: Row(
          children: <Widget>[
            Image.asset(icon,height: 20,width: 24,color: Colors.black,),
            Padding(
              padding:const EdgeInsets.only(right: 8.0),
              child: Text(text,style:const TextStyle(color:Colors.black, fontFamily: 'sans', fontSize:12),),
            )
          ],
        ),
      ),
    );
  }
  Widget _createDrawerItemSetting({required IconData icon, required String text}) {


    return   Padding(
      padding: EdgeInsets.only(right: 8),
      child: Row(
        children: <Widget>[
          Icon(icon,size: 18,),
          Padding(
            padding:const EdgeInsets.only(right: 8.0),
            child: Text(text,style:const TextStyle(color:Colors.black, fontFamily: 'sans', fontSize:12),),
          )
        ],
      ),
    );

  }
  // Widget _createDrawerItem(
  //     {required IconData icon, required String text, required GestureTapCallback onTap}) {
  //
  //
  //   return   GestureDetector(
  //     onTap: () => setState(() {
  //       showSnackBarAsBottomSheet(context);
  //     }),
  //     child: Padding(
  //       padding: EdgeInsets.only(right: 8),
  //       child: Row(
  //         children: <Widget>[
  //           Icon(icon,size: 18,),
  //           Padding(
  //             padding:const EdgeInsets.only(right: 8.0),
  //             child: Text(text,style:const TextStyle(color:Colors.black, fontFamily: 'sans', fontSize:12),),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  //
  // }
  static void showSnackBarAsBottomSheet(BuildContext context)
  {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0),
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds:2), () {
          try {
            Navigator.pop(context);
          } on Exception {}
        });
        return Container(
            color: Colors.grey.shade800,
            padding: const EdgeInsets.all(12),
            child: Wrap(children: [
              Center(
                child: Text(
                  "در حال حاضر دسترسی به این قسمت امکان پذیر نمیباشد",
                  style:TextStyle(fontFamily: "sans",color: Colors.white,fontSize: 12),
                ),
              )
            ]));
      },
    );
  }
  // static void showSnackBarAsBottomSheetError(BuildContext context)
  // {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     barrierColor: const Color.fromRGBO(0, 0, 0, 0),
  //     builder: (BuildContext context) {
  //       Future.delayed(const Duration(seconds:2), () {
  //         try {
  //           Navigator.pop(context);
  //         } on Exception {}
  //       });
  //       return Container(
  //           color: Colors.red,
  //           padding: const EdgeInsets.all(12),
  //           child: Wrap(children: [
  //             Center(
  //               child: Text(
  //                 "در حال حاضر دسترسی به این قسمت امکان پذیر نمیباشد",
  //                 style:TextStyle(fontFamily: "sans",color: Colors.white,fontSize: 12),
  //               ),
  //             )
  //           ]));
  //     },
  //   );
  // }
  void _launchURL() async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

}
