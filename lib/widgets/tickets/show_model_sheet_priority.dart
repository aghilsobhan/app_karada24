
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../getxController/value_department_id.dart';
import '../../materialcolors/materialcolors.dart';

import '../../response/response_recive_all_products.dart';


class BottomSheetCustomPriority extends StatefulWidget {
  final Function(String title) valueText;
  const BottomSheetCustomPriority({Key? key, required this.valueText}) : super(key: key);

  @override
  _BottomSheetCustomPriorityState createState() => _BottomSheetCustomPriorityState();
}

class _BottomSheetCustomPriorityState extends State<BottomSheetCustomPriority> {
  late Future<void> fListTctProduct;

 List<DatProduct> listPriority=<DatProduct>[];

 late DatProduct _datProduct;
  // DropListModelTctCategories dropListModel = DropListModelTctCategories([]);
  // late List<DataTctCategories> _listDataTctDepartment=[];
  String nameDep="";
  int depId=-1;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 10,),
            Text("اولویت خود را انتخاب کنید:",style: TextStyle(fontFamily: "sans",fontSize: 12,color: Palette.primaryColorD,fontWeight: FontWeight.bold),),
            Divider(indent: 10,endIndent: 10,),
            ListViewPriority(),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );

  }
  @override
  void initState() {
   fListTctProduct=_setDataTctCategories();

    super.initState();
  }
  Widget ListViewPriority() {

    return ListView.builder(
      itemCount: listPriority.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.valueText(listPriority[index].proTittle!);
              Get.find<ValueDepartmentDepId>().ValuePrioriId(listPriority[index].proId as int);
              Navigator.pop(context);

            });
          },
          child: Container(
            width: 150,
            height: 40,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
            ),
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      listPriority[index].proTittle as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color:  Colors.black,
                        fontSize: 12,
                        fontFamily: "sans",
                      ),
                    ))),
          ),
        );
      },
    );
  }
  Future<void> _setDataTctCategories() async {

    listPriority.add(    DatProduct(
      proId: 1,
      proTittle: 'متوسط',
      proDescription: 'متوسط',
    ));
    listPriority.add(     DatProduct(
      proId: 2,
      proTittle: 'زیاد',
      proDescription: 'زیاد',
    ),);
    listPriority.add(  DatProduct(
      proId: 3,
      proTittle: 'بحرانی',
      proDescription: 'بحرانی',
    ));

  }
}