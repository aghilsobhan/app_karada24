import 'dart:async';
import 'package:app_karada24/screen/chat_page/controller/chat_controller.dart';
import 'package:app_karada24/screen/chat_page/database/message_database.dart';
import 'package:app_karada24/value/const_string.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_karada24/Dashboard/categories.dart';
import 'package:app_karada24/getxController/storagedata/StrorageAllData.dart';
import 'package:app_karada24/materialcolors/materialcolors.dart';
import 'package:app_karada24/screen/mainpage/drawer_widget.dart';
import 'package:app_karada24/widgets/show_toast.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../getxController/check_badge_tickets.dart';
import '../getxController/list_ticket.dart';
import '../screen/help/help.dart';
import '../screen/mainpage/profile.dart';
import '../screen/requests/request.dart';
import '../screen/ticketpages/ticket_page.dart';
import '../utility/luch_url.dart';
import '../utility/notification.dart';

var styleTex =
    const TextStyle(color: Palette.textColor, fontFamily: 'sans', fontSize: 16);
class MenuDashboardT extends StatefulWidget {
  MenuDashboardT( {Key? key}) : super(key: key);

  @override
  _MenuDashboardState createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboardT>
    with SingleTickerProviderStateMixin {
  bool boolPage = false;
  late String messageNotification;
  String? username = Get.find<ControllerGetStorageAllData>().userName;
  GetListTicketing getListTicketing=Get.find<GetListTicketing>();
  DateTime pre_backpress = DateTime.now();
  DateTime? backPressButtonTime;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  static int _page = 3;
  late Widget showPage = Column(
    children: <Widget>[
      const SizedBox(
        height: 10,
      ),
          Categories()
    ],
  );

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));

    var scaffoldKey = GlobalKey<ScaffoldState>();
    return WillPopScope(

        child: Scaffold(
          backgroundColor: Palette.backGroundColorD,
          key: scaffoldKey,
          body: showPage,
          appBar:!boolPage
              ? AppBar(
            centerTitle: true,
            title: GestureDetector(
              onTap: () async {
               // Get.find<ChatController>().connect();
                launchURL('https://phx.ir/');
              },
              child: Image.asset(
                "images/ghoghnoos.jpg",
                height: 35,
                width: 120,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            leading: boxOutput(),
            leadingWidth: 400,
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.menu_open,
                  color: Colors.black,
                ),
                tooltip:
                MaterialLocalizations.of(context).openAppDrawerTooltip,
                onPressed: () {
                  scaffoldKey.currentState?.openEndDrawer();
                },
              ),
            ],
          )
              : null,
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.help,
                  ),
                  label: "راهنما"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person_add_alt_1_sharp,
                  ),
                  label: "درخواستها"),
              BottomNavigationBarItem(
                  icon: Stack(
                      children: <Widget>[
                         Icon( Icons.question_answer,),
                        Obx((){
                          return  Get.find<GetBadge>().isBadge.value==true?
                          Positioned(  // draw a red marble
                            top: 0.0,
                            right: 0.0,
                            child:  Icon(Icons.brightness_1, size: 8.0,
                                color: Colors.redAccent),
                          ):Positioned(  // draw a red marble
                            top: 0.0,
                            right: 0.0,
                            child:  Icon(Icons.brightness_1, size: 0.0,
                                color: Colors.redAccent),
                          );
                        })
                      ]
                  ),

                  label: "تیکت"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "خانه"),
            ],
            type: BottomNavigationBarType.fixed,
            backgroundColor: Palette.bottomNavUnBack,
            unselectedLabelStyle: TextStyle(
                fontSize: 12,
                fontFamily: 'sans',
                color: Palette.bottomNavUnSelected),
            selectedLabelStyle: TextStyle(
                fontSize: 12,
                fontFamily: 'sans',
                fontWeight: FontWeight.bold,
                color: Palette.primaryColorD),
            elevation: 0.1,
            selectedIconTheme:
                IconThemeData(color: Palette.primaryColorD, size: 25),
            unselectedIconTheme:
                IconThemeData(color: Palette.bottomNavUnSelected),
            selectedItemColor: Palette.primaryColorD,
            currentIndex: _page,
            onTap: (index) {
              setState(() {
                print(index);
                 showPage = _pageChooser(index);
              });
            },
          ),
          endDrawer: DrawerWidget( ),
            endDrawerEnableOpenDragGesture: false,
        ),
        onWillPop:()async{
          final difference=DateTime.now().difference(pre_backpress);
          final isExitWarning=difference>=Duration(seconds: 2);
          pre_backpress=DateTime.now();
          if(isExitWarning){
            showToastExit(context, "برای خروج دوبار کلیک کنید");
            return false;
          }
          return true;
        },
    );
  }
  Widget _pageChooser(int page) {
    setState(() {
      _page = page;
    });
    if (page == 3) {
      setState(() {
        boolPage = false;
      });
      return Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          //const SearchBox(),
         Categories()

        ],
      );
    } else if (page == 2) {
      setState(() {
        boolPage = true;
      });
      return TicketPage();
    }
    if (page == 1) {
      setState(() {
        boolPage = true;
      });
      return Request();
    } else if (page == 0) {
      setState(() {
        boolPage = true;
      });
      return Help();
    } else {
      setState(() {
        boolPage = false;
      });
      return Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          //const SearchBox(),
          Categories()
        ],
      );
    }
  }

  @override
  void initState() {
    print("initState()");
    notificationApi.setOnNotificationClick(onNotificationClick);
    _requestPermissions();
    initRabbitMq(Get.find<ControllerGetStorageAllData>().userName);

   MessageDataBase.instance;
    super.initState();
  }
  onNotificationClick(String? payload) {
  setState(() {
    showPage = _pageChooser(3);
  });
  }

  Future onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) {
        return new AlertDialog(
          title: Text("PayLoad"),
          content: Text("Payload : $payload"),
        );
      },
    );
  }
  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  void initRabbitMq(String? str) async {
    try {
      Client _client = Client();
      Channel _channel;
      print("Received string: $str");
      ConnectionSettings?   settings = await ConnectionSettings(
        host: "194.59.171.30",
        reconnectWaitTime: Duration(milliseconds: 5000),
        authProvider: const PlainAuthenticator("test", "test"),);
      _client = Client(settings: settings);
      _channel = await _client.channel();
      // auto-connect to localhost:5672 using guest credentials
      Exchange exchange =
      await _channel.exchange("crm-exchange", ExchangeType.TOPIC);
      Queue queue = await _channel.queue("crm." + str!, durable: true);
      Consumer consumer = await queue.consume();
      queue.bind(exchange, str);
      print("Received string: $consumer");

      consumer.listen((AmqpMessage message) {
        // Get the payload as a string
        //  print("  Received string: ${message.payloadAsString}");
        //msga = message.payloadAsString;
        messageNotification = message.payloadAsString;
        print("Received string: $messageNotification");
        notificationApi.showNotification(0, "پیام جدید:", messageNotification, str);
        //  message.reply("world");
      });
    } catch (e) {
      print("initRabbitMq" + e.toString());
    }
  }
  boxOutput() {
      return GestureDetector(
        onTap: () {
          Get.find<ChatController>().hubConnection=null;
          // showModalBottomSheet(
          //     backgroundColor: Colors.transparent,
          //     isScrollControlled: true,
          //     context: context,
          //     builder: (BuildContext context) {
          //       return StatefulBuilder(builder: (context, setState) {
          //         return Profile();
          //       });
          //     });
        },
        child: Container(
          margin: const EdgeInsets.only(left: 8, top: 15.0, bottom: 15),
          padding: const EdgeInsets.only(left: 6, right: 6),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
              bottomLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
            gradient: LinearGradient(
                begin: Alignment(0.8185951709747314, 0.45850691199302673),
                end: Alignment(-0.45850691199302673, 0.3032980263233185),
                colors: [
                  Palette.primaryColorGradientDark,
                  Palette.primaryColorD
                ]),
          ),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Padding(
                padding: EdgeInsets.only(bottom: 1.0),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 20,
                )),
            SizedBox(width: 8),
            Text(
              username.toString(),
              style: TextStyle(
                  fontFamily: "sans", fontSize: 10, color: Colors.white),
            ),
          ]),
        ),
      );
    }



}
