
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getxController/storagedata/StrorageAllData.dart';
import '../../materialcolors/materialcolors.dart';

class PopupMenuFilter extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final bool? ticketSending;
  const PopupMenuFilter({Key? key,required this.onChanged,required this.ticketSending}) : super(key: key);

  @override
  _PopupMenuFilterState createState() => _PopupMenuFilterState();
}

class _PopupMenuFilterState extends State<PopupMenuFilter> {

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.filter_alt,color: Palette.bottomNavSelected,),
      onSelected: (String result) {
        switch (result) {
          case 'filterSend':
            widget.onChanged!("filterSend");
            break;
          case 'filterReceived':
            widget.onChanged!("filterReceived");

            break;
          default:
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'filterReceived',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.ticketSending==false? Icon(Icons.check,size: 15,color: Colors.black,):SizedBox(),
              Align(alignment: Alignment.centerRight,
                  child: Text('تیکتهای دریافت شده',style: TextStyle(color: Colors.black, fontFamily: 'sans', fontSize: 12),))],
          ),
        ),
        PopupMenuItem<String>(
          value: 'filterSend',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              widget.ticketSending==true? Icon(Icons.check,size: 15,color: Colors.black,):SizedBox(),
              Align(alignment: Alignment.centerRight
                ,child: Text('تیکتهای ارسال شده',style: TextStyle(color: Colors.black, fontFamily: 'sans', fontSize: 12),)),
          ]),
        ),

      ],
    );

  }
}
