import 'package:flutter/material.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:flutter_svg/svg.dart';
class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backGroundColorD,
       body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children:[
              Image.asset("images/notconnection.png",
              height: 250,
              width: 300,),
              SizedBox(height: 20,),
              Text("مشکل در برقراری ارتباط",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),

        ])),
    );
  }
}
