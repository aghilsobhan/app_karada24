import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/screen/chat_page/customui/tab_group_chat.dart';
import 'package:app_karada24/screen/chat_page/customui/tab_list_contact.dart';
import 'package:app_karada24/screen/chat_page/customui/tab_private_chat.dart';
import 'package:app_karada24/screen/chat_page/database/message_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/chat_controller.dart';

class ChatPage extends StatefulWidget {

  ChatPage({Key? key}) : super(key: key);


  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  late TabController _tabController;
  ChatController chatController = Get.find<ChatController>();
  final _tabs = [
    Tab(text: 'گروه ها'),
   // Tab(text: 'خصوصی'),
    Tab(text: 'مخاطبین'),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isConnect= chatController.status.value.toString().contains("success")?"آنلاین"
          :chatController.status.value.toString().contains("reconnection")?"...در حال برقراری ارتباط":"اتصال برقرار نیست";
      return Scaffold(
          backgroundColor: Palette.backGroundColorD,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Palette.primaryColorD,
            centerTitle: true,
            title: Text(isConnect,style: TextStyle(fontFamily: "sans",fontSize: 15),),
            toolbarHeight: 45,
            bottom: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  color: Palette.backGroundColorD),
              labelColor: Colors.black,
              labelStyle: TextStyle(fontFamily: "sans", fontSize: 12),
              unselectedLabelColor: Palette.backGroundColorD,
              tabs: _tabs,),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Palette.primaryColorD,
            onPressed: () {
              MessageDataBase.instance.delete();
              // connect().then((value) {
              //   print("valy");
              // });
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (builder) => SelectContact()));
            },
            child: Icon(
              Icons.chat,
              color: Colors.white,
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              TabGroupChat(),
             // TabPrivateChat(),
              TabListContact(),
            ],)
      );
    });
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    Get.find<ChatController>().connect();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}


