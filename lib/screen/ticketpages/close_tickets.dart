import 'package:app_karada24/screen/ticketpages/widget_ticket.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../getxController/list_ticket.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
import '../../materialcolors/materialcolors.dart';
import '../../response/response_list_tickets.dart';
import '../requests/component/widget_filter.dart';
import 'reply_ticket.dart';
import 'upload_file_ticketing.dart';
class CloseTickets extends StatefulWidget {
  final ScrollController scrollController;
  final List<DataTicket>? getListTicketing;
  const CloseTickets({Key? key,required this.scrollController,required this.getListTicketing}) : super(key: key);

  @override
  _CloseTicketsState createState() => _CloseTicketsState();
}

class _CloseTicketsState extends State<CloseTickets> {

  String? token=Get.find<ControllerGetStorageAllData>().token;
  int? userRolId=Get.find<ControllerGetStorageAllData>().userRolId;
  @override
  Widget build(BuildContext context) {
      if (widget.getListTicketing!.isEmpty)
      {
        return Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 85,
              ),
              Image.asset(
                "images/ticketnull.gif",
                height: 85,
                width: 85,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'تیکت وجود ندارد ',
                style: TextStyle(
                  fontFamily: "sans",
                  fontSize: 12,
                ),
              ),
            ]));
      } else{
        return GroupedListView<DataTicket, String>(
          shrinkWrap: true,
          elements: widget.getListTicketing!,
          controller: widget.scrollController,
          physics: BouncingScrollPhysics(),

          padding: const EdgeInsets.only(left: 8, right: 8),
          groupBy: (element) => element.tckCreatedDate.toString().split(" ").first,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1.tckBody!.compareTo(item2.tckBody!),
          useStickyGroupSeparators: true,
          stickyHeaderBackgroundColor: Colors.transparent,
          groupSeparatorBuilder: (String value) =>
              Padding(

                padding: const EdgeInsets.only(top: 5.0, right: 20, left: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            value.toPersianDate().toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'sans',
                                color: Colors.blueGrey),
                          ),
                        ),
                      ),
                    ]),
              ),
          itemBuilder: (c, element) {
            int tckPriorityId=element.tckPriorityId as int;

            String timeMinute= element.tckCreatedDate!.hour.toString()+":"+element.tckCreatedDate!.minute.toString();

            return Padding(

              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return ReplyTicket(
                                element.tckId!,
                                userRolId,
                                token,
                                element.statTittle.toString(),
                                element.tckTittle,
                                element.tckCreatedDate!,
                                tckStatId:element.tckStatId ,
                                tckPriorityId:element.tckPriorityId ,
                                prioTittle:element.prioTittle ,
                                bodyTicket: element.tckBody,);
                            }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        elevation: 4.0,
                        child: Column(
                          textDirection: TextDirection.rtl,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 6, right: 6),
                                    child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children:[
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          Icon(Icons.email_outlined,color: Palette.gradient2,size: 15,),
                                                          SizedBox(width: 6,),
                                                          Text(
                                                            element.tckTittle.toString(),
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                              fontFamily: 'sans',
                                                              color: Palette.gradient2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(right: 6),
                                                      child: Align(
                                                        alignment: Alignment.topLeft,
                                                        child: Text(
                                                          timeMinute,
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: 'sans',
                                                            color: Palette.gradient1,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: Container(
                                                  width:320,
                                                  child: Align(
                                                    alignment: Alignment.topRight,
                                                    child: Text(
                                                      element.tckBody.toString(),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'sans',
                                                      ),
                                                      textDirection: TextDirection.rtl,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "شماره تیکت: " +
                                                    element.tckId.toString(),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: 'sans',
                                                  color: Palette.gradient2,
                                                ),
                                              ),
                                            ],
                                          ),


                                        ]),
                                  ),

                                  Divider(),
                                  Container(
                                    width: 450,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children:[
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            element.tckStatId == 3
                                                ? StyleStatusTicket(title: 'تیکت بسته شده', textColor: Colors.red, icon: Icons.closed_caption_disabled,iconColor: Colors.red,)
                                                : element.tckStatId == 2
                                                ?
                                            StyleStatusTicket(title: ' در حال پاسخگویی', textColor: Colors.green, icon:Icons.question_answer,iconColor: Colors.green,)
                                                :
                                            StyleStatusTicket(title: '  در حال بررسی', textColor: Palette.primaryColorD, icon: Icons.pending,iconColor: Palette.primaryColorD,),

                                            StyleStatusTicket(title: element.prioTittle.toString(), textColor:Colors.black, icon: Icons.circle,iconColor:tckPriorityId==1?
                                            Palette.primaryColorD:tckPriorityId==2?Palette.accentColor:Palette.error,),

                                          ],
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              showModalBottomSheet(
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  isScrollControlled: true,
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder:
                                                            (context, setState) {
                                                          return UploadFileTicketing(
                                                              token!, element.tckId);
                                                        });
                                                  });
                                            },
                                            child: element.tckHasFile!
                                                ?
                                            StyleStatusTicket(title:"پیوست", textColor: Palette.primaryColorD, icon: Icons.attachment,iconColor:Colors.black,)
                                                : Text("")),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  element.newReplyCount! > 0
                      ? Visibility(
                    visible: true,
                    child: Badge(
                      badgeContent: Text(
                        element.newReplyCount.toString().toPersianDigit(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                      : Visibility(
                    visible: false,
                    child: Badge(
                      badgeContent: Text(
                        0.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
            // return Padding(
            //   padding: const EdgeInsets.only(top: 10),
            //   child: Stack(
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           Navigator.push(context,
            //               MaterialPageRoute(builder: (context) {
            //                 return ReplyTicket(
            //                   element.tckId!,
            //                   userRolId,
            //                   token,
            //                   element.statTittle.toString(),
            //                   element.tckTittle,
            //                   element.tckCreatedDate!,
            //                   tckStatId:element.tckStatId ,
            //                   tckPriorityId:element.tckPriorityId ,
            //                   prioTittle:element.prioTittle ,
            //                   bodyTicket: element.tckBody,);
            //               }));
            //         },
            //         child: Directionality(
            //           textDirection: TextDirection.rtl,
            //           child: Card(
            //             shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(5.0),
            //             ),
            //             elevation: 2.0,
            //             child: Column(
            //
            //               children: [
            //                 Container(
            //                   child: Column(
            //                     children: [
            //                       Padding(
            //                         padding: EdgeInsets.only(left: 6, right: 6),
            //                         child: Row(
            //                             mainAxisAlignment:
            //                             MainAxisAlignment.spaceBetween,
            //                             children: [
            //                         element.roleId==2
            //                         ?Text(
            //                         "دریافت شده از :",
            //                           style: const TextStyle(
            //                             fontSize: 12,
            //                             fontFamily: 'sans',
            //                             color: Palette.gradient2,
            //                           ),
            //                         ):
            //             Text("ارسال شده به :",
            //             style: const TextStyle(
            //               fontSize: 12,
            //               fontFamily: 'sans',
            //               color: Palette.gradient2,
            //             ),
            //           ),
            //                               element.tckStatId == 2
            //                                   ? Column(children: const [
            //                                 Text(
            //                                   "در حال پاسخگویی",
            //                                   style: TextStyle(
            //                                     fontSize: 8,
            //                                     fontFamily: 'sans',
            //                                     color: Colors.green,
            //                                   ),
            //                                 ),
            //                                 SizedBox(
            //                                   height: 3,
            //                                 ),
            //                                 SizedBox(
            //                                   height: 4,
            //                                   width: 36,
            //                                   child:
            //                                   LinearProgressIndicator(
            //                                     color:
            //                                     Palette.primaryColorD,
            //                                     backgroundColor: Palette
            //                                         .primaryColorGradientDark,
            //                                   ),
            //                                 )
            //                               ])
            //                                   : Column(children: const [
            //                                 Text(
            //                                   "در حال بررسی",
            //                                   style: TextStyle(
            //                                     fontSize: 8,
            //                                     fontFamily: 'sans',
            //                                     color: Colors.green,
            //                                   ),
            //                                 ),
            //                                 SizedBox(
            //                                   height: 3,
            //                                 ),
            //                                 SizedBox(
            //                                   height: 4,
            //                                   width: 36,
            //                                   child:
            //                                   LinearProgressIndicator(
            //                                     color:
            //                                     Palette.primaryColorD,
            //                                     backgroundColor: Palette
            //                                         .primaryColorGradientDark,
            //                                   ),
            //                                 )
            //                               ]),
            //                             ]),
            //                       ),
            //                       Directionality(
            //                         textDirection: TextDirection.rtl,
            //                         child: Container(
            //                           padding: const EdgeInsets.only(
            //                               left: 6, right: 6),
            //                           child: Align(
            //                             alignment: Alignment.topRight,
            //                             child: Text(
            //                               element.tckBody!,
            //                               style: const TextStyle(
            //                                 fontSize: 13,
            //                                 color: Colors.black,
            //                                 fontWeight: FontWeight.bold,
            //                                 fontFamily: 'sans',
            //                               ),
            //                             ),
            //                           ),
            //                         ),
            //                       ),
            //
            //                       Divider(),
            //                       Row(
            //                         mainAxisAlignment:
            //                         MainAxisAlignment.spaceBetween,
            //                         children: [
            //                           Padding(
            //                             padding: EdgeInsets.only(right: 6),
            //                             child: Text(
            //                               "شماره تیکت: " +
            //                                   element.tckId.toString(),
            //                               style: const TextStyle(
            //                                 fontSize: 12,
            //                                 fontFamily: 'sans',
            //                                 color: Palette.gradient2,
            //                               ),
            //                             ),
            //                           ),
            //                           GestureDetector(
            //                             onTap: () {
            //                               showModalBottomSheet(
            //                                   backgroundColor: Colors.transparent,
            //                                   isScrollControlled: true,
            //                                   context: context,
            //                                   builder: (BuildContext context) {
            //                                     return StatefulBuilder(builder: (context, setState) {
            //                                       return UploadFileTicketing(
            //                                           token!,
            //                                           element
            //                                               .tckId);
            //                                     });
            //                                   });
            //                             },
            //                             child:element.tckHasFile!? Container(
            //                               width: 80,
            //                               child: Align(
            //                                   alignment: Alignment.bottomLeft,
            //                                   child:
            //                                   Padding(padding: EdgeInsets.only(left: 4), child: Icon(
            //                                     Icons.upload_file,
            //                                     size: 22,
            //                                     color: Palette
            //                                         .bottomNavSelected,
            //                                   ))
            //                               ),
            //                             ):Text(""),
            //                           ),
            //                         ],
            //                       )
            //                     ],
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //
            //         ),
            //       ),
            //       element.newReplyCount! > 0
            //           ? Visibility(
            //         visible: true,
            //
            //         child: Badge(
            //           badgeContent: Text(
            //             element.newReplyCount.toString().toPersianDigit(),
            //             style: const TextStyle(color: Colors.white),
            //           ),
            //         ),
            //       )
            //           : Visibility(
            //         visible: false,
            //         child: Badge(
            //           badgeContent: Text(
            //             0.toString(),
            //             style: const TextStyle(color: Colors.white),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // );
          },
        );
      }


  }}
// class CloseTicketsView extends StatefulWidget {
//   const CloseTicketsView({Key? key}) : super(key: key);
//
//   @override
//   _CloseTicketsViewState createState() => _CloseTicketsViewState();
// }
//
// class _CloseTicketsViewState extends State<CloseTicketsView> {
//   GetListTicketing getListTicketing=Get.find<GetListTicketing>();
//   String? token=Get.find<ControllerGetStorageAllData>().token;
//   int? userRolId=Get.find<ControllerGetStorageAllData>().userRolId;
//   @override
//   Widget build(BuildContext context) {
//     if (getListTicketing.listCloseTicketing!.isEmpty)
//     {
//       return Center(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             const SizedBox(
//               height: 85,
//             ),
//             Image.asset(
//               "images/ticketnull.gif",
//               height: 85,
//               width: 85,
//             ),
//             const SizedBox(
//               height: 25,
//             ),
//             const Text(
//               'تیکت وجود ندارد ',
//               style: TextStyle(
//                 fontFamily: "sans",
//                 fontSize: 12,
//               ),
//             ),
//           ]));
//     } else{
//       return GroupedListView<DataTicket, String>(
//         shrinkWrap: true,
//         elements: widget.getListTicketing!,
//         controller: widget.scrollController,
//         physics: BouncingScrollPhysics(),
//
//         padding: const EdgeInsets.only(left: 8, right: 8),
//         groupBy: (element) => element.tckCreatedDate.toString().split(" ").first,
//         groupComparator: (value1, value2) => value2.compareTo(value1),
//         itemComparator: (item1, item2) =>
//             item1.tckBody!.compareTo(item2.tckBody!),
//         useStickyGroupSeparators: true,
//         stickyHeaderBackgroundColor: Colors.transparent,
//         groupSeparatorBuilder: (String value) =>
//             Padding(
//
//               padding: const EdgeInsets.only(top: 5.0, right: 20, left: 20),
//               child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 5, right: 5),
//                         child: Text(
//                           value.toPersianDate().toString(),
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                               fontSize: 12,
//                               fontFamily: 'sans',
//                               color: Colors.blueGrey),
//                         ),
//                       ),
//                     ),
//                   ]),
//             ),
//         itemBuilder: (c, element) {
//           int tckPriorityId=element.tckPriorityId as int;
//
//           String timeMinute= element.tckCreatedDate!.hour.toString()+":"+element.tckCreatedDate!.minute.toString();
//
//           return Padding(
//
//             padding: const EdgeInsets.only(top: 10),
//             child: Stack(
//               children: [
//                 Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                             return ReplyTicket(
//                               element.tckId!,
//                               userRolId,
//                               token,
//                               element.statTittle.toString(),
//                               element.tckTittle,
//                               element.tckCreatedDate!,
//                               tckStatId:element.tckStatId ,
//                               tckPriorityId:element.tckPriorityId ,
//                               prioTittle:element.prioTittle ,
//                               bodyTicket: element.tckBody,);
//                           }));
//                     },
//                     child: Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5.0),
//                       ),
//                       elevation: 4.0,
//                       child: Column(
//                         textDirection: TextDirection.rtl,
//                         children: [
//                           Container(
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: EdgeInsets.only(left: 6, right: 6),
//                                   child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.start,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Container(
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                                 children:[
//                                                   Container(
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                       MainAxisAlignment.start,
//                                                       children: [
//                                                         Icon(Icons.email_outlined,color: Palette.gradient2,size: 15,),
//                                                         SizedBox(width: 6,),
//                                                         Text(
//                                                           element.tckTittle.toString(),
//                                                           style: const TextStyle(
//                                                             fontSize: 12,
//                                                             fontFamily: 'sans',
//                                                             color: Palette.gradient2,
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.only(right: 6),
//                                                     child: Align(
//                                                       alignment: Alignment.topLeft,
//                                                       child: Text(
//                                                         timeMinute,
//                                                         style: const TextStyle(
//                                                           fontSize: 12,
//                                                           fontFamily: 'sans',
//                                                           color: Palette.gradient1,
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Directionality(
//                                               textDirection: TextDirection.rtl,
//                                               child: Container(
//                                                 width:320,
//                                                 child: Align(
//                                                   alignment: Alignment.topRight,
//                                                   child: Text(
//                                                     element.tckBody.toString(),
//                                                     maxLines: 1,
//                                                     overflow: TextOverflow.ellipsis,
//                                                     style: const TextStyle(
//                                                       fontSize: 13,
//                                                       color: Colors.black,
//                                                       fontWeight: FontWeight.bold,
//                                                       fontFamily: 'sans',
//                                                     ),
//                                                     textDirection: TextDirection.rtl,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Text(
//                                               "شماره تیکت: " +
//                                                   element.tckId.toString(),
//                                               style: const TextStyle(
//                                                 fontSize: 12,
//                                                 fontFamily: 'sans',
//                                                 color: Palette.gradient2,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//
//
//                                       ]),
//                                 ),
//
//                                 Divider(),
//                                 Container(
//                                   width: 450,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                     children:[
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.start,
//                                         children: [
//                                           element.tckStatId == 3
//                                               ? StyleStatusTicket(title: 'تیکت بسته شده', textColor: Colors.red, icon: Icons.closed_caption_disabled,iconColor: Colors.red,)
//                                               : element.tckStatId == 2
//                                               ?
//                                           StyleStatusTicket(title: ' در حال پاسخگویی', textColor: Colors.green, icon:Icons.question_answer,iconColor: Colors.green,)
//                                               :
//                                           StyleStatusTicket(title: '  در حال بررسی', textColor: Palette.primaryColorD, icon: Icons.pending,iconColor: Palette.primaryColorD,),
//
//                                           StyleStatusTicket(title: element.prioTittle.toString(), textColor:Colors.black, icon: Icons.circle,iconColor:tckPriorityId==1?
//                                           Palette.primaryColorD:tckPriorityId==2?Palette.accentColor:Palette.error,),
//
//                                         ],
//                                       ),
//                                       GestureDetector(
//                                           onTap: () {
//                                             showModalBottomSheet(
//                                                 backgroundColor:
//                                                 Colors.transparent,
//                                                 isScrollControlled: true,
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context) {
//                                                   return StatefulBuilder(
//                                                       builder:
//                                                           (context, setState) {
//                                                         return UploadFileTicketing(
//                                                             token!, element.tckId);
//                                                       });
//                                                 });
//                                           },
//                                           child: element.tckHasFile!
//                                               ?
//                                           StyleStatusTicket(title:"پیوست", textColor: Palette.primaryColorD, icon: Icons.attachment,iconColor:Colors.black,)
//                                               : Text("")),
//                                     ],
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 element.newReplyCount! > 0
//                     ? Visibility(
//                   visible: true,
//                   child: Badge(
//                     badgeContent: Text(
//                       element.newReplyCount.toString().toPersianDigit(),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 )
//                     : Visibility(
//                   visible: false,
//                   child: Badge(
//                     badgeContent: Text(
//                       0.toString(),
//                       style: const TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//           // return Padding(
//           //   padding: const EdgeInsets.only(top: 10),
//           //   child: Stack(
//           //     children: [
//           //       GestureDetector(
//           //         onTap: () {
//           //           Navigator.push(context,
//           //               MaterialPageRoute(builder: (context) {
//           //                 return ReplyTicket(
//           //                   element.tckId!,
//           //                   userRolId,
//           //                   token,
//           //                   element.statTittle.toString(),
//           //                   element.tckTittle,
//           //                   element.tckCreatedDate!,
//           //                   tckStatId:element.tckStatId ,
//           //                   tckPriorityId:element.tckPriorityId ,
//           //                   prioTittle:element.prioTittle ,
//           //                   bodyTicket: element.tckBody,);
//           //               }));
//           //         },
//           //         child: Directionality(
//           //           textDirection: TextDirection.rtl,
//           //           child: Card(
//           //             shape: RoundedRectangleBorder(
//           //               borderRadius: BorderRadius.circular(5.0),
//           //             ),
//           //             elevation: 2.0,
//           //             child: Column(
//           //
//           //               children: [
//           //                 Container(
//           //                   child: Column(
//           //                     children: [
//           //                       Padding(
//           //                         padding: EdgeInsets.only(left: 6, right: 6),
//           //                         child: Row(
//           //                             mainAxisAlignment:
//           //                             MainAxisAlignment.spaceBetween,
//           //                             children: [
//           //                         element.roleId==2
//           //                         ?Text(
//           //                         "دریافت شده از :",
//           //                           style: const TextStyle(
//           //                             fontSize: 12,
//           //                             fontFamily: 'sans',
//           //                             color: Palette.gradient2,
//           //                           ),
//           //                         ):
//           //             Text("ارسال شده به :",
//           //             style: const TextStyle(
//           //               fontSize: 12,
//           //               fontFamily: 'sans',
//           //               color: Palette.gradient2,
//           //             ),
//           //           ),
//           //                               element.tckStatId == 2
//           //                                   ? Column(children: const [
//           //                                 Text(
//           //                                   "در حال پاسخگویی",
//           //                                   style: TextStyle(
//           //                                     fontSize: 8,
//           //                                     fontFamily: 'sans',
//           //                                     color: Colors.green,
//           //                                   ),
//           //                                 ),
//           //                                 SizedBox(
//           //                                   height: 3,
//           //                                 ),
//           //                                 SizedBox(
//           //                                   height: 4,
//           //                                   width: 36,
//           //                                   child:
//           //                                   LinearProgressIndicator(
//           //                                     color:
//           //                                     Palette.primaryColorD,
//           //                                     backgroundColor: Palette
//           //                                         .primaryColorGradientDark,
//           //                                   ),
//           //                                 )
//           //                               ])
//           //                                   : Column(children: const [
//           //                                 Text(
//           //                                   "در حال بررسی",
//           //                                   style: TextStyle(
//           //                                     fontSize: 8,
//           //                                     fontFamily: 'sans',
//           //                                     color: Colors.green,
//           //                                   ),
//           //                                 ),
//           //                                 SizedBox(
//           //                                   height: 3,
//           //                                 ),
//           //                                 SizedBox(
//           //                                   height: 4,
//           //                                   width: 36,
//           //                                   child:
//           //                                   LinearProgressIndicator(
//           //                                     color:
//           //                                     Palette.primaryColorD,
//           //                                     backgroundColor: Palette
//           //                                         .primaryColorGradientDark,
//           //                                   ),
//           //                                 )
//           //                               ]),
//           //                             ]),
//           //                       ),
//           //                       Directionality(
//           //                         textDirection: TextDirection.rtl,
//           //                         child: Container(
//           //                           padding: const EdgeInsets.only(
//           //                               left: 6, right: 6),
//           //                           child: Align(
//           //                             alignment: Alignment.topRight,
//           //                             child: Text(
//           //                               element.tckBody!,
//           //                               style: const TextStyle(
//           //                                 fontSize: 13,
//           //                                 color: Colors.black,
//           //                                 fontWeight: FontWeight.bold,
//           //                                 fontFamily: 'sans',
//           //                               ),
//           //                             ),
//           //                           ),
//           //                         ),
//           //                       ),
//           //
//           //                       Divider(),
//           //                       Row(
//           //                         mainAxisAlignment:
//           //                         MainAxisAlignment.spaceBetween,
//           //                         children: [
//           //                           Padding(
//           //                             padding: EdgeInsets.only(right: 6),
//           //                             child: Text(
//           //                               "شماره تیکت: " +
//           //                                   element.tckId.toString(),
//           //                               style: const TextStyle(
//           //                                 fontSize: 12,
//           //                                 fontFamily: 'sans',
//           //                                 color: Palette.gradient2,
//           //                               ),
//           //                             ),
//           //                           ),
//           //                           GestureDetector(
//           //                             onTap: () {
//           //                               showModalBottomSheet(
//           //                                   backgroundColor: Colors.transparent,
//           //                                   isScrollControlled: true,
//           //                                   context: context,
//           //                                   builder: (BuildContext context) {
//           //                                     return StatefulBuilder(builder: (context, setState) {
//           //                                       return UploadFileTicketing(
//           //                                           token!,
//           //                                           element
//           //                                               .tckId);
//           //                                     });
//           //                                   });
//           //                             },
//           //                             child:element.tckHasFile!? Container(
//           //                               width: 80,
//           //                               child: Align(
//           //                                   alignment: Alignment.bottomLeft,
//           //                                   child:
//           //                                   Padding(padding: EdgeInsets.only(left: 4), child: Icon(
//           //                                     Icons.upload_file,
//           //                                     size: 22,
//           //                                     color: Palette
//           //                                         .bottomNavSelected,
//           //                                   ))
//           //                               ),
//           //                             ):Text(""),
//           //                           ),
//           //                         ],
//           //                       )
//           //                     ],
//           //                   ),
//           //                 ),
//           //               ],
//           //             ),
//           //           ),
//           //
//           //         ),
//           //       ),
//           //       element.newReplyCount! > 0
//           //           ? Visibility(
//           //         visible: true,
//           //
//           //         child: Badge(
//           //           badgeContent: Text(
//           //             element.newReplyCount.toString().toPersianDigit(),
//           //             style: const TextStyle(color: Colors.white),
//           //           ),
//           //         ),
//           //       )
//           //           : Visibility(
//           //         visible: false,
//           //         child: Badge(
//           //           badgeContent: Text(
//           //             0.toString(),
//           //             style: const TextStyle(color: Colors.white),
//           //           ),
//           //         ),
//           //       ),
//           //     ],
//           //   ),
//           // );
//         },
//       );
//     }
//
//
//   }}
