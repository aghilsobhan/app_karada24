import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../getxController/list_ticket.dart';
import '../../materialcolors/materialcolors.dart';
import '../../response/response_list_tickets.dart';
import 'all_tickets.dart';
class AllTicketView extends StatefulWidget {

   AllTicketView({Key? key}) : super(key: key);
  @override
  _AllTicketViewState createState() => _AllTicketViewState();
}

class _AllTicketViewState extends State<AllTicketView> {
  late Future<void> fListTickets;
  bool loading = true;
  late String token = "";
  late int userId;
  late List<DataTicket>? fListTicketsSending=Get.find<GetListTicketing>().listSendingTicketing;

  late String refreshToken;
  ScrollController _scrollController=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backGroundColorD,
      body:SingleChildScrollView(
        child: Column(
          children: [
            AllSendingTickets(scrollController: _scrollController, getListTicketing:fListTicketsSending,)
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
                  child: Text("همه تیکتها ارسالی",
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
