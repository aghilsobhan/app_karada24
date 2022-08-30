import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../getxController/value_department_id.dart';
import '../widgets/tickets/show_model_sheet.dart';

class SelectDropListTct extends StatefulWidget {
  final Function(int userDepId) userDepId;
  const SelectDropListTct( {Key? key, required this.userDepId}) : super(key: key);
  @override
  _SelectDropListState createState() => _SelectDropListState();
}

class _SelectDropListState extends State<SelectDropListTct> {
  String nameDep="کارشناس";
  int userDepIds=-1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _showModelBottom();
            setState(() {

            });
          },
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 10),
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

                   // _runExpandCheck();
                    setState(() {

                    });
                  },
                  child: Text(nameDep, style: const TextStyle(
                      color: Palette.primaryColorD,
                      fontSize: 14,
                      fontFamily: "sans"),),
                ),
                Icon(
                    Icons.arrow_right,
                  color: Palette.primaryColorD,
                  size: 25,
                ),


              ],
            ),
          ),
        ),

      ],
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
          return BottomSheetCustom(valueText: (String title) { setState(() {
            nameDep=title;
          }); }, userDepId: (int userDepId) {
            userDepIds=userDepId;
            widget.userDepId(userDepId);
          },);
        }).whenComplete(() {
          setState(() {


          });
    },);
  }


}