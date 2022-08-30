import 'package:app_karada24/screen/chat_page/chat_page.dart';
import 'package:app_karada24/screen/chat_page/database/message_database.dart';
import 'package:app_karada24/screen/ticketpages/all_received_ticket.dart';
import 'package:app_karada24/screen/ticketpages/test_file.dart';
import 'package:flutter/material.dart';
import 'package:app_karada24/getxController/list_ticket.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/screen/ticketpages/send_ticket.dart';
import 'package:app_karada24/screen/ticketpages/all_tickets.dart';
import 'package:app_karada24/screen/ticketpages/close_tickets.dart';
import 'package:app_karada24/screen/ticketpages/open_ticket.dart';
import 'package:get/get.dart';
import '../../getxController/storagedata/StrorageAllData.dart';
import '../../response/response_list_tickets.dart';
import '../../widgets/shimmer_load.dart';
import '../../widgets/tickets/search_ticket.dart';
import '../../widgets/tickets/pop_menu_filter.dart';
import '../../widgets/widget_errorpage.dart';


class TicketPage extends StatefulWidget {

  const TicketPage({Key? key}) : super(key: key);

  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  ScrollController _scrollController=ScrollController();
  bool isFAB=false;

  String? token=Get.find<ControllerGetStorageAllData>().token;
  int? userRolId=Get.find<ControllerGetStorageAllData>().userRolId;
  GetListTicketing getListTicketing=Get.find<GetListTicketing>();
  late List<DataTicket>? fListTicketsSending=Get.find<GetListTicketing>().listSendingTicketing;
  late List<DataTicket>? fListTicketsReceived=Get.find<GetListTicketing>().listReceiveTicketing;
  late List<DataTicket>? fListOpenTickets=Get.find<GetListTicketing>().listOpenTicketing;
  late List<DataTicket>? fListCloseTickets=Get.find<GetListTicketing>().listCloseTicketing;
  int? IsRolId=Get.find<ControllerGetStorageAllData>().IsRolId;
  String query = '';
  bool ticketSending=false;
  @override
  Widget build(BuildContext context) {
    print("IsRolId "+IsRolId.toString());
    print("userRolId "+userRolId.toString());
    return Obx((){
      if(query.isEmpty){
        fListTicketsSending=Get.find<GetListTicketing>().listSendingTicketing;
        fListTicketsReceived=Get.find<GetListTicketing>().listReceiveTicketing;
      fListOpenTickets=Get.find<GetListTicketing>().listOpenTicketing;
      fListCloseTickets=Get.find<GetListTicketing>().listCloseTicketing;
      }

      return Scaffold(
        backgroundColor: Palette.backGroundColorD,
        appBar: AppBar(
          toolbarHeight:40,
          backgroundColor: Palette.bottomNavUnBack,
          bottom: TabBar(
            labelColor: Colors.black,
            controller: _tabController,
            indicatorColor: Palette.primaryColorD,
            labelStyle: TextStyle(fontFamily: "sans", fontSize: 12),
            tabs: [
             // Text("تيکتهاي بسته"),
              IsRolId==3 ?Text("تیکتهای دریافتی"):Text("تیکتهای باز"),
         Text("تیکتهای ارسال شده"),

            ],
          ),
          actions: [
            SizedBox(width: 10,),
            Center(child: SearchTickets(text: query,onChanged: searchTickets, hintText: 'عنوان تیکت',),),
            // SizedBox(width: 10,),
            // IsRolId==3?
            // PopupMenuFilter(onChanged: (String value) {
            //   if(value.toString().trim().contains("filterSend")){
            //     setState(() {
            //       ticketSending=true;
            //       print(value);
            //     });
            //   }else if(value.toString().trim().contains("filterReceived")){
            //     setState(() {
            //       ticketSending=false;
            //     });
            //   }
            //   print(value);
            // },ticketSending:ticketSending ,):SizedBox(),
            // SizedBox(width: 10,),
          ],
        ),

        body: getListTicketing.isLoading.value==false?
        TabBarView(controller: _tabController,
            children: [
              IsRolId==3?AllReceivedTickets(scrollController: _scrollController, getListTicketing:fListTicketsReceived,): OpenTickets(scrollController: _scrollController, getListTicketing:fListOpenTickets,),
              AllSendingTickets(scrollController: _scrollController, getListTicketing:fListTicketsSending,)
            ]):getListTicketing.errorPage.value==false?CustomShimmerWidgetTicket():ErrorPage(),
        floatingActionButton:isFAB?
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
          width: 50,
          height: 50,
          child: FloatingActionButton.extended(
            onPressed: () {
              showDialog();
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Icon( Icons.edit,size: 16),
            ),
            label: SizedBox(),
            backgroundColor: Palette.primaryColorD,
          ),
        ):AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.linear,
          width: 110,
          height: 50,
          child: FloatingActionButton.extended(
            onPressed: () {
              showDialog();
            },
            icon: Icon(Icons.edit,size: 16,),
            label: Center(
              child: Text(
                "تيکت جديد",
                style: TextStyle(fontSize: 10, color: Colors.white,fontFamily: "sans"),
              ),
            ),
            backgroundColor: Palette.primaryColorD,
          ),
        ),
      );

    }
    );
  }
  void showDialog() {

        Navigator.push(context,
        MaterialPageRoute(builder: (builder) => ChatPage()));
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return SendTicket();
    // })).then((value) =>   Get.find<GetListTicketing>().fetchListTicketing(userRolId!, token!));
  }
  @override
  void initState() {
    Get.find<GetListTicketing>().fetchListTicketing(userRolId!, token!);
    _tabController = TabController(length: 2, vsync: this, initialIndex:1 );
    // fListTickets = _setData();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50) {
        setState(() {
          isFAB = true;
        });
      } else {
        setState(() {
          isFAB = false;
        });
      }
    });
    super.initState();
  }

  void snackError(BuildContext context, String str) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(
            width: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              str,
              style: const TextStyle(fontSize: 12, fontFamily: 'sans'),
            ),
          )
        ],
      ),
      backgroundColor: Palette.error,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void searchTickets(String query) {
    if (query.isEmpty) {

      setState(() {
        this.query = query;
        Get.find<GetListTicketing>().fetchListTicketing(userRolId!, token!);
        fListTicketsSending=Get.find<GetListTicketing>().listSendingTicketing;
        fListOpenTickets=Get.find<GetListTicketing>().listOpenTicketing;
        fListTicketsReceived=Get.find<GetListTicketing>().listReceiveTicketing;
      });
    } else {
      final requests =  fListTicketsSending?.where((element) {
        final titleLowerCase = element.tckTittle?.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return titleLowerCase?.contains(searchLowerCase) as bool;
      }).toList();
      final requestsOpenTicket =  fListOpenTickets?.where((element) {
        final titleLowerCase = element.tckTittle?.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return titleLowerCase?.contains(searchLowerCase) as bool;
      }).toList();
      final requestFListTicketsReceived =  fListTicketsReceived?.where((element) {
        final titleLowerCase = element.tckTittle?.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return titleLowerCase?.contains(searchLowerCase) as bool;
      }).toList();
      setState(() {
        this.query = query;
        fListTicketsReceived = requestFListTicketsReceived;
        fListOpenTickets = requestsOpenTicket;
        fListTicketsSending = requests;
      });
    }
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    //_scrollController.dispose();
  }
}