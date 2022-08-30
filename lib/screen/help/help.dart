import 'package:flutter/material.dart';
import 'package:app_karada24/apiService/api_service_all_help.dart';
import 'package:app_karada24/apiService/api_service_list_product.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/response/response_all_help.dart';
import 'package:app_karada24/response/response_recive_all_products.dart';
import 'package:app_karada24/screen/help/help_html.dart';
import 'package:app_karada24/utility/exit_dialog.dart';
import 'package:app_karada24/utility/search_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../getxController/storagedata/StrorageAllData.dart';
class Help extends StatefulWidget {
   Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  String query = '';
  bool loading=false;
  bool getPage=false;
  late Future<void> listCategories;
  List<DatProduct> listProduct = <DatProduct>[];
  late int _selectedIndex = 0;
  late int? productId=5;
  List<DataHelp> listFaqP = <DataHelp>[];
  late Future<void> fListFaq;
  String? token=Get.find<ControllerGetStorageAllData>().token;
  @override
  void initState() {
    listCategories = _setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading==false? Scaffold(
      backgroundColor: Palette.backGroundColorD,
      body: Column(
        children: [
          SearchWidget(
              text: query, onChanged: searchProduct, hintText: "جستجوی محصول.."),
          allListProduct(),
        ],
      ),
      appBar: AppBar(

        backgroundColor: Palette.bottomNavUnBack,
        toolbarHeight: 40.0,
        leadingWidth: 40,// double
        automaticallyImplyLeading: false,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 6),
              child: Align(alignment: Alignment.center,
                  child: Text("راهنما",
                    style: TextStyle(color: Colors.black,
                        fontFamily: "sans",
                        fontWeight: FontWeight.bold),
                  )
              )
          )
        ],
      ),
    ):getPage==false?Center(
      child: CircularProgressIndicator(strokeWidth: 0.8),):ErrorPages();
  }
  Widget ErrorPages(){
    return Container(
      color: Palette.backGroundColorD,
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Image.asset("images/notconnection.png",
                  height: 250,
                  width: 300,),
                SizedBox(height: 20,),
                Text("مشکل در برقراری ارتباط",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading=true;
                      getPage=false;
                      listCategories = _setData();
                      print("is test");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Palette.primaryColorD,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ), child:  const Text(
                  'تلاش دوباره',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'sans',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                )
              ])),
    );
  }
  Widget allListProduct() {
    return FutureBuilder(
      future: listCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 0.5,),
          );
          //return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return ListProduct();
        }
      },
    );
  }
  Widget ListProduct() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ListView.builder(
                itemCount: listProduct.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        productId = listProduct[index].proId!;
                        _setDataCategori();
                      });
                    },
                    child: Container(
                      height: 40,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _selectedIndex == index
                            ? Colors.black54
                            : Colors.white,
                      ),
                      child: Center(
                          child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    listProduct[index].proTittle as String,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: _selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 12,
                                        fontFamily: "sans",
                                    ),
                                  )))),
                    ),
                  );
                },
              ),
            ),
          ),
          loading==true?CircularProgressIndicator(strokeWidth: 0.5,):ListFaqProduct(),
        ]),
      ),
    );
  }
  Future<void> _setDataCategori() async {
    listFaqP.clear();
    ApiServiceAllHelp apiservice = await ApiServiceAllHelp();
    await apiservice.listHelp(Get.find<ControllerGetStorageAllData>().organId??1,productId!,token.toString()).then((value) async {
      try {
        if (value.data != null) {
          for (int i = 0; i < value.data!.length; i++) {
            listFaqP.add(value.data![i]);
          }
          setState(() {loading=false;});
        } else {setState(() {
          loading=false;
        });}
      } catch (e) {
        setState(() {
          loading=false;
          getPage=true;
        });
        debugPrint(e.toString());
      }
    }).catchError((onError) {
      setState(() {
        print(onError);
        loading=true;
        getPage=true;
      });

    });
  }
  Widget ListFaqProduct() {

    return loading==false? listFaqP.length!=0?
    ListView.builder(
      itemCount: listFaqP.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          child: Padding(
              padding:const  EdgeInsets.all(8),
              child: ListHelpTitle(listFaqP[index].hlpTittle as String,listFaqP[index].hlpBody),
        ));
      },
    ):Center(
      child: Column(
        children: [
          Image.asset("images/null.png",
            height: 100,
            width: 100,),
          SizedBox(height: 15,),
          Text("اطلاعاتی برای این محصول ثبت نشده",style: TextStyle(fontSize: 12,fontFamily: "sans",),)
        ],
      ),
    ):CircularProgressIndicator(strokeWidth: 0.5,);
  }
Widget ListHelpTitle(String title,body){
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return DescriptionHelp(body);
              });
            });
      },
      child: Directionality(
       textDirection: TextDirection.rtl,
        child: Container(
          child:Text(title+"؟",style: TextStyle(fontSize: 12,color: Colors.blue,fontFamily: "sans",),) ,
        ),
      ),
    ) ;
}
  void searchProduct(String query) {
    if (query.isEmpty) {
      _setData();
      setState(() {
        this.query = query;
      });
    } else {
      final product = listProduct.where((element) {
        final titleLowerCase = element.proTittle?.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return titleLowerCase?.contains(searchLowerCase) as bool;
      }).toList();
      setState(() {
        this.query = query;
        listProduct = product;
      });
    }
  }
  Future<void> _setData() async {
    setState(() {
      loading=true;
      getPage=false;
    });
    ApiServiceListProduct apiservice = await ApiServiceListProduct();
    await  apiservice.listTickets(token,Get.find<ControllerGetStorageAllData>().organId??1).then((value) async {
      try {
        if (value.data != null) {
          listProduct = value.data!;
          productId=value.data![0].proId ;
          fListFaq = _setDataCategori();
          // searchListProduct=listProduct;
          setState(() {});
        } else {}
      } catch (e) {
        debugPrint(e.toString());
      }
    }).catchError((onError) {
      setState(() {
        loading=true;
        getPage=true;
      });
    });
  }
}

