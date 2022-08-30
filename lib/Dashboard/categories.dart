
import 'package:app_karada24/getxController/list_ticket.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/apiService/api_service_list_product.dart';
import 'package:app_karada24/descriptionproduct/description_product_selected.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/models/model_count_task_ticket.dart';
import 'package:app_karada24/response/response_recive_all_products.dart';
import 'package:app_karada24/screen/ticketpages/all_tickect_view.dart';
import 'package:app_karada24/widgets/shimmer_load.dart';
import 'package:app_karada24/widgets/show_toast.dart';

import '../apiService/api_service_listtickets.dart';
import '../getxController/check_badge_tickets.dart';
import '../getxController/storagedata/StrorageAllData.dart';
import '../response/response_list_tickets.dart';
import '../screen/ticketpages/close_ticket_view.dart';

import '../screen/ticketpages/open_ticket_view.dart';
import '../utility/luch_url.dart';
import 'package:get/get.dart';

class Categories extends StatefulWidget {
  Categories({Key? key}) : super(key: key);
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories>
    with SingleTickerProviderStateMixin {
  late Future<void> listCategories;
  List<DatProduct> listProduct = <DatProduct>[];
  late double screenWidth, screenHeight;
  List<DataTicket> listTickets = <DataTicket>[];
  List<DataTicket> closeListTickets = <DataTicket>[];
  List<DataTicket> openListTickets = <DataTicket>[];

  final List<String> imageList = [
    "images/slid1.jpg",
    "images/slid2.jpg",
    "images/slid3.jpg",
    "images/backgroundmenu.jpg"
  ];
  List<DataCountT> listDateCountTicket = [];
  List<DataCountT> listDateCountTask = [
    DataCountT(count: 0, image: "images/alltask.png", text: "لیست وظایف"),
    DataCountT(count: 0, image: "images/doingtask.png", text: "درحال انجام"),
    DataCountT(count: 0, image: "images/donetask.png", text: "انجام شده")
  ];
  final duration = const Duration(milliseconds: 300);
  bool isLoading = false;
  bool getPage = false;
  ScrollController _scrollController = ScrollController();
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _menuScaleAnimation;
  late Animation<Offset> _slideAnimation;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;
    return isLoading == false
        ? Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    launchURL('https://phx.ir/');
                  },
                  child: SizedBox(
                    width: screenWidth,
                    height: 130,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        autoPlay: true,
                      ),
                      items: imageList
                          .map((e) => ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      e,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      "محصولات :",
                      style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'sans',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Divider(
                    color: Palette.primaryColorD.withOpacity(0.1),
                    indent: 8,
                    endIndent: 8,
                    thickness: 1),
                const SizedBox(
                  height: 7,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
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
                              showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                        builder: (context, setState) {
                                      return DescriptionSelectedProduct(
                                          product.proDescription,
                                          product.proTittle);
                                    });
                                  });
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
                                          padding: const EdgeInsets.all(6.0),
                                          child:  CircleAvatar(
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
                        }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                    color: Palette.primaryColorD.withOpacity(0.1),
                    indent: 8,
                    endIndent: 8,
                    thickness: 1),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      "تعداد تیکتها :",
                      style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'sans',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: ListView.builder(
                        itemExtent: 120,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listDateCountTicket.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                              child: GestureDetector(
                            onTap: () {
                              if (index == 0) {
                                Navigator.push(this.context,
                                    MaterialPageRoute(builder: (context) {
                                  return AllTicketView();
                                }));
                              } else if (index == 1) {
                                Navigator.push(this.context,
                                    MaterialPageRoute(builder: (context) {
                                  return OpenTicketView();
                                }));
                              } else {
                                Navigator.push(this.context,
                                    MaterialPageRoute(builder: (context) {
                                  return CloseTicketView();
                                }));
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Image.asset(
                                      listDateCountTicket[index].image,
                                      width: 40,
                                      height: 40,
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      listDateCountTicket[index].text +
                                          " : " +
                                          listDateCountTicket[index]
                                              .count
                                              .toString(),
                                      style: TextStyle(
                                          fontFamily: 'sans',
                                          fontSize: 11,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                          //   : const Center(
                          // child: CircularProgressIndicator(),
                          //  );
                        }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      "تعداد وظایف :",
                      style: const TextStyle(
                          fontSize: 10,
                          fontFamily: 'sans',
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    alignment: Alignment.center,
                    height: 100,
                    child: ListView.builder(
                        itemExtent: 120,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: listDateCountTask.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return InkWell(
                              child: GestureDetector(
                            onTap: () {
                              showToast(context, "این قسمت در حال توسعه است");
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              elevation: 5,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Image.asset(
                                      listDateCountTask[index].image,
                                      width: 55,
                                      height: 55,
                                      colorBlendMode: BlendMode.modulate,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      listDateCountTask[index].text +
                                          " : " +
                                          listDateCountTask[index]
                                              .count
                                              .toString(),
                                      style: TextStyle(
                                          fontFamily: 'sans',
                                          fontSize: 11,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                          //   : const Center(
                          // child: CircularProgressIndicator(),
                          //  );
                        }),
                  ),
                ),
              ],
            ),
          )
        : getPage == false
            ? CustomShimmerWidgetMain()
            : ErrorPages();
  }

  @override
  void initState() {
    listCategories = _setData();

    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
            .animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _setData() async {
    try{
       if (Get.find<ControllerGetStorageAllData>().token != null) {
        ApiServiceListProduct apiServiceListProduct = ApiServiceListProduct();
        ApiServiceListTickets apiServiceListTickets = ApiServiceListTickets();
        setState(() {
          isLoading = true;
          getPage = false;
        });
        apiServiceListProduct
            .listTickets(Get.find<ControllerGetStorageAllData>().token,Get.find<ControllerGetStorageAllData>().organId??1)
            .then((value) async {
          try {
               listProduct = value.data!;
              await apiServiceListTickets
                  .listTickets(Get.find<ControllerGetStorageAllData>().userRolId,Get.find<ControllerGetStorageAllData>().organId,Get.find<ControllerGetStorageAllData>().IsRolId,
                  Get.find<ControllerGetStorageAllData>().token)
                  .then(
                    (value) {
                  try {

                    if (value.data != null) {

                      // var badgeShow = false;
                      // listTickets = value.data!;
                      // for (int i = 0; i < value.data!.length; i++) {
                      //   if (listTickets[i].newReplyCount! > 0) {
                      //     badgeShow = true;
                      //   }
                      //   if (value.data![i].roleId! == 0) {
                      //     listTickets.add(value.data![i]);
                      //   }
                      //   if (value.data![i].tckStatId == 3 &&value.data![i].roleId! == 0) {closeListTickets.add(value.data![i]);
                      //   } else if(value.data![i].tckStatId != 3  &&value.data![i].roleId! == 0) {
                      //     openListTickets.add(value.data![i]);
                      //   }
                      // }
                      // Get.find<GetBadgeTickets>().CheckedBadge(badgeShow);
                      setState(() {
                        isLoading = false;
                      });
                      listDateCountTicket = [
                        DataCountT(
                            count: Get.find<GetListTicketing>().listSendingTicketing!.length,
                            image: "images/allticket.png",
                            text: "همه"),
                        DataCountT(
                            count:   Get.find<GetListTicketing>().listOpenTicketing!.length,
                            image: "images/openticket.png",
                            text: "باز"),
                        DataCountT(
                            count:   Get.find<GetListTicketing>().listCloseTicketing!.length,
                            image: "images/ticketclose.png",
                            text: "بسته")
                      ];
                    } else {}
                  } catch (e) {
                    setState(() {
                      isLoading = true;
                      getPage = true;
                    });
                  }
                },
              ).catchError((e) {
                setState(() {
                  isLoading = true;
                  getPage = true;
                });
              }).onError((error, stackTrace) {
                setState(() {
                  isLoading = true;
                  getPage = true;
                });
              });
              // searchListProduct=listProduct;
              setState(() {});
          } catch (e) {
            setState(() {
              isLoading = true;
              getPage = true;
            });
            debugPrint(e.toString());
          }
        }).catchError((onError) {
          setState(() {
            isLoading = true;
            getPage = true;
          });
        }).onError((error, stackTrace) {
          setState(() {
            isLoading = true;
            getPage = true;
          });
        });
      } else {
        setState(() {
          isLoading = true;
          getPage = true;
        });
      }
    }catch(e){
      print(e.toString());
    }

  }

  Widget ErrorPages() {
    return Container(
      color: Palette.backGroundColorD,
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          "images/notconnection.png",
          height: 250,
          width: 300,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          "مشکل در برقراری ارتباط",
          style: TextStyle(
              fontFamily: "sans", fontSize: 12, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              isLoading = true;
              getPage = false;
              listCategories = _setData();
              print("is test");
            });
          },
          style: ElevatedButton.styleFrom(
            primary: Palette.primaryColorD,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
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
}
