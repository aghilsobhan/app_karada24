import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StyleStatusTicket extends StatelessWidget {
  final String title;
  final Color textColor;
  final IconData icon;
  final Color? iconColor;
  StyleStatusTicket({
    required this.title,
    required this.textColor,
    required this.icon,
    this.iconColor
  });
  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: const EdgeInsets.only(left: 6,  bottom: 6,right: 6),
      padding: const EdgeInsets.only(left: 6,right: 6),
      decoration: BoxDecoration(
        borderRadius : BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow : [BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0,2),
            blurRadius: 2
        )],
        color : Palette.bottomNavUnBack,
      ),
      child:
      Row(children:[
        Padding(padding: EdgeInsets.only(left: 3),child: Icon(icon,size: 10,color: iconColor,)),
        Padding(padding: EdgeInsets.only(top: 3,bottom: 3),child: Text(title.toString(),maxLines: 1,overflow: TextOverflow.ellipsis,style: TextStyle(color: textColor, fontFamily: 'sans', fontSize: 10))),

      ]),
    );
  }
}
class StyleFilterTicket extends StatelessWidget {
  final String title;
  final Color textColor;
  StyleFilterTicket({
    required this.title,
    required this.textColor
  });
  @override
  Widget build(BuildContext context) {
    return   Container(
      margin: const EdgeInsets.only(left: 6, top: 6.0, bottom: 15,right: 6),
      padding: const EdgeInsets.only(left: 6, right: 6),
      decoration: BoxDecoration(
        borderRadius : BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow : [BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0,4),
            blurRadius: 4
        )],
        color : Color.fromRGBO(122, 120, 120, 1),
      ),
      child: Padding(padding: EdgeInsets.only(top: 3,bottom: 3),child: Text(title.toString(),style:  TextStyle(color: textColor, fontFamily: 'sans', fontSize: 12))),
    );
  }
}