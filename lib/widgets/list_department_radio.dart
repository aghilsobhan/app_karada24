import 'package:app_karada24/response/ticket/response_get_link_guest_customer.dart';
import 'package:flutter/material.dart';

typedef StringValueNameDep = String Function(String);
typedef StringValueDepId = int Function(int);
typedef userDepId = int Function(int);
class RadioButton extends StatefulWidget {
 final StringValueNameDep callBackName;
 final StringValueDepId callBackDep;
 final StringValueDepId callBackuserDepId;
  final List<DataGetGuestLinkedCustomer> listDataTct;
  RadioButton({
   required this.listDataTct,
   required this.callBackName,
   required this.callBackDep,
    required this.callBackuserDepId,
});

  @override
  State<RadioButton> createState() => _RadioButtonState();

}

class _RadioButtonState extends State<RadioButton> {

  // Group Value for Radio Button.
  int id = 1;
  // Group Value for Radio Button.
  @override
  Widget build(BuildContext context) {
      return GridView.builder(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 6,
              childAspectRatio:2 ,
              mainAxisSpacing: 6,
          crossAxisCount: 2),
          itemCount: widget.listDataTct.length,
          shrinkWrap: true,
          itemBuilder:  (BuildContext ctx, index) {
        return Row(
          children: [

            Radio(
              value: id,
              groupValue: widget.listDataTct[index].userRoleId,
              onChanged: (int? value) {
                setState(() {
                  print("userRoleId "+widget.listDataTct[index].userRoleId.toString());
                  widget.callBackName(widget.listDataTct[index].fullname as String);
                  widget.callBackDep(widget.listDataTct[index].userRoleId as int);
                  widget.callBackuserDepId(widget.listDataTct[index].userDepId as int);
                   id = widget.listDataTct[index].userRoleId as int;
                                });

              },
            ),
            Text(
              widget.listDataTct[index].fullname.toString(),
            ),
          ],
        );

          });

  }
}
  // Widget build(BuildContext context) {
  //   int? _value=0;
  //   return  Row(
  //     children:
  //     widget.listDataTct.map((data) => Radio(
  //       groupValue: _value,
  //       value: data.depId as int,
  //       onChanged: (val) {
  //         setState(() {
  //           _value = data.depId;
  //         });
  //       },
  //     )).toList(),
  //   );
  //   // return GridView.builder(
  //   //
  //   //     gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
  //   //         crossAxisSpacing: 10,
  //   //         childAspectRatio:3 ,
  //   //         mainAxisSpacing: 10,
  //   //     crossAxisCount: 3),
  //   //     itemCount: widget.listDataTct.length,
  //   //     shrinkWrap: true,
  //   //     itemBuilder:  (BuildContext ctx, index) {
  //   //   return Row(
  //   //     children: [
  //   //
  //   //       Radio(
  //   //         value: id,
  //   //         groupValue: widget.listDataTct[index].depId,
  //   //         onChanged: (int? value) {
  //   //           setState(() {
  //   //              id = widget.listDataTct[index].depId;
  //   //             print("value "+value.toString()+"_value "+_value.toString());
  //   //             print("index "+index.toString());
  //   //           });
  //   //
  //   //         },
  //   //       ),
  //   //       Text(
  //   //         widget.listDataTct[index].name.toString(),
  //   //       ),
  //   //     ],
  //   //   );
  //   //
  //   //     });
  // }



