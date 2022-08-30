import 'package:app_karada24/widgets/tickets/show_model_sheet_category.dart';
import 'package:app_karada24/widgets/tickets/show_model_sheet_priority.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../materialcolors/materialcolors.dart';
import '../models/ticket/model_send_body.dart';


class SelectDropList extends StatefulWidget {
 final String nameTitle;
final  int id;
  const SelectDropList({Key? key, required this.id,required this.nameTitle}) : super(key: key);

  @override
  _SelectDropListState createState() => _SelectDropListState();
}

class _SelectDropListState extends State<SelectDropList>{
  String nameTitleSelectedC="نام محصول";
  String nameTitleSelectedP="اولویت";
  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _showModelBottom();
            },
            child: Container(
              height: 45,
              decoration:  BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 2,
                      color: Colors.black26,
                      offset: Offset(0, 2))
                ],
              ),
              child:  Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: <Widget>[
                  GestureDetector(
                    onTap: () {

                        _showModelBottom();

                    },
                    child: Padding(padding: EdgeInsets.only(right: 6),
                        child:Text(widget.id==1?nameTitleSelectedC:nameTitleSelectedP, style: const TextStyle(
                        color: Palette.primaryColorD,
                        fontSize: 14,
                        fontFamily: "sans"),)),
                  ),

                  Icon(
                    Icons.arrow_right,
                    color: Palette.primaryColorD,
                    size: 25,
                  )

                ],
              ),
            ),
          ),

//          Divider(color: Colors.grey.shade300, height: 1,)
        ],
      ),
    );
  }

  void _showModelBottom() {
    showModalBottomSheet(
        context: context,
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {

          if(widget.id==1){
            return BottomSheetCustomCategory(valueText: (String title) {
              setState(() {
                nameTitleSelectedC=title;
              }); },);
          }else{
            return BottomSheetCustomPriority(valueText: (String title) { setState(() {
              nameTitleSelectedP=title;
            }); },);
          }

        }).whenComplete(() {
          setState(() {

          });
    });
  }
}