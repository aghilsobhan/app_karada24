import 'package:app_karada24/getxController/check_badge_tickets.dart';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/response/chat/response_get_contact.dart';
import 'package:app_karada24/screen/chat_page/customui/individual_page.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class CustomCard extends StatefulWidget {
  const CustomCard(
      { Key? key, required this.dataContactChat})
      : super(key: key);
  final DataContactChat dataContactChat;

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  GetBadge getBadge = Get.find<GetBadge>();
  String? newTextMessage="is not";
  @override
  Widget build(BuildContext context) {
    int? userRolId = Get
        .find<ControllerGetStorageAllData>()
        .userRolId;
    var sendDate = DateTime.now();
    String time = DateFormat('kk:mm').format(sendDate);
    return Obx(() {

      for (int i = 0; i < getBadge.badgeNew.length; i++) {
        if (getBadge.badgeNew[i].senderId ==
            widget.dataContactChat.userId) {
          widget.dataContactChat.newMessage!
              .add(getBadge.badgeNew[i]);
          newTextMessage=getBadge.badgeNew[i].content;
        }
      }
      print( "Obx "+widget.dataContactChat.newMessage!.toString());
      return InkWell(
        onTap: () {
          print( "InkWell "+widget.dataContactChat.newMessage!.toString());
          getBadge.badgeNew.removeWhere((element) =>element.senderId== widget.dataContactChat);
          getBadge.update();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) =>
                      IndividualPage(dataContactChat: widget.dataContactChat)));
        },
        child: Directionality(
          textDirection: ui.TextDirection.rtl,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage(
                    "images/peyma.jpg",
                  ),
                  backgroundColor: Colors.transparent,
                ),
                title: Text(
                  widget.dataContactChat.fullname.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: "sans",
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                     newTextMessage.toString(),
                       style: TextStyle(
                        fontSize: 12,
                        fontFamily: "sans",
                      ),
                    ),
                  ],
                ),
                trailing:
                Column(
                  children: [
                    Text(
                      time, style: TextStyle(
                        fontSize: 12,
                        fontFamily: "sans",
                        color: Palette.gradient2
                    ),
                    ),

                    widget.dataContactChat.newMessage!.length!=0?    Badge(
                      badgeContent: Text(
                       widget.dataContactChat.newMessage!.length.toString(),
                        style: const TextStyle(color: Colors.white,fontSize: 10,),
                      ),
                      badgeColor: Palette.primaryColorD,
                    ):SizedBox(),

                  ],
                ),


              ),
              Padding(
                padding: const EdgeInsets.only(right: 80, left: 10),
                child: Divider(
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}