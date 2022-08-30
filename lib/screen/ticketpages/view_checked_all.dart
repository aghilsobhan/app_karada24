import 'package:app_karada24/value/style_more.dart';
import 'package:flutter/material.dart';
class ViewCheckedAll extends StatefulWidget {
  final Function(int) onChangedCallbackValue;
  const ViewCheckedAll({Key? key, required this.onChangedCallbackValue}) : super(key: key);

  @override
  _ViewCheckedAllState createState() => _ViewCheckedAllState();
}

class _ViewCheckedAllState extends State<ViewCheckedAll> {
  // Group Value for Radio Button.
  int? val = 0;
  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Row(
    //     children: [
    //
    //       Radio(
    //         value: id,
    //         groupValue: id,
    //         onChanged: (int? value) {
    //           setState(() {
    //             widget.callBackID(id);
    //             id = id;
    //           });
    //
    //         },
    //       ),
    //       Text(
    //         "نمایش برای همه",
    //       ),
    //     ],
    //   ),
    //     Row(
    //       children: [
    //
    //         Radio(
    //           value: id,
    //           groupValue: id,
    //           onChanged: (int? value) {
    //             setState(() {
    //               widget.callBackID(id);
    //               id = id;
    //             });
    //
    //           },
    //         ),
    //         Text(
    //           "نمایش برای همه",
    //         ),
    //       ],
    //     )],
    // );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Text('نمایش برای همه',style:TextStyle(fontFamily: "sans",fontSize: 12,color: Colors.black),),
            leading: Radio(
              value: 0,
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value as int?;
                  widget.onChangedCallbackValue(val!);
                });
              },
            ),
          ),
        ),
        Directionality(
          textDirection: TextDirection.rtl,
          child: ListTile(
            title: Text('نمایش فقط برای کارشناس',style:TextStyle(fontFamily: "sans",fontSize: 12,color: Colors.black)),
            leading: Radio(
              value: 1,
              groupValue: val,
              onChanged: (value) {
                setState(() {
                  val = value as int?;
                  widget.onChangedCallbackValue(val!);
                  print(value);
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
