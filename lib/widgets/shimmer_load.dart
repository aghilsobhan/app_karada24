import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shimmer/shimmer.dart';

import '../screen/requests/component/buttom_requests.dart';

class CustomShimmerWidgetTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 30),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300] as Color,
                highlightColor: Colors.grey[100] as Color,
                direction: ShimmerDirection.ltr,
                child: ListView.builder(
                  itemBuilder: (_, __) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Stack(
                        children: [
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              elevation: 2.0,
                              child: Column(
                                textDirection: TextDirection.rtl,
                                children: [
                                  Container(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 6, right: 6),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "",
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'sans',
                                                  ),
                                                ),
                                                const Text(
                                                  "تیکت بسته شده",
                                                  style: TextStyle(
                                                    fontSize: 8,
                                                    fontFamily: 'sans',
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ]),
                                        ),
                                        Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 6, right: 6),
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                "",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 6),
                                              child: Text(
                                                "",
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'sans',
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 80,
                                              child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 4),
                                                      child: Icon(
                                                        Icons.file_present,
                                                        size: 25,
                                                      ))),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //Badge(badgeContent: Text(element.newReplyCount.toString().toPersianDigit(),style:const TextStyle(color: Colors.white),),),
                        ],
                      ),
                    );
                  },
                  itemCount: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomShimmerWidgetMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
          baseColor: Colors.grey[300] as Color,
          highlightColor: Colors.grey[100] as Color,
          direction: ShimmerDirection.ltr,
          child: ListView(
            children: [
             Card(
               child: Container(
                 height: 120,
                 width: 80,
               ),
             ),
              const SizedBox(
                height: 25,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      itemBuilder: (BuildContext ctx, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8, left: 8),
                          child: Column(
                            children: [
                              Center(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0)),
                                  elevation: 5,
                                  child: Container(
                                    height: 55,
                                    width: 55,
                                  ),
                                ),
                              ),
                            ],
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: ListView.builder(
                      itemExtent: 120,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                            child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 5,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
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
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  alignment: Alignment.center,
                  height: 100,
                  child: ListView.builder(
                      itemExtent: 120,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (BuildContext ctx, index) {
                        return InkWell(
                            child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          elevation: 5,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(7.0),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ],
                          ),
                        ));
//   : const Center(
// child: CircularProgressIndicator(),
//  );
                      }),
                ),
              ),
            ],
          )),
    );
  }
}
class CustomShimmerWidgetRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child:Shimmer.fromColors( baseColor: Colors.grey[300] as Color,
          highlightColor: Colors.grey[100] as Color,
          direction: ShimmerDirection.ltr,child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {


//widget.getListRequest?.sort((a,b)=>b.?.compareTo(a.statusInt as int)as int);
            return Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                    //test
               Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: 120,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    color: Colors.white70,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.update,
                            size: 18,
                          )),
                      Padding(
                          padding: EdgeInsets.only(right: 6),
                       child: Container(
                          width: 70,
                          height: 15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.white70,


                          ),
                          child: Text(
                            "des",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'sans',
                              fontSize: 12,
                            ),
                          ),
                        ),),
                    ],
                  ),
                )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [

                              Container(
                                width: 100,
                                height: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white70,


                                ),
                                child: Text(
                                  "des",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'sans',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                width: 60,
                                height: 15,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.white70,


                                ),
                                child: Text(
                                  "des",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontFamily: 'sans',
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            radius: 25.0,
                            backgroundImage: AssetImage(
//  widget.getListRequest![index].profile
                              "images/profile.png",
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    indent: 20,
                    endIndent: 20,
                  )
                ],
              ),
            );
          })),
    );
  }
}