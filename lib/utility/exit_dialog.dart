
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';

import '../widgets/show_toast.dart';

Future<dynamic> exitDialog(BuildContext context){
  return showDialog(context: context,
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
                SystemNavigator.pop();
              },
              child:  Text("بله",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(primary: Palette.primaryColorD),),

          ],
        ),
      ],
    ),
  );
}
// Future<bool> onWillPopT(BuildContext context,DateTime? currentBackPressTime) {
//
//   DateTime now = DateTime.now();
//   if (currentBackPressTime == null ||
//       now.difference(currentBackPressTime) > Duration(seconds: 2)) {
//     currentBackPressTime = now;
//     showToast(context,"test");
//     return Future.value(false);
//   }
//   return Future.value(true);
// }