import 'package:app_karada24/apiService/api_service_list_product.dart';
import 'package:app_karada24/models/ticket/model_send_body.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../getxController/storagedata/StrorageAllData.dart';
import '../../getxController/value_department_id.dart';
import '../../materialcolors/materialcolors.dart';
import '../../response/response_recive_all_products.dart';

import '../../utility/snackbar_error.dart';
class BottomSheetCustomCategory extends StatefulWidget {
  final Function(String title) valueText;
  const BottomSheetCustomCategory({Key? key, required this.valueText}) : super(key: key);

  @override
  _BottomSheetCustomCategoryState createState() => _BottomSheetCustomCategoryState();
}

class _BottomSheetCustomCategoryState extends State<BottomSheetCustomCategory> {
  late Future<void> fListTctProduct;
  List<DatProduct> listProduct = <DatProduct>[];
ModelBodyTicket _modelBodyTicket=ModelBodyTicket();
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
            Text("محصول خود را انتخاب کنید:",style: TextStyle(fontFamily: "sans",fontSize: 12,color: Palette.primaryColorD,fontWeight: FontWeight.bold),),
            Divider(indent: 10,endIndent: 10,),
            FutureBuilder(
                future: fListTctProduct,
                builder: (context, snapshot) {
                  if (ConnectionState.waiting==true) {
                    return SizedBox(height: 15,width: 15,child: CircularProgressIndicator(color: Palette.primaryColorD,strokeWidth: 0.8,));
                  }else if (snapshot.hasError){
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }else{
                    return ListProduct();
                     }
                }),

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
  Widget ListProduct() {
    // if(listProduct.length<=0){
    //   return Center(
    //     child: Text(
    //       "محصولی برای انتخاب وجود ندارد",
    //       style: TextStyle(
    //           fontFamily: "sans",
    //           fontSize: 12,
    //           color: Colors.red,
    //           fontWeight: FontWeight.bold),
    //     ),
    //   );
    // }else{
      return GridView.builder(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(


              crossAxisCount: 3),
          shrinkWrap: true,
          itemCount: listProduct.length,
          itemBuilder: (BuildContext ctx, index) {
            Products protest = pro[index];
            DatProduct product = listProduct[index];
            return Listener(
              onPointerDown: (event) => setState(() {
                product.isTouchingGh = true;
              }),
              onPointerUp: (event) => setState(() {
                product.isTouchingGh = false;
                widget.valueText(product.proTittle as String);
                Get.find<ValueDepartmentDepId>().ValueCatId(product.proId as int);
                //  _modelBodyTicket.productName=product.proTittle;
                // // _modelBodyTicket.productId=product.proId;
                Navigator.pop(context,product.proTittle);
              }),
              child: Padding(
                padding: EdgeInsets.only(right: 8, left: 8),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(100.0)),
                          elevation: 5,
                          color: product.isTouchingGh == false
                              ? Colors.white
                              : Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: AssetImage(
                                protest.image,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          product.proTittle.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'sans',
                              fontSize: 11,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
            //   : const Center(
            // child: CircularProgressIndicator(),
            //  );
          });
   // }

    // return Expanded(
    //   child: ListView.builder(
    //     itemCount: listProduct.length,
    //     scrollDirection: Axis.vertical,
    //     itemBuilder: (context, index) {
    //       return GestureDetector(
    //         onTap: () {
    //           setState(() {
    //             // _selectedIndex = index;
    //             // productId = listProduct[index].proId!;
    //             // _setDataCategori();
    //           });
    //         },
    //         child: Container(
    //           width: 150,
    //           height: 40,
    //           margin: EdgeInsets.all(8),
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10),
    //
    //                 color: Colors.white,
    //           ),
    //           child: Align(
    //               alignment: Alignment.center,
    //               child: Padding(
    //                   padding: EdgeInsets.all(8),
    //                   child: Text(
    //                     listProduct[index].proTittle as String,
    //                     textAlign: TextAlign.center,
    //                     style: TextStyle(
    //                       color:  Colors.black,
    //                       fontSize: 12,
    //                       fontFamily: "sans",
    //                     ),
    //                   ))),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
  Future<void> _setDataTctCategories() async {
    ApiServiceListProduct apiservice = ApiServiceListProduct();

    apiservice.listTickets(Get.find<ControllerGetStorageAllData>().token,Get.find<ControllerGetStorageAllData>().organId??1).then((value) async {
      try {
        if (value.data != null) {
          listProduct=value.data!;
          print(listProduct.length);
          setState(() {});
        } else {}
      } catch (e) {
        SnackError(context, "مشکل در برقراری ارتباط با سرور");
        debugPrint(e.toString());
      }
    }).catchError((onError){
      print(onError);
      SnackError(context, "مشکل در برقراری ارتباط با سرور");
    });
  }
}