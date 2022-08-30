
import 'package:flutter/material.dart';
import 'package:app_karada24/apiService/api_service_all_faq.dart';
import 'package:app_karada24/apiService/api_service_list_product.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/response/response_recive_all_products.dart';
import 'package:app_karada24/response/response_recived_faq.dart';
import 'package:app_karada24/utility/faq_list.dart';
import 'package:app_karada24/utility/search_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';


import '../getxController/storagedata/StrorageAllData.dart';

// ignore: must_be_immutable
class DescriptionProduct extends StatefulWidget {
   DescriptionProduct(  {Key? key}) : super(key: key);
  @override
  _DescriptionProductState createState() => _DescriptionProductState();
}

class _DescriptionProductState extends State<DescriptionProduct> {
  late Future<void> listCategories;
  List<DatProduct> listProduct = <DatProduct>[];
  late int _selectedIndex = 0;
  late int? productId;
  String query = '';
  String? token=Get.find<ControllerGetStorageAllData>().token;

  List<DatFaq> listFaqP = <DatFaq>[];
  late Future<void> fListFaq;
  bool isLoading=false;
  bool getPage=false;
  bool isLoadingFaq=false;
  @override
  void initState() {
    listCategories = _setData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40,bottom: 40,right: 13,left: 13),
      child:isLoading==false? Container(
        decoration: BoxDecoration(
          color: Palette.bottomNavUnBack,
          border: Border.all(color: Palette.gradient2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,

                children: [
                  const Text("سوالات متداول", style: TextStyle( fontFamily: 'sans',
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 30.0,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(25)),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),

                ],
              ),
            ),

            const Divider(height: 0.3,color: Palette.gradient2,),
            SearchWidget(
                text: query, onChanged: searchProduct, hintText: "جستجوی محصول.."),
            allListProduct(),
          ],
        ),

      ):getPage==false?Center(
        child: CircularProgressIndicator(strokeWidth: 0.8),):ErrorPages(),
    );
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
                Text("لطفا اتصال اینترنت خود را چک کنید.",style: TextStyle(fontFamily: "sans",fontSize: 12,fontWeight: FontWeight.bold),),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading=true;
                      getPage=false;
                      listCategories = _setData();
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
                        productId = listProduct[index].proId;
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
                                    listProduct[index].proTittle.toString(),
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
         isLoadingFaq==true?CircularProgressIndicator(strokeWidth: 0.5,):ListFaqProduct(),
        ]),
      ),
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
  Future<void> _setDataCategori() async {
  listFaqP.clear();
  setState(() {
    isLoadingFaq=true;
  });

    ApiServiceListFaq apiservice = await ApiServiceListFaq();
   await apiservice.listTickets(Get.find<ControllerGetStorageAllData>().organId??1,productId!,token.toString()).then((value) async {
      try {
        if (value.data != null) {
          for (int i = 0; i < value.data.length; i++) {
            listFaqP.add(value.data[i]);
          }
          setState(() {
            isLoadingFaq=false;
            isLoading=false;
          });
        } else {setState(() {
          isLoadingFaq=false;
          isLoading=false;
        });}
      } catch (e) {
        setState(() {
          isLoadingFaq=false;
          isLoading=false;
          getPage=true;
        });
        debugPrint(e.toString());
      }
    }).catchError((onError) {
     setState(() {
       isLoadingFaq=true;
       isLoading=true;
       getPage=true;
     });
   });
  }

  Future<void> _setData() async {
    setState(() {
      isLoading=true;
      getPage=false;
    });
    ApiServiceListProduct apiservice = await ApiServiceListProduct();
  await  apiservice.listTickets(token,Get.find<ControllerGetStorageAllData>().organId??1).then((value) async {
      try {
        if (value.data != null) {
          listProduct = value.data!;
          productId=value.data![0].proId;
          fListFaq = _setDataCategori();
          // searchListProduct=listProduct;
          setState(() {});
        } else {}
      } catch (e) {
        debugPrint(e.toString());
      }
    }).catchError((onError) {
      setState(() {
        isLoading=true;
        getPage=true;
      });
    });
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
  Widget ListFaqProduct() {

    return isLoading==false? listFaqP.length!=0?ListView.builder(
      itemCount: listFaqP.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return SingleChildScrollView(
          child: Container(
                    child: Padding(
                      padding:const  EdgeInsets.all(8),
                        child: SelectFaqList(listFaqP[index],"images/ghoghnoos.jpg")),
          ),
        );
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
}
