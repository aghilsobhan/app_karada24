
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:intl/intl.dart';
import  'package:persian_number_utility/persian_number_utility.dart';

import '../screen/ticketpages/widget_ticket.dart';


class DescriptionSelectDropListTct extends StatefulWidget {
  final   DateTime _dateTime;
  final   String? titleTicket;
  final   String? bodyTicket;
  final   int? tckStatId;
  final   int? tckPriorityId;
  final   String? prioTittle;
  final int tckId;

  const DescriptionSelectDropListTct(this.titleTicket,this._dateTime,this.tckId,{Key? key, this.bodyTicket, this.tckStatId, this.tckPriorityId, this.prioTittle}) : super(key: key);

  @override
  _DescriptionSelectDropListState createState() => _DescriptionSelectDropListState();
}

class _DescriptionSelectDropListState extends State<DescriptionSelectDropListTct> with SingleTickerProviderStateMixin {

  // late   String _dateTime;
  // late final int tckId;

  late AnimationController expandController;
  late Animation<double> animation;
  bool isShow = true;
  @override
  void initState() {
    super.initState();
    expandController = AnimationController(
        vsync: this,
        duration:const Duration(milliseconds: 350)
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
    _runExpandCheck();
  }

  void _runExpandCheck() {
    if(isShow) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         GestureDetector(
//           onTap: () {
//             isShow = !isShow;
//             _runExpandCheck();
//             setState(() {
//
//             });
//           },
//           child: Container(
//             height: 40,
//             width: 160,
//             padding: const EdgeInsets.symmetric(
//                 horizontal: 10, vertical: 10),
//             decoration:  BoxDecoration(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             child:  Row(
//               mainAxisAlignment:
//               MainAxisAlignment.spaceBetween,
//
//               children: <Widget>[
//                 Icon(
//                   isShow ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down,
//                   color: Colors.black,
//                   size: 20,
//                 ),
//                 GestureDetector(
//                   onTap: () {
//                     isShow = !isShow;
//                     _runExpandCheck();
//                     setState(() {
//
//                     });
//                   },
//                   child: const Text("جزییات تیکت", style:  TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                       fontFamily: "sans"),),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//         SizeTransition(
//             axisAlignment: 1.0,
//             sizeFactor: animation,
//             child: Column(
//               children:[
//                 const SizedBox(height: 10,),
//                 Container(
//                     margin: const EdgeInsets.only(bottom: 10,left: 20,right: 20),
//                     decoration:   BoxDecoration(
//                       border: Border.all(color: Palette.gradient2),
//                       borderRadius: BorderRadius.circular(10),
//
//                     ),
//                     child: _buildSubMenu("_dateTime", context)
//                 )],
//             )
//         ),
// //          Divider(color: Colors.grey.shade300, height: 1,)
//       ],
//     );
  return   _buildSubMenu("_dateTime", context);
  }

  // Column _buildDropListOptions(DateTime items, BuildContext context) {
  //   return Column(
  //
  //     children: items.map((item) => _buildSubMenu(item, context)).toList(),
  //   );
  // }

  Widget _buildSubMenu(String item, BuildContext context) {
String date=widget._dateTime.toString();
List<String> dt=date.split(" ");
List<String> time=dt[1].split(".");
var dtd=date.toPersianDate();
    return GestureDetector(
      child: Padding(
        padding:const EdgeInsets.only(right:8,top: 8,bottom: 8),
        child: Directionality(
          textDirection:ui.TextDirection.rtl,
          child: Column(
            children:[ Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    const Text(
                      "شماره تیک :",
                      style:  TextStyle(
                          color: Palette.gradient2,
                          fontFamily: "sans",
                          fontSize: 14),
                    ),
                    const SizedBox(width: 9,),
                    Text(
                      widget.tckId.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "sans",
                          fontSize: 10),)],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                     const Text(
                         "تاریخ :",
                        style:  TextStyle(
                            color: Palette.gradient2,
                            fontFamily: "sans",
                            fontSize: 14)),
                    const SizedBox(width: 9,),
                     Padding(
                       padding: EdgeInsets.only(left: 6),
                       child: Text(
                        "${dtd} , ${time[0]}",
                         style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "sans",
                              fontSize: 10),
                       ),
                     )],
                ),


              ],
            ),
              Divider(indent: 10.0,endIndent: 10.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.tckStatId == 3
                      ? StyleStatusTicket(title: 'تیکت بسته شده', textColor: Colors.red, icon: Icons.closed_caption_disabled,iconColor: Colors.red,)
                      : widget.tckStatId == 2
                      ?
                  StyleStatusTicket(title: ' در حال پاسخگویی', textColor: Colors.green, icon:Icons.question_answer,iconColor: Colors.green,)
                      :
                  StyleStatusTicket(title: '  در حال بررسی', textColor: Palette.primaryColorD, icon: Icons.pending,iconColor: Palette.primaryColorD,),
                  StyleStatusTicket(title: widget.prioTittle.toString(), textColor:Colors.black, icon: Icons.circle,iconColor:widget.tckPriorityId==1?
                  Palette.primaryColorD:widget.tckPriorityId==2?Palette.accentColor:Palette.error,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const  Text(
                    "عنوان :",
                    style:  TextStyle(
                        color: Palette.gradient2,
                        fontFamily: "sans",
                        fontSize: 14),),
                  const SizedBox(width: 9,),
                  Text(
                    widget.titleTicket.toString(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "sans",
                        fontSize: 12),) ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:EdgeInsets.only(right: 8),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width:  MediaQuery.of(context).size.width-50,
                        child: Text(
                          widget.bodyTicket.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: "sans",
                              fontSize: 12),),

                      ),
                    ),
                  ),],
              ),
              const SizedBox(width: 9,),


            ],
          ),
        ),
      ),
      onTap: () {
      },
    );
  }

}