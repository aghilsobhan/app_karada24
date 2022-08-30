import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/screen/ticketpages/open_ticket.dart';
import 'package:get/get.dart';

import 'package:persian_number_utility/persian_number_utility.dart';

import '../../apiService/api_service_listtickets.dart';
import '../../getxController/list_ticket.dart';
import '../../materialcolors/materialcolors.dart';
import '../../response/response_list_tickets.dart';
import '../../utility/shared_preferences_token.dart';
class OpenTicketView extends StatefulWidget {
  OpenTicketView({Key? key}) : super(key: key);
  @override
  _OpenTicketViewState createState() => _OpenTicketViewState();
}

class _OpenTicketViewState extends State<OpenTicketView> {
  late Future<void> fListTickets;
  bool loading = true;
  late String token = "";
  late int userId;
  late List<DataTicket>? listOpenTicketing=Get.find<GetListTicketing>().listOpenTicketing;
  late String refreshToken;
  ScrollController _scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backGroundColorD,
      body:SingleChildScrollView(
        child: Column(
          children: [
            OpenTickets(scrollController: _scrollController, getListTicketing:listOpenTicketing,)
          ],
        ),
      ),
      //AllTickets(scrollController: _scrollController,) ,
      appBar: AppBar(
        backgroundColor: Palette.bottomNavUnBack,
        toolbarHeight: 40.0,
        leadingWidth: 40,// double
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: EdgeInsets.all(6),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width:30,
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
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 6),
              child: Align(alignment: Alignment.center,
                  child: Text("تیکتهای باز",
                    style: TextStyle(color: Colors.black,
                        fontFamily: "sans",
                        fontWeight: FontWeight.bold),
                  )
              )
          )
        ],
      ),
    );
  }
}
