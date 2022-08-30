import 'package:app_karada24/screen/requests/component/search_request.dart';
import 'package:app_karada24/screen/ticketpages/widget_ticket.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../getxController/list_ticket.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
import '../../materialcolors/materialcolors.dart';
import '../../response/response_list_tickets.dart';
import '../../widgets/tickets/search_ticket.dart';
import '../requests/component/widget_filter.dart';
import 'reply_ticket.dart';
import 'upload_file_ticketing.dart';
class AllReceivedTickets extends StatefulWidget {
  final ScrollController scrollController;
  final List<DataTicket>? getListTicketing;
  AllReceivedTickets({Key? key, required this.scrollController, required this.getListTicketing}) : super(key: key);

  @override
  _AllReceivedTicketsState createState() => _AllReceivedTicketsState();
}

class _AllReceivedTicketsState extends State<AllReceivedTickets> {

  String? token = Get.find<ControllerGetStorageAllData>().token;
  int? userRolId = Get.find<ControllerGetStorageAllData>().userRolId;
  @override
  Widget build(BuildContext context) {
    if (widget.getListTicketing!.isEmpty) {
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
    } else {
      return GroupedListView<DataTicket, String>(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        controller: widget.scrollController,
        padding: const EdgeInsets.only(left: 8, right: 8),
        elements: widget.getListTicketing!,
        groupBy: (element) => element.tckCreatedDate.toString().split(" ").first,
        groupComparator:  (value1, value2)=>value2.compareTo(value1),
        itemComparator: (item1, item2) =>
            item1.tckBody!.compareTo(item2.tckBody!),
        useStickyGroupSeparators: true,
        stickyHeaderBackgroundColor: Colors.transparent,

        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.only(top: 5.0),
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
                      value.toPersianDate(),
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
          String date=element.tckCreatedDate.toString();
          List<String> dt=date.split(" ");
          List<String> time=dt[1].split(".");
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
                                        CircleAvatar(
                                          radius: 20.0,
                                          backgroundImage: AssetImage(
                                            "images/profile.png",
                                          ),
                                          backgroundColor: Colors.transparent,
                                        ),
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
                                                  Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      time[0],
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'sans',
                                                        color: Palette.gradient1,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Container(
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

                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children:[
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [


                                          StyleStatusTicket(title:element.ownerFullname.toString(), textColor: Palette.primaryColorD, icon: Icons.person,iconColor:Colors.black,),

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
        },
      );
    }
  }
}